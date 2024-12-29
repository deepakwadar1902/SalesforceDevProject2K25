import { api, LightningElement } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api accountId;     //this will hold the account id passed from the parent component

     // Log accountId for debugging
     connectedCallback() {
        console.log('Received Account Id in child component:', this.accountId);
    }
    //Event handled for the button click
    handleButtonClick(){
        const event = new CustomEvent('accountviewed',{
            detail: {accountId: this.accountId}
        });
        this.dispatchEvent(event);          //Dispatch the custom event to the parent
    }
}