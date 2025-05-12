import { LightningElement, wire } from 'lwc';
import getAccount from '@salesforce/apex/AccountDetails.getAccountData';
export default class LifeCycleHooksDemo extends LightningElement {

    helloWorld = 'Sample Value';
    boolVar = false;

    constructor(){
        super();
        alert('Constructor is Called..');
    }

    // Forms a tree - template-->Dev-->P 
    connectedCallback(){
        alert('ConnectedCallback is Called..');

        /*getAccount().then(result=>{
            alert('Account is : '+result.Name);
        }).catch(error=>{
            alert('Error is : '+error);
        });
        */

        //alert(this.template.querySelector('div')); //null - we wont be able to access div from template html - 
        //tree structure is not formed
    }

    renderedCallback(){
        alert('renderedCallback is Called..');
    }
    
    handleClick(){

        if(this.helloWorld == 'Sample Value'){
            this.boolVar = true;
            this.helloWorld = 'Hello World';
        }else{
            this.boolVar = false;
            this.helloWorld = 'Sample Value';
        }

        //alert(this.template.querySelector('div')); 
        // able to access div from template html -tree structure is formed
    }
}
