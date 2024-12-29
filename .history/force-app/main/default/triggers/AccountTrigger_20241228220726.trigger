trigger AccountTrigger on Account (before insert, after insert, before update, after update, before delete, after delete) {
    //Prepopulate shipping address from billing address
    //CONTEXT VARIABLES(Value which developer need to write logic)
    //CONTEXT VARIABLES 1: Trigger.new -> List of records that are get inserted
    //CONTEXt VARIABLES 2: Trigge.isBefore  -> Return true if trigger is running on before event
    //CONTEXt VARIABLES 3: Trigge.isInsert  -> Returns true if trigger is called when user has done insert operation
    //CONTEXT VARIABLES 4: Trigge.isAfter 	-> Returns true if trigger is called after the records is inserted/updated
    //CONTEXT VARIABLES 5: Trigge.newMap 	-> Return list of records that are inserted/updated with latest values in map format
    //CONTEXT VARIABLES 6: Trigge.oldMap 	-> Return list of records that are inserted/updated with old/prior values in map fromat
    //CONTEXT VARIABLES 7: Trigge.old		-> Return list of records that are inserted/updated with old/prior values
    //CONTEXT VARIABLES 8: Trigge.isUpdate	-> Return true if trigger is called when record is updated
    //System.debug('I am in Trigger. Please confirm...');
    System.debug('Inserted Record:' + Trigger.new);

    //BEFORE INSERT LOGIC
    if(Trigger.isBefore && Trigger.isInsert){

        for(Account accRec: Trigger.new){
            System.debug('Acc record in loop ' + accRec);
            //Scenario - 1
            if(accRec.ShippingCity == null && accRec.ShippingCountry == null && accRec.ShippingState == null &&
               accRec.ShippingState == null && accRec.ShippingStreet == null && accRec.ShippingPostalCode == null){
                accRec.ShippingCity = accRec.BillingCity;
                accRec.ShippingCountry = accRec.BillingCountry;
                accRec.ShippingState = accRec.BillingState;
                accRec.ShippingStreet = accRec.BillingStreet;
                accRec.ShippingPostalCode = accRec.BillingPostalCode;  
            }
            //Scenario - 2
            if (accRec.AnnualRevenue < 1000){
                accRec.addError('Annual Revenue cannot be less than 1000');
            }
        }
    }

    //AFTER INSERT LOGIC
    //Scenario - 3
    if(Trigger.isAfter && Trigger.isInsert){

        List<Contact> conListToInsert = new List<Contact>();
        for(Account accRec: Trigger.new){
            Contact con = new Contact();
            con.LastName = accRec.Name;
            con.AccountId = accRec.Id;
            conListToInsert.add(con);
        }
        if(conListToInsert.size()>0){
            INSERT conListToInsert;
        }
    }
    //BEFORE UPDATE LOGIC
    //Scenario - 4
    if(Trigger.isBefore && Trigger.isUpdate){
    	/*System.debug('New Values');
        System.debug(Trigger.new);
        System.debug(Trigger.newMap); 		//Id, recordwithnewvalue
        
        System.debug('Old Values');
        System.debug(Trigger.Old);
        System.debug(Trigger.oldMap);		//Id, recordwitholdvalue */
        
        for(Account accRecNew: Trigger.new){
            Account accRecOld = Trigger.oldMap.get(accRecNew.Id);
            
            if(accRecNew.Name != accRecOld.Name){
                accRecNew.addError('Account name once created cannot be modified');
            }
        }
    }
    
    //AFTER UPDATE LOGIC
    //Scenario - 5
    
    if(Trigger.isAfter && Trigger.isUpdate){
        
        Set<Id> accIdWhichGotBillingAddressChanged = new Set<Id>();  //Bulkification of code out of 10 records 3 records update set will capture those record ids
        
        for(Account accRecNew: Trigger.new){
            Account accRecOld = Trigger.oldMap.get(accRecNew.Id);   //new acc id and old acc id is same
            
            if(accRecNew.BillingStreet != accRecOld.BillingStreet){     //Compare new and old record data
                accIdWhichGotBillingAddressChanged.add(accRecNew.id);	//Store id is set
            }
        }
        
        // This set accIdWhichGotBillingAddressChanged will have accountIds which got billing address changed
        // Write query to get contact associated with account
        List<Account> accsWithContacts = [SELECT id, Name, BillingStreet, BillingCity, BillingState, BillingCountry, (SELECT id, name from contacts) from Account WHERE ID in: accIdWhichGotBillingAddressChanged];
        
        //create list to update contactlist
        List<Contact> contactListToUpdate = new List<Contact>();
        
        //loop account with contacts
        for(Account acc: accsWithContacts){
            List<Contact> consOfTheLoopedAccount = acc.contacts;		//List all contacts which looped
            
            for(Contact con:consOfTheLoopedAccount){
                con.MailingStreet = acc.BillingStreet;
                con.MailingCity = acc.BillingCity;
                con.MailingState = acc.BillingState;
                con.MailingCountry = acc.BillingCountry;
                contactListToUpdate.add(con);
            }
        }
        
        if(contactListToUpdate.size()>0){
            UPDATE contactListToUpdate;
        }
    }
    
    //BEFORE DELETE LOGIC
    //Trigger.new is not available in Delete Operation(and newMap)
    //Trigger.old and oldMap is Available
    if(Trigger.isBefore && Trigger.isDelete){
        
        for(Account accOld: Trigger.Old){
            if(accOld.Active__c == 'Yes'){
                accOld.addError('You cannot delete active account');
            }
        }
    }
    
    //AFTER DELETE LOGIC
}