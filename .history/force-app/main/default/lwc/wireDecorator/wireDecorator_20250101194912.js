import { api, LightningElement, wire } from 'lwc';
import callApexMethod from '@salesforce/apex/wireDecoratorClass.showMessage';
//Import Field in LWC
import {getRecord, getFieldValue} from 'lightning/uiRecordApi';                 //CURD Operation using
//Which field your import give reference
import CONTACT_NAME from '@salesforce/schema/Contact.Name';         //fetch field from SF without SOQL query

export default class WireDecorator extends LightningElement {
    @api message;
    @wire(callApexMethod)
    wireDate({error,data}){
        if(data){
            this.message = data;            //date--> from apex
        }else if(error){
            console.log(error);
        }
    }
}