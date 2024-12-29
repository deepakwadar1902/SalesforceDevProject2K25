// file: lwc/childComponent/childComponent.js
import { LightningElement, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api accountId;

    connectedCallback() {
        console.log('Received Account Id in child component:', this.accountId);  // Debugging log
    }

    handleButtonClick() {
        const event = new CustomEvent('accountviewed', {
            detail: { accountId: this.accountId }
        });
        this.dispatchEvent(event);  // Dispatch the custom event to the parent
    }
}
