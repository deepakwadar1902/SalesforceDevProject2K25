import { api, LightningElement, track } from 'lwc';

export default class DecoratorsDemo extends LightningElement {
    @api recordId;
    @track message = "This is my private reactive property.";
}