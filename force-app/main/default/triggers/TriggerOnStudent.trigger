trigger TriggerOnStudent on Student__c (before insert, before delete, before update,after insert, after delete, after undelete, after update) {
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
           StudentHelper.callTrigger(Trigger.new, Trigger.oldMap);   
        }
    }
}