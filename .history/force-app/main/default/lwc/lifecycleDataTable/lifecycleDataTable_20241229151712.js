import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class LifecycleDataTable extends LightningElement {
    @track accounts = [];
    @track error;
    //Data table columns definition
    @track columns = [
        { label: 'Account Name', fieldName: 'Name'},
        { label: 'Industry', fieldName: 'Industry'},
        { label: 'Phone', fieldName: 'Phone'}
    ];

    constructor(){
        super();
        console.log('Constructor called..');
    }

    connectedCallback(){
        console.log('Connected Callback called..');
        this.fetchAccounts();
    }
    fetchAccounts(){
        getAccounts()
    }
}