import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountRelatedDataController.getAccounts';

export default class AccountRelatedData extends LightningElement {
    accountOptions = [];
    error;
    @wire(getAccounts)
    wiredAccounts({data, error}){
        if(data){
            this.accountOptions = data.map(currItem => ({
                label : currItem.Name,
                value : currItem.Id
            }))
        }else if(error){
            this.error = error;
            this.accountOptions = undefined;
            console.log('Error: ' + error);
        }
    }

    handleChange(event){
        let accountId = event.target.value;
    }
}