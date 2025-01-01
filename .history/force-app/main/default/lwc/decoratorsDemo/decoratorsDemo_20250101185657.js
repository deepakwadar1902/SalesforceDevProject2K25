import { LightningElement, track } from 'lwc';

export default class DecoratorsDemo extends LightningElement {
    @track recordId;
    @track message = "This is my private reactive property.";
}