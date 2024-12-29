import { LightningElement, track } from 'lwc';

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
    }
}