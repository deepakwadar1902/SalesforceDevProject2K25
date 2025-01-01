import { LightningElement } from 'lwc';

export default class GetterDemo extends LightningElement {
    comment = 'getter demo';
    get showResult(){
        return this.comment.toUpperCase();
    }
}