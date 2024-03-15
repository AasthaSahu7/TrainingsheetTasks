public class InstituteControllers{
    public List<SelectOption> institutes { get; set; }
    public String selectedInstitute { get; set; }
    public List<Mentor2__c> mentors { get; set; }
    public List<Student__c> students { get; set; }
    public String selectedMentorId { get; set; }

    public InstituteControllers() {
        // Initialize institutes options
        
        institutes = new List<SelectOption>();
        // Populate institutes from your data

        // Initialize other variables as needed
        mentors = new List<Mentor2__c>();
        students = new List<Student__c>();
    }

    // Method to get mentors based on the selected institute
    public void getMentors() {
        // Query mentors based on selected institute
        mentors = [SELECT Id, Name, Designation__c FROM Mentor2__c WHERE Institute2__c = :selectedInstitute];

        // Reset students list when a new institute is selected
        students = new List<Student__c>();
        selectedMentorId = null;
    }

    // Method to get students based on the selected mentor
    public void getStudents() {
        // Query students based on the selected mentor
        students = [SELECT Id, Name, Class__c FROM Student__c WHERE Mentor2__c = :selectedMentorId];
    }
}