import { LightningElement } from 'lwc';
import callApex from '@salesforce/apex/LookUpHelper.getContacts';
export default class LookupDemo extends LightningElement {

    accountId;

    handleChange(event){
        this.accountId = event.detail.recordId;
        console.log('Account ID :' + this.accountId);
    }

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