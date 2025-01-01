import { LightningElement } from 'lwc';

export default class LifecycleHooksParent extends LightningElement {
    userName = '';

    constructor(){
        super();
        console.log('In Parent Constructor..');
    }

    connectedCallback(){
        console.log('In Parent connectedCallback..');
    }

    renderedCallback(){
        console.log('In Parent renderedCallback..');
    }
    disconnectedCallback(){
        console.log('In Parent disconnectedCallback..');
    }
    
    errorCallback(error, stack){
        console.log('In Parent errorCallback..');
    }

    submitClickHandler(event){
        this.userName = event.refs.userName?.value;
    }

}