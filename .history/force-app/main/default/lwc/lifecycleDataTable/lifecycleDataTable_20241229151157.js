import { LightningElement, track } from 'lwc';

export default class LifecycleDataTable extends LightningElement {
    @track accounts = [];
    @track error;
    @track columns = [
        { label: 'Account Name', fieldName: 'Name'},
        { label: 'Industry', fieldName: 'Industry'},
        { label: ''}
    ]
}