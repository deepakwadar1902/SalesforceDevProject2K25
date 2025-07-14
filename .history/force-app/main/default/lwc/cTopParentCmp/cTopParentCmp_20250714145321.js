import { LightningElement } from 'lwc';

export default class CTopParentCmp extends LightningElement {

    receivedMessage = '';

    handleMessage(event){
        this.receivedMessage = event.detail; //Data from child
    }
}