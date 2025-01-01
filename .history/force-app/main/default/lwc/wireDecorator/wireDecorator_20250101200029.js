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

    //wire recorator for import fields
    @wire(getRecord, {recordId:'$recordId', fields:[CONTACT_NAME, CONTACT_PHONE, CONTACT_DEPARTMENT]})
    record;
    get name(){
        //fetching data from wire record
        return this.record.data ? getFieldValue(this.record.data, CONTACT_NAME):'';
    }
    get phone(){
        return this.record.data ? getFieldValue(this.record.data, CONTACT_PHONE):'';
    }
    get dept(){
        return this.record.data ? getFieldValue(this.record.data, CONTACT_DEPARTMENT):'';
    }
}