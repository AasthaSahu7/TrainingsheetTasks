public class InstituteAuraController {
@AuraEnabled
    public static List<Institute2__c> getInstitutes(){
        
        return  [SELECT  Name FROM Institute2__c];
}
    @AuraEnabled
      public static List<Mentor2__c> getMentors(Id instituteId){
       //(recordId);
        return [SELECT StudentsNumber__c,Designation__c, Name__c FROM Mentor2__c WHERE Institute2__c =: instituteId];
    }
    
     @AuraEnabled
   public static List<Student__c> studentTable(String selectedMentor) {
       List<Student__c> studentRecords = [SELECT Name, Class__c, City__c FROM Student__c WHERE Mentor2__c = :selectedMentor];
            return studentRecords;
    }
}