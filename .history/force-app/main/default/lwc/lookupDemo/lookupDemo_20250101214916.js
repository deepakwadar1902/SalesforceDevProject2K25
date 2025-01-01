import { LightningElement } from 'lwc';

export default class LookupDemo extends LightningElement {

    filter = {
        criteria:[
            {
                fieldPath:'CreatedDate',
                operator:'eq',
                literal:{value'TODAY'}
            }
        ]
    }
}