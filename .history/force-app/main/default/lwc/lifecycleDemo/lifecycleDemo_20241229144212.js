import { LightningElement, track } from 'lwc';

export default class LifecycleDemo extends LightningElement {

    @track accounts = [];   //stores the accounts fetched from apex
    @track errors;          //stores the errors

    
}