import { api, LightningElement, wire } from 'lwc';
import callApexMethod from '@salesforce/apex/wireDecoratorClass.showMessage';
//Import Field in LWC
import {getRecord, getFieldValue} from 'lightning/uiRecordApi';                 //CURD Operation using
//Which field your import give reference
import CONTACT_NAME from '@salesforce/schema/Contact.Name';         //fetch field from SF without SOQL query
import CONTACT_PHONE from '@salesforce/schema/Contact.Phone';
import CONTACT_DEPARTMENT from '@salesforce/schema/Contact.Department';

export default class WireDecorator extends LightningElement {
    @api message;
    @api recordId;              //used in import field to access fields of records
    @wire(callApexMethod)
    wireDate({error,data}){
        if(data){
            this.message = data;            //date--> from apex
        }else if(error){
            console.log(error);
        }
    }
    
    //wire decorator for import fields
    @wire(getRecord, {recordId:'$recordId', fields:[CONTACT_NAME, CONTACT_PHONE, CONTACT_DEPARTMENT]})  
    record;
    //Without import as well we can fetch fields using 'Contact.Name', 'Contact.Phone', 'Contact.Department'
    get name(){
        //fetching data from wire record
        return this.record.data ? getFieldValue(this.record.data, CONTACT_NAME):'';     //Without import 'Contact.Name'
    }
    get phone(){
        return this.record.data ? getFieldValue(this.record.data, CONTACT_PHONE):'';    //Without import 'Contact.Phone'
    }
    get dept(){
        return this.record.data ? getFieldValue(this.record.data, CONTACT_DEPARTMENT):'';   //Without import 'Contact.Department'
    }
    

    //Without Import Fields
    @wire(getRecord, {recordId: '$recordId', fields: ['Contact.Name', 'Contact.Phone', 'Contact.Department']})
    record;

    get name(){
        return this.record.data.fields.Name.value;
    }
    get phone(){
        return this.record.data.fields.Phone.value;
    }
    get dept(){
        return this.record.data.fields.Department.value;
    }
}