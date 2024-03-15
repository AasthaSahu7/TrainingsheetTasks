@isTest 
public class StudentHistoryTest {
    
    @isTest 
    public static void StudentTest() {
        // Create a new student
        List<Student__c> students = new List<Student__c>();
        students.add(new Student__c(Name = 'Aastha', Class__c = 'BCOM', City__c = 'Indore', Mentor2__c = 'a0BGA000050VAL6'));
        insert students;
        
        // Update the student
        Student__c updatedStudent = [SELECT Id, Name, Class__c, City__c FROM Student__c WHERE Name = 'Aastha'];
        updatedStudent.Name = 'Ash';
        updatedStudent.Class__c = 'BSC';
        updatedStudent.City__c = 'Ujjain';
        update updatedStudent;
        
        // Verify the Student_History__c records
        List<Student_History__c> HistoryRecords = [SELECT FieldName__c, NewValue__c, OldValue__c, Record_Id__c FROM Student_History__c WHERE Record_Id__c = :updatedStudent.Id];
        
        System.assertNotEquals(0, HistoryRecords.size(), 'No student history records found');
  
           
            for(Student_History__c history : HistoryRecords) {
                // Assert that field name, old value, and new value are populated correctly
                System.assertNotEquals(null, history.FieldName__c, 'Field name is null');
                System.assertNotEquals(null, history.OldValue__c, 'Old value is null');
                System.assertNotEquals(null, history.NewValue__c, 'New value is null');
                
                // Assert that the field name corresponds to the updated field in Student__c
                if (history.FieldName__c == 'Class__c') {
                    System.assertEquals('BCOM', history.OldValue__c, 'Old value does not match');
                    System.assertEquals('BSC',history.NewValue__c, 'New value does not match');
                } else if (history.FieldName__c == 'City__c') {
                    System.assertEquals('Indore', history.OldValue__c, 'Old value does not match');
                    System.assertEquals('Ujjain', history.NewValue__c, 'New value does not match');
                } else if (history.FieldName__c == 'Name') {
                    System.assertEquals('Aastha', history.OldValue__c, 'Old value does not match');
                    System.assertEquals('Ash', history.NewValue__c, 'New value does not match');
                }
                
            }
        }
    }


//insert new Account(Name='Demo',Rating='Cold');