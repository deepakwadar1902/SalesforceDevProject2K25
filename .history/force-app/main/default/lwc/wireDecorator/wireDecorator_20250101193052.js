import { LightningElement, wire } from 'lwc';
import callApexMethod from '@salesforce/apex/wireDecoratorClass.showMessage';
export default class WireDecorator extends LightningElement {

    @wire(callApexMethod)
    wireDate({error,data}){
        if(data){
            
        }
    }
}