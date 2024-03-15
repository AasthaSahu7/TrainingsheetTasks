public class StudentHelper {
    public static void callTrigger(List<Student__c> newStudList , Map<Id, Student__c> oldMap){
        List<Student_History__c> studentHistoryRecords = new List<Student_History__c>();
        Map<String, Schema.SObjectField> fieldMap = Student__c.SObjectType.getDescribe().fields.getMap();
        for (Student__c newStudent :  newStudList) {
            Student__c oldStudent = oldMap.get(newStudent.Id);
            for (String fieldName : fieldMap.keySet()) {
                if (fieldMap.get(fieldName).getDescribe().isUpdateable() &&
                    oldStudent != null && oldStudent.get(fieldName) != newStudent.get(fieldName)) {
                        studentHistoryRecords.add(new Student_History__c(
                            FieldName__c = fieldName,
                            OldValue__c = String.valueOf(oldStudent.get(fieldName)),
                            NewValue__c = String.valueOf(newStudent.get(fieldName)),
                            Record_Id__c = newStudent.Id,
                            Student__c = oldStudent.Id,
                            Name = newStudent.Name
                        ));
                    }
            }
        }
        if (!studentHistoryRecords.isEmpty()) {
            insert studentHistoryRecords;
        }
    }
}