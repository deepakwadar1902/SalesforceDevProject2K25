import { api, LightningElement } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api accountId;     //this will hold the account id passed from the parent component
    
}