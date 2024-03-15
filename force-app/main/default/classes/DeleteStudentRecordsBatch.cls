global class DeleteStudentRecordsBatch implements Database.Batchable<sObject>, Schedulable{
    
    /**
    * Number of students marked for deletion for each creator
    */
    private Map<Id, Integer> creatorDeletedCount = new Map<Id, Integer>();
    
    /**
    * description: this method  query the records from the database
    * params : Database.BatchableContext context
    * returns : Returns the records fetched by the query
    **/
    global Database.QueryLocator start(Database.BatchableContext context){
        return Database.getQueryLocator([SELECT Id, Mark_Delete__c, Registration_Completed__c, CreatedById FROM Student__c 
                                         WHERE CreatedDate = Last_N_Days:2 AND CreatedDate != LAST_N_DAYS:1]);
    }
    
    /**
    * description: this method  checks for the conditions and updates the studentList
    * params : Database.BatchableContext contex ,  List<Student__c> studentList
    * returns : Returns the records in the studentList and the count of the deletedStudents
    **/
    global void execute(Database.BatchableContext context, List<Student__c> studentList){
        Map<Id, List<Student__c>> studentsByCreator = new Map<Id, List<Student__c>>();
        
        // Group students by creator
        for(Student__c student : studentList){
            if (!studentsByCreator.containsKey(student.CreatedById)) {
                studentsByCreator.put(student.CreatedById, new List<Student__c>());
            }
            studentsByCreator.get(student.CreatedById).add(student);
        }
        
        // Process students for each creator
        for(Id creatorId : studentsByCreator.keySet()) {
            Integer count = 0;
            List<Student__c> studentsToUpdate = new List<Student__c>();
            
            for(Student__c student : studentsByCreator.get(creatorId)){
                if(student.Registration_Completed__c == false){
                    student.Mark_Delete__c = 'Yes';
                    studentsToUpdate.a
                    dd(student);
                    count++;
                }
            }
            
            if(!studentsToUpdate.isEmpty()){
                update studentsToUpdate;
            }
            
            creatorDeletedCount.put(creatorId, count);
            
            // Sends email to creator
            sendEmail(count, creatorId);
        }
    }
    
    /**
    * description: this method retrieves the unique email addresses of the creators.
    * params : Database.BatchableContext context
    * returns : Returns the Id and emails of the creator.
    **/
    private static void sendEmail(Integer deletedCount, Id creatorId){
        User creator = [SELECT Id, Email FROM User WHERE Id = :creatorId LIMIT 1];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new List<String>{creator.Email});
        mail.setSubject('Batch Job Completed');
        mail.setPlainTextBody('Hey, the batch Job Completed. Number of students marked for deletion: ' + deletedCount);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
    
    /**
    * description: this is the method of the schedule class which schedules the Batch class
    * params :SchedulableContext sc
    * returns : Returns the records executed in batches.
    **/
    global void execute(SchedulableContext sc){
        DeleteStudentRecordsBatch batch = new DeleteStudentRecordsBatch();
        Database.executeBatch(batch, 20);
    }
} 