import { LightningElement } from 'lwc';

export default class LifeCycleHooksDemo extends LightningElement {

    constructor(){
        super();
        alert('Constructor is Called..');
    }
}