import { LightningElement } from 'lwc';

export default class LookupDemo extends LightningElement {

    filter = {
        criteria:[
            {
                fieldPath:'CreatedDate',
                operator:'eq',
                value:{literal: 'TODAY'}
            }
        ]
    }
    displayInfo ={
        additionalFields: ['Industry'],          //Search Addition Info 
    };

    matchingInfo ={
        primaryField:{fieldPath:'Name'},
        additionalFields:[{fieldPath:'Indusrty'}],
    };
}