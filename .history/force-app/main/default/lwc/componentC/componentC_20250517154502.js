 import { LightningElement, wire } from 'lwc';
 import { publish, MessageContext, createMessageContext} from 'lightning/messageService';
 import demoMessageChannel from '@salesforce/messageChannel/demoMessageChannel__c';
export default class ComponentC extends LightningElement {

    @wire(MessageContext)
    messageContext;

    submitClickHandler(event){
        let userName = this.refs.userName?.value;

        const customEvent = new CustomEvent('usernamechange', {
            //bubbles: true,      // is not recommended do bubble till root
            //composed: true,
            //detail: userName //passing single value
            detail: {userName : userName}   //passing object
        });
        this.dispatchEvent(customEvent);

        let payload = {userName : userName};
        publish(this.messageContext, demoMessageChannel, payload);
    }
}