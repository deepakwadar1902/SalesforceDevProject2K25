import { LightningElement, track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccount';

export default class ParentComponent extends LightningElement {

    @track accounts;            //store account data
    @track selectedAccountId;   //store selected account ids

    @wire(getAccounts){
        wiredAccounts({})
    }
}