import { LightningElement, wire } from 'lwc';
import callingWire from '@salesforce/apex/wireAndImperativeController.getAccountDetails';
export default class WireAndImperative extends LightningElement {

    /*
        If you want fresh data on every render, use the wire adapter
        If you don't want fresh data on every render, use the connectedCallback or imperative adapter
    */

        myName = 'New';
        showData;

        
        @wire(callingWire, {name : '$myName'})
        wireData({error, data}){
            alert('Outside If wire');
            if(data){
                alert('Inside If wire');
                this.showData = data.Name;  
            }else if(error){
                console.log('Error: ' +error );
            }
        }

        handleChange(event){
            this.myName = event.target.value;
        }

        connectedCallback(){
            alert('Outside method connectedCallback..');
            callingWire({name : this.myName})
            .then((result)=>{
                alert('Inside method connectedCallback..');
                this.showData = result.Name;
            }).catch((error)=>{
                console.log('Error: ' +error);
            });
        }
}