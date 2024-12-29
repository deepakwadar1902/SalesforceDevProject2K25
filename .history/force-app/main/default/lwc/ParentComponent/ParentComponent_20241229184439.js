import { LightningElement, track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccount';

export default class ParentComponent extends LightningElement {

    @track accounts;            //store account data
    @track selectedAccountId;   //store selected account ids

    @wire(getAccounts)
        wiredAccounts({error, data}){
            if(data){
                this.accounts = data;       //assign the fetched accounts to the accounts variable
            }else if(error){
                console.log('Error fetching accounts:' + error);
            }
        }
        //Handle account selection from the parent component
        handleAccountSelect(event){
            this.selectedAccountId = event.details
        }
}