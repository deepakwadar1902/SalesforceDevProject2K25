import { LightningElement } from 'lwc';

export default class CTopChildCmp extends LightningElement {
    sendData(){
        const event = new CustomEvent('message',{
            detail:{message: 'Hello from Child..'}
        });
        this.dispatchEvent(event);  //fires custom event
    }
}