trigger TriggerOnNumberOfStudents on Student__c (after insert, after delete) {
    Map<Id, Integer> studentCountMap = new Map<Id, Integer>();
    
    // Process insert records
    if (Trigger.isInsert) {
        for (Student__c student : Trigger.new) {
            Id mentorId = student.Mentor2__c;

                studentCountMap.put(mentorId, 0);
        }
    }
    
    if (Trigger.isDelete) {
        for (Student__c student : Trigger.old) {
            Id mentorId = student.Mentor2__c;

                studentCountMap.put(mentorId, 0);
            System.debug(mentorId);
            }
        }
    
List<AggregateResult> studentList = [SELECT Count(Id)totalStudents, Mentor2__c  FROM Student__c  WHERE Mentor2__c =:studentCountMap.keySet() GROUP BY Mentor2__c];
    for(AggregateResult result:studentList){
        Id mentorId = (Id)result.get('Mentor2__c');
        Integer numOfStd = (Integer)result.get('totalStudents');
        System.debug(numOfStd);
        studentCountMap.put(mentorId,numOfStd);
    }
    List<Mentor2__c> mentorsToUpdate = [SELECT Id,StudentsNumber__c FROM Mentor2__c WHERE Id =:studentCountMap.keySet()];
    for(Mentor2__c mentor : mentorsToUpdate){
        mentor.StudentsNumber__c =studentCountMap.get(mentor.Id);
        System.debug(mentor.StudentsNumber__c);
    }
    if(!mentorsToUpdate.isEmpty()){
        update mentorsToUpdate;
        System.debug(mentorsToUpdate);
    }
}