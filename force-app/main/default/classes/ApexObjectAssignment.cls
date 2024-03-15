public class ApexObjectAssignment {
@AuraEnabled
    public static List<String> getObject(){
        List<String> objects = new List<String>();
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();
        for(Schema.SObjectType sobj : gd){
            objects.add(sobj.getDescribe().getName());
        }
        objects.sort();
        System.debug(objects);
        return objects;
}
@AuraEnabled
public static List<wrapper> fieldMap(string objname){
        
        List<wrapper> fieldsList = new List<wrapper>();
        
      
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        Schema.SObjectType sobjType = gd.get(objname); 
        Schema.DescribeSObjectResult describeResult = sobjType.getDescribe(); 
        
        
        Map<String,Schema.SObjectField> fieldsMap = describeResult.fields.getMap();
        for (String fieldName : fieldsMap.keySet()) {
            wrapper wrapperObject =new wrapper(); 
            wrapperObject.label = fieldName;
            wrapperObject.value = string.valueof(fieldsMap.get(fieldName));
            fieldsList.add(wrapperObject);
        }
        System.debug(fieldsList);
        return fieldsList;
    }
    
    
    public class wrapper{
        @auraEnabled public String label;
        @auraEnabled public String value;
    }
       @AuraEnabled
    public static   List<SObject> fieldTable(string objname, List<string> fields){
        
        String soqlQuery = 'SELECT ' + String.join(fields, ',') + ' FROM ' + objname;
        List<SObject> objectData = Database.query(soqlQuery);
        return   objectData;
    }
}