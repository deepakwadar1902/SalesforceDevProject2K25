import { LightningElement,wire } from 'lwc';
import callApex from '@salesforce/apex/LookUpHelper.getContacts';
export default class LookupDemo extends LightningElement {

    accountId;
    contactList;
    //Conditional Rendering
    ShowContactTable=false;
    columns=[
        { label: 'Name', fieldName: 'Name'},
        { label: 'Phone', fieldName: 'Phone'}  
    ];

    //2nd
    handleChange(event){
        this.accountId = event.detail.recordId;
        console.log('this.accountId');
        this.contactList = [];
        this.ShowContactTable = false;    
    }

    //Declarative Approach
    /*@wire(callApex,{accId: '$accountId'})
    wireData({error, data}){
        if(data){
            this.contactList = data;
            this.ShowContactTable = true;
        }else if(error){
            this.contactList = undefined;
            this.ShowContactTable = false;
        }
    }*/

    //Imperative Approach
    callImperativeApex(event){
        callApex({accId: this.accountId})
        .then(result=>{
            this.contactList = undefined;
            this.ShowContactTable = true;
        })
        .catch(error=>{
            this.contactList = undefined;
            this.ShowContactTable = false;
        })
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