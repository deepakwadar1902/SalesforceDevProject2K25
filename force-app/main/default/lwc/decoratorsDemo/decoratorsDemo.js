import { api, LightningElement, track } from 'lwc';

export default class DecoratorsDemo extends LightningElement {
    @api recordId;              //When you use api decorate automatically record Id will render on Record page
    @track message = "This is my private reactive property."; 

    handleMsgChange(event){
        this.message = event.target.value;
    }
}