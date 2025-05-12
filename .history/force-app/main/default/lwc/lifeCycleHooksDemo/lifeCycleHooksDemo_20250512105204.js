import { LightningElement, wire } from 'lwc';
import getAccount from '@salesforce/apex/AccountController.getAccounts';
export default class LifeCycleHooksDemo extends LightningElement {

    constructor(){
        super();
        alert('Constructor is Called..');
    }

    
    connectedCallback(){
        alert('ConnectedCallback is Called..');

        getAccount().then(result=>{
            alert('Account is : '+result.Name);
        }).catch(error=>{
            alert('Error is : '+error);
        });
    }
}
