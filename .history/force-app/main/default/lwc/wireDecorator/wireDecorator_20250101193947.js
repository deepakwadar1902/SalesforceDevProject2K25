import { api, LightningElement, wire } from 'lwc';
import callApexMethod from '@salesforce/apex/wireDecoratorClass.showMessage';
export default class WireDecorator extends LightningElement {
    @api message;
    @wire(callApexMethod)
    wireDate({error,data}){
        if(data){
            this.message = data;            //date--> from apex
        }else if(error){
            console.log(error);
        }
    }
}