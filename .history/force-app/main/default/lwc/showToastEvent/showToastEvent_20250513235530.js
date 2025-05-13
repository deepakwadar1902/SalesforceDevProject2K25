import { LightningElement } from 'lwc';
import { showToastEvent } from 'lightning/platformShowToastEvent';
export default class ShowToastEvent extends LightningElement {

    handleError(){
        const toastEvent = new ShowToastEvent({
            title : 'Error',
            message : 'Something went wrong!',
            variant : 
        })
    }
}