public class NewApexClass {
    public String selectedValue { get; set; }
    public String selectedMentorId { get; set; }
   public String defaultSelectedValue { get; set; }// Add this propertypublic String selectedMentorId { get; set; }
    public List<SelectOption> dropdownOptions { get; set; }
    public List<Mentor2__c> mentors { get; set; }
    public List<Student__c> students { get; set; }
    
    public NewApexClass() {
        dropdownOptions = new List<SelectOption>();
        dropdownOptions.add(new SelectOption('', 'None'));
        for(Institute2__c inst : [SELECT Id, Name FROM Institute2__c]) {
            dropdownOptions.add(new SelectOption(inst.Id, inst.Name));
            selectedValue = '';
        }
    }
    public void fetchMentors() {
        // Fetch mentors for the selected institute
            mentors = [SELECT Id, Name, Designation__c, StudentsNumber__c FROM Mentor2__c WHERE Institute2__c = :selectedValue];
            students=null;
    }
    
    
    public void fetchStudentsForMentor() {
        
        // Fetch students associated with the selected mentor
        students = [SELECT Id, Name, Class__c, City__c, State__c FROM Student__c WHERE Mentor2__c = :selectedMentorId];
    } 
}