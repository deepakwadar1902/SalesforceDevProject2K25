import { LightningElement, track } from 'lwc';

export default class LifecycleDataTable extends LightningElement {
    @track accounts = [];
    @track error;
    
}