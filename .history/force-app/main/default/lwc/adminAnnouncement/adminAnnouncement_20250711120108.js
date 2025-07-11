import { LightningElement, api } from 'lwc';

export default class AdminAnnouncement extends LightningElement {
    @api title;
    @api message;
    @api severity;
    @api ctaLabel;
    @api ctaDestination;

    get computedHeaderClass(){
        switch (this.severity){
            case 'info':
                return 'slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_info'
            case 'warning':
                return 'slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_warning'
            default:
                return 'slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_error'
        }
    }
}