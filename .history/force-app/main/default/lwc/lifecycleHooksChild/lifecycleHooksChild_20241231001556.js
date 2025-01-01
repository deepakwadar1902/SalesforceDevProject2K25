import { api, LightningElement } from 'lwc';
import templateOne from './lifecycleHooksChild.html';
import templateTwo from './lifecycleHooksChild1.html';

export default class LifecycleHooksChild extends LightningElement {
    @api userName;

    constructor(){
        super();
        console.log('In Child Constructor..');
    }

    connectedCallback(){
        console.log('In Child connectedCallback..');
    }

    render(){
        console.log('In child render..');
        if(this.userName == 'render demo'){
            return templateTwo
        }
        return templateOne;
    }

    renderedCallback(){
        console.log('In Child renderedCallback..');
    }
    disconnectedCallback(){
        console.log('In Child disconnectedCallback..');
    }
    
    errorCallback(error, stack){
        console.log('In Child errorCallback..');
    }
}