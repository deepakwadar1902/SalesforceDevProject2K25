import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ToastNotificationInLWC extends LightningElement {
    
    showErrorToast(){
        console.log('Method clicked...');
        const evt = new ShowToastEvent({
        title: 'Toast Notification Error',
        message: 'Unexpected error, incomplete Data load',
        variant: 'error',
        mode: 'dismissable'
    });
    this.dispatchEvent(evt);
    }

   showSuccessToast(){
        const evt = new ShowToastEvent({
        title: 'Toast Notification Success',
        message: 'Data load completed successfully',
        variant: 'success',
        mode: 'dismissable'
    });
    this.dispatchEvent(evt);
    }
    showWarningToast(){
       const evt = new ShowToastEvent({
        title: 'Toast Notification Warning',
        message: 'Data is inconsistent, and it may cause problems in the future',
        variant: 'warning',
        mode: 'dismissable'
    });
    this.dispatchEvent(evt);
    }
    showInfoToast(){
        const evt = new ShowToastEvent({
        title: 'Toast Notificaiton Info',
        message: 'Please wait for some time, Data loading in background',
        variant: 'info',
        mode: 'dismissable'
    });
    this.dispatchEvent(evt);
} 

}