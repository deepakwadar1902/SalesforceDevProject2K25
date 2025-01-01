import { LightningElement,wire } from 'lwc';
import callApex from '@salesforce/apex/LookUpHelper.getContacts';
export default class LookupDemo extends LightningElement {

    accountId;
    contactList;
    column=[
        { label: 'Name', fieldName: 'Name'},
        { label: 'Phone', fieldName: 'Phone'}  
    ];
    
    //2nd
    handleChange(event){
        this.accountId = event.detail.recordId;
        console.log('Account ID :' + this.accountId);
    }

    @wire(callApex,{accId: this.accountId})
    wireData({error, data}){
        if(data){
            this.contactList = data;
        }else if(error){
            this.contactList = undefined;
        }
    }

    //1st
    filter = {
        criteria:[
            {
                fieldPath:'CreatedDate',
                operator:'eq',
                value:{literal: 'TODAY'}
            }
        ]
    }
    displayInfo ={
        additionalFields: ['Industry'],          //Search Addition Info 
    };

    matchingInfo ={
        primaryField:{fieldPath:'Name'},
        additionalFields:[{fieldPath:'Industry'}],
    };
}