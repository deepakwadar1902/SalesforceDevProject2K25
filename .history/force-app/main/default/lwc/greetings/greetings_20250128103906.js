import { LightningElement } from 'lwc';

export default class Greetings extends LightningElement {
    /*greetings = "Hello";

    handleClick(){
        this.greetings = "Goodbye";
    }*/
   name = {first:"John", last:"Doe"};
   handleClick(){
    this.name.first
   }

}