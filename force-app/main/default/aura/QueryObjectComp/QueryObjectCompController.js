({
    doInit : function(component, event, helper) {
       helper.objects(component);
    },
    
    displayFields:function(component, event, helper){
        helper.getFields(component);
    },
    
    queryCreate:function(component,event,helper){
        helper.getQuery(component);
    },
    
    tableCreate:function(component,event,helper){
        helper.getTable(component,event,helper);
    }
    
 })