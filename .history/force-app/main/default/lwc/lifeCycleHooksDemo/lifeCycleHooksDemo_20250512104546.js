import { LightningElement } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
export default class LifeCycleHooksDemo extends LightningElement {

    constructor(){
        super();
        alert('Constructor is Called..');
    }
}

connectedCallback(){
    alert('ConnectedCallback is Called..');

}