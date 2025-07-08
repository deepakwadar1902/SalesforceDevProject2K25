 import { LightningElement } from 'lwc';
 
export default class ComponentC extends LightningElement {

    submitClickHandler(event){
        let userName = this.refs.userName?.value;

        const customEvent = new CustomEvent('usernamechange', {
            //bubbles: true,      // is not recommended do bubble till root
            //composed: true,
            //detail: userName //passing single value
            detail: {userName : userName}   //passing object
        });
        this.dispatchEvent(customEvent);
    }
}