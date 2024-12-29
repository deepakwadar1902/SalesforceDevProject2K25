public class AccountTriggerHandler {

    //BEFORE INSERT LOGIC
    //Scenario - 1 & 2
    //Auto populate Shipping address and Through and error if Annual Revenue less 100
    
    public static void updateShippingAddressOnAcc(List<Account> AccNewList){
        for(Account accRec: AccNewList){
            //System.debug('Acc record in loop ' + accRec);
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
            //Sample Request - Throw Error if phone number is empty – Use Before insert & update
            if(accRec.Phone == null){
                accRec.AddError('Phone number is required field while creatin Account.');
            }
        }
    }
    
    //AFTER INSERT LOGIC
    //Scenario - 3
    /*When user created an account, write a logic to create contact with same name and associated account and contact.?*/
    
    public static void insertContact(List<Account> AccNewList){
        List<Contact> conListToInsert = new List<Contact>();
        for(Account accRec: AccNewList){
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
    /*When user updates account record, if user changes account name, 
     * throw an error “Account name once created cannot be modified”*/
    
    public static void updateAccountName(List<Account> AccNewList, Map<Id, Account> oldMap){
         /*System.debug('New Values');
        System.debug(Trigger.new);
        System.debug(Trigger.newMap); 		//Id, recordwithnewvalue
        
        System.debug('Old Values');
        System.debug(Trigger.Old);
        System.debug(Trigger.oldMap);		//Id, recordwitholdvalue */
        
        for(Account accRecNew: AccNewList){
            Account accRecOld = oldMap.get(accRecNew.Id);
            
            if(accRecNew.Name != accRecOld.Name){
                accRecNew.addError('Account name once created cannot be modified');
            }
            
            //Sample Request - Throw Error if phone number is empty – Use Before insert & update
            if(accRecNew.Phone == null){
                accRecNew.AddError('Phone number is required field while creatin Account.');
            }
        }
    }
    
    //AFTER UPDATE LOGIC
    //Scenario - 5
    /*On user updating account record, if billing address is changed, 
    update all its child contacts mail address field same as account billing address.*/
    public static void updateBillingAddressOnChildContacts(List<Account> AccNewList, Map<Id, Account> oldMap){
        Set<Id> accIdWhichGotBillingAddressChanged = new Set<Id>();  //Bulkification of code out of 10 records 3 records update set will capture those record ids
        
        for(Account accRecNew: AccNewList){
            Account accRecOld = oldMap.get(accRecNew.Id);   //new acc id and old acc id is same
            
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
    //Scenario - 6
    //Trigger.new is not available in Delete Operation(and newMap)
    //Trigger.old and oldMap is Available
    public static void CantDeleteActiveAccount(List<Account> AccListOld){
        for(Account accOld: AccListOld){
            if(accOld.Active__c == 'Yes'){
                accOld.addError('You cannot delete active account');
            }
        }
    }
    
    //AFTER DELETE LOGIC
    //Scenario - 7
    //Trigger.new is not available in Delete Operation(and newMap)
    //Trigger.old and oldMap is Available  
    public static void sendEmailOnAfterDelete(List<Account> accListOld){
        //Sending email is not user who deletes the records
        List<Messaging.SingleEmailMessage> emailToBeSend = new List<Messaging.SingleEmailMessage>();
        for(Account accRecOld: accListOld){
            Messaging.SingleEmailMessage emailObj = new Messaging.SingleEmailMessage();
            List<String> emailAddress = new List<String>();
            emailAddress.add(Userinfo.getUserEmail());
            emailObj.setToAddresses(emailAddress);
            emailObj.setSubject('Account has been successfully deleted: ' + accRecOld.Name);
            emailObj.setPlainTextBody('Hello.. no body written here.. Please refer subject');
            emailToBeSend.add(emailObj);
        }
        Messaging.sendEmail(emailToBeSend);
    }
    
    //AFTER UNDELETE
    //Scenario - 8
    //Sending email is not user who retores the records 
    //Trigger.new is available in UNDELETE
    //Trigger.Old in not available in UNDELETE  
    public static void sendEmailOnUndelete(List<Account> accListNew){
        List<Messaging.SingleEmailMessage> emailToBeSend = new List<Messaging.SingleEmailMessage>();
        for(Account accRecNew: accListNew){
            Messaging.SingleEmailMessage emailObj = new Messaging.SingleEmailMessage();
            List<String> emailAddress = new List<String>();
            emailAddress.add(Userinfo.getUserEmail());
            emailObj.setToAddresses(emailAddress);
            emailObj.setSubject('Account has been successfully restored: ' + accRecNew.Name);
            emailObj.setPlainTextBody('Hello.. no body written here.. Please refer subject');
            emailToBeSend.add(emailObj);
        }
        Messaging.sendEmail(emailToBeSend);
    }
    
    
}