public class ApexQueryObject {
    
    //sobjects method
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
    
    //feteching the fields of the selected object
    
    @AuraEnabled
    public static List<wrapper> fieldMap(string objname){
       
        List<wrapper> fieldsList = new List<wrapper>();
        
        //Map to store the objects
        
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        Schema.SObjectType sobjType = gd.get(objname); 
        Schema.DescribeSObjectResult describeResult = sobjType.getDescribe(); 
        
        //map to store the fields
        
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
    
    //wrapper class to store field label and value
    public class wrapper{
        @auraEnabled public String label;
        @auraEnabled public String value;
    }
    
    //method to create a table of data 
    @AuraEnabled
    public static   List<SObject> fieldTable(string objname, List<string> fields){
        String soqlQuery = 'SELECT ' + String.join(fields, ',') + ' FROM ' + objname;
        
        
        List<SObject> objectData = Database.query(soqlQuery);
        return   objectData;
    }
    
}