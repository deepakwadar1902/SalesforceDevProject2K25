trigger AccountTrigger on Account (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    //Prepopulate shipping address from billing address
    //CONTEXT VARIABLES(Value which developer need to write logic)
    //CONTEXT VARIABLES 1: Trigger.new -> List of records that are get inserted
    //CONTEXt VARIABLES 2: Trigger.isBefore  	-> Return true if trigger is running on before event
    //CONTEXt VARIABLES 3: Trigger.isInsert  	-> Returns true if trigger is called when user has done insert operation
    //CONTEXT VARIABLES 4: Trigger.isAfter 		-> Returns true if trigger is called after the records is inserted/updated
    //CONTEXT VARIABLES 5: Trigger.newMap 		-> Return list of records that are inserted/updated with latest values in map format
    //CONTEXT VARIABLES 6: Trigger.oldMap 		-> Return list of records that are inserted/updated with old/prior values in map fromat
    //CONTEXT VARIABLES 7: Trigger.old			-> Return list of records that are inserted/updated with old/prior values
    //CONTEXT VARIABLES 8: Trigger.isUpdate		-> Return true if trigger is called when record is updated
    //CONTEXT VARIABLES 8: Trigger.isDelete		-> Return true if trigger is called when record is deleted
    //CONTEXT VARIABLES 8: Trigger.isDelete		-> Return true if trigger is called when record is undeleted
    
    //System.debug('I am in Trigger. Please confirm...');
    System.debug('Inserted Record:' + Trigger.new);
    /*
     * 
    //BEFORE INSERT LOGIC
    //Scenario - 1 & 2
    if(Trigger.isBefore && Trigger.isInsert){
        
        AccountTriggerHandler.updateShippingAddressOnAcc(Trigger.new);
    }
    */
    //AFTER INSERT LOGIC
    //Scenario - 3
    if(Trigger.isAfter && Trigger.isInsert){
        
        //AccountTriggerHandler.insertContact(Trigger.new);
        //AccountTriggerHandler.createAccountRelatedOpps(Trigger.new);
        //AccountTriggerHandler.AccountTriggerForContact(Trigger.new);
        AccountTriggerHandler.insertContactOnAccCreation(Trigger.New);
    }
    /*
    //BEFORE UPDATE LOGIC
    //Scenario - 4
    if(Trigger.isBefore && Trigger.isUpdate){
        //AccountTriggerHandler.updateAccountName(Trigger.new, Trigger.oldMap);
		//AccountTriggerHandler.updateAccountOwnerBasedOnEmail(Trigger.new, Trigger.oldMap);
        AccountTriggerHandler.accountStatusValidation(Trigger.new, Trigger.oldMap);
    }
   
    //AFTER UPDATE LOGIC
    //Scenario - 5
    
    if(Trigger.isAfter && Trigger.isUpdate){
        
        AccountTriggerHandler.updateBillingAddressOnChildContacts(Trigger.new, Trigger.oldMap);
		AccountTriggerHandler.updateRelatedOppDesc(Trigger.New, Trigger.oldMap);
    }
     /*
    //BEFORE DELETE LOGIC
    //Scenario - 6
    if(Trigger.isBefore && Trigger.isDelete){
        AccountTriggerHandler.CantDeleteActiveAccount(Trigger.Old);
    }
    
    //AFTER DELETE LOGIC
    //Scenario - 7
    
    if(Trigger.isAfter && Trigger.isDelete){
        AccountTriggerHandler.sendEmailOnAfterDelete(Trigger.Old);
    }
    
    //AFTER UNDELETE
    //Scenario - 8
    
    if(Trigger.isAfter && Trigger.isUndelete){
        //AccountTriggerHandler.sendEmailOnUndelete(Trigger.new);
		
    }
    */
    //ContactCreationQueueable
       
}