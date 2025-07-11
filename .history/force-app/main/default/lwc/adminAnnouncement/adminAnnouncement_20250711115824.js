import { LightningElement, api } from 'lwc';

export default class AdminAnnouncement extends LightningElement {
    @api title;
    @api message;
    @api severity;
    @api ctaLabel;
    @api ctaDestination;

    get computedHeaderClass{
        switch (this.severity){
            case 'info':
                
            case 'warning':

            default:
                break;
        }
    }
}