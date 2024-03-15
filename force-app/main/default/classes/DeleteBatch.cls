global class DeleteBatch implements Database.Batchable<sObject>, Schedulable{
    
    
    /**
description: this method  query the records from the database
params : Database.BatchableContext contex
returns : Returns the records fetched by the query
**/
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Mark_Delete__c FROM Student__c WHERE Mark_Delete__c='YES' LIMIT 5]);
    }
    
    /**
description: this method deletes the studentList 
params : Database.BatchableContext contex
returns : Returns the list of deleted students.
**/
    global void execute(Database.BatchableContext bc, List<Student__c> studentList){
        
        delete studentList;
        
    }
    
    global void finish(Database.BatchableContext bc){
        
    }
/**
description: this is the method of the schedule class which schedules the Batch class
params :SchedulableContext sc
returns : Returns the records executed in batches.
**/
    global void execute(SchedulableContext sc){
        DeleteBatch db = new DeleteBatch();
        Database.executeBatch(db, 20);
    }
    
}