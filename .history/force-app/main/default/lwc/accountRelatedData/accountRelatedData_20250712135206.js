import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountRelatedDataController.getAccounts';
import getRelatedRecords from '@salesforce/apex/AccountRelatedDataController.getRelatedRecords';

export default class AccountRelatedData extends LightningElement {
    accountOptions = [];
    cases = [];
    contacts = [];
    error;
    casesColumn =[
        { label: 'Label', fieldName: 'name' },
    { label: 'Website', fieldName: 'website', type: 'url' },
    { label: 'Phone', fieldName: 'phone', type: 'phone' },
    { label: 'Balance', fieldName: 'amount', type: 'currency' },
    { label: 'CloseAt', fieldName: 'closeAt', type: 'date' },
    ];
    contactsColumn = [
        { label: 'Label', fieldName: 'name' },
    { label: 'Website', fieldName: 'website', type: 'url' },
    { label: 'Phone', fieldName: 'phone', type: 'phone' },
    { label: 'Balance', fieldName: 'amount', type: 'currency' },
    { label: 'CloseAt', fieldName: 'closeAt', type: 'date' },
    ];
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

     
    async handleChange(event){
        let accountId = event.target.value;
        try {
            let result = await getRelatedRecords({accountId : accountId})
            this.contacts = result.contacts;
            this.cases = result.cases;
        } catch (error) {
            console.log('Error: ' + error);
        }
    }
}