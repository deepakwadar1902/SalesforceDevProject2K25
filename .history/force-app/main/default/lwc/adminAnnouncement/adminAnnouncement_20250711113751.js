import { LightningElement, api } from 'lwc';

export default class AdminAnnouncement extends LightningElement {
    @api title;
    @api message;
    @api severity;
    @api ctaLabel;
    @api ctaDestination;
}