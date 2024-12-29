// file: lwc/parentComponent/parentComponent.js
import { LightningElement, track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class ParentComponent extends LightningElement {
    @track accounts = [];  // Store the account data
    @track selectedAccountId;  // Store the selected Account Id

    // Wire the Apex method to fetch accounts
    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;  // Assign the fetched accounts to the accounts property
        } else if (error) {
            console.error('Error fetching accounts:', error);
        }
    }

    // Handle account selection from the parent component
    handleAccountSelect(event) {
        // Get the accountId from the button's data-id attribute
        this.selectedAccountId = event.target.dataset.id;
        console.log('Selected Account Id:', this.selectedAccountId);  // Debugging log
    }

    // Handle the custom event from the child component
    handleAccountViewed(event) {
        const viewedAccountId = event.detail.accountId;
        console.log('Account viewed with Id:', viewedAccountId);
    }
}
