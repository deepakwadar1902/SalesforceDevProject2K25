import { LightningElement, track, wire } from 'lwc';

export default class ParentComponent extends LightningElement {

    @track accounts;            //store account data
    @track selectedAccountId;   //store selected account ids

    @wire()
}