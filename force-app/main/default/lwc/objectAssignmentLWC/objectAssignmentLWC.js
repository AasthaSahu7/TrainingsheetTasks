import { LightningElement, track } from 'lwc';
import getObject from '@salesforce/apex/ApexObjectAssignment.getObject';
import fieldMap from '@salesforce/apex/ApexObjectAssignment.fieldMap';
import fieldTable from '@salesforce/apex/ApexObjectAssignment.fieldTable';


export default class ObjectAssignmentLWC extends LightningElement {

     @track value='';
     @track objOptions=[];
     @track selectedValue='';
     @track selectedValues=[];
     @track selectedFields=[];
     tableData = [];
     tableColumns = [];
     textAreaValues='';
     
     @track listOptions=[]
     //@track cardVisible=false;
    // @track data =[];
    // @track columns= columns;

    get options(){
      return  this.objOptions;

    }

    connectedCallback(){
    getObject()
    .then(result=>{
        let arr=[];
        for(var i=0;i<result.length;i++){
            arr.push({label: result[i], value: result[i]})
        }
        this.objOptions = arr;
    })
}


handleChange(event){
    //this.cardVisible = true;
    this.selectedValue  = event.detail.value;
    fieldMap({objname  : this.selectedValue})
    .then (result =>{
        this.listOptions = result;
    })
    .catch(error =>{
        window.alert("error:" +error);
    })
    //getContacts({selectedAccountId : this.value})
    //.then (result => {
        //this.data = result;
   // })
    //.catch(error => {
        //window.alert("error: "+error)
   // })
}
handleObjectChange(event){
   this.selectedValues = event.detail.value;
    
}
handleClick(event){
           var objectName= this.selectedValue;
           var selectedFields = this.selectedValues;
           this.textAreaValues = 'SELECT '+selectedFields.join(', ')+' '+'FROM '+objectName;
    }
handleTable(event){
    var selectedFields = this.selectedValues;
    var columns=[];
    selectedFields.forEach(function(field) {
        columns.push({ label: field, fieldName: field, type: "string" });
    });
        this.tableColumns = columns;
    fieldTable({objname  : this.selectedValue, fields : this.selectedValues })
    .then(result => {
        this.tableData = result;
    })
   .catch(error=>{
    window.alert('error =>'+error);
   })
    
}
}