import { LightningElement, track } from 'lwc';

export default class ParentComponent extends LightningElement {

    @track accounts;            //store account data
    @track selectedAccountId;
}