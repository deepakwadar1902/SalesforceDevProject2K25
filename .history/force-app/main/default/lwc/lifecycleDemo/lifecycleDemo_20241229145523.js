import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class LifecycleDemo extends LightningElement {

    @track accounts = [];   //stores the accounts fetched from apex
    @track error;          //stores the errors

    //constructor
    constructor(){
        super();
        console.log('Constructor claled..');
    }

    //connectedCallback - Called when the component is inserted into the DOM
    connectedCallback(){
        console.log('connectedCallback called..');
        //You can initiate data fetching here or setup event listeners if needed
        this.fetchAccounts();
    }

    //fetchAccounts = from Apex
    fetchAccounts(){
        getAccounts()
        .then((result)=>{
            this.accounts = result; //store the account returned from apex
            this.error = undefined; //clear any previous errors 
        })
        .catch((erros)=>{
            this.error = error; // store any errors encountered
            this.accounts = []; //clear the accounts array if any errors 
        });
    }

    //renderedCallback - Callled when the component is rendered
    renderedCallback(){
        console.log('renderedCallback called..');
        // You can do additional DOM manipulations or other actions after rendering
    }

    //disconnectedCallback - called when the component is removed from the DOM
    disconnectedCallback(){
        console.log('disconnectedCallback called..');
        // Cleanup any resources here (remove event listeners, timers, etc.)
    }

    //errorCallback
}