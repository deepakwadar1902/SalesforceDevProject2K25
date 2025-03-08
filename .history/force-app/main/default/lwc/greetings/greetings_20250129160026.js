import { LightningElement, track } from 'lwc';

export default class Greetings extends LightningElement {
    /*greetings = "Hello";

    handleClick(){
        this.greetings = "Goodbye";
    }*/
   @track name = {first:"John", last:"Doe"};
   handleClick(){
    this.name.first = "Jane";
   }
}

