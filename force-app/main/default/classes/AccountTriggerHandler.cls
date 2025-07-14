public class AccountTriggerHandler {
	public static boolean isTriggerRan = false;  // Recursive handled for Line No - 310
    //ContactCreationQueueable 
    public static void AccountTriggerForContact(List<Account> accListNew){
        System.enqueueJob(new ContactCreationQueueable(accListNew));
    }
    
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
            /*
            if(accRec.Phone == null){
                accRec.AddError('Phone number is required field while creatin Account.');
            }*/
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
    
	
	/*Scenario - Whenever Account is created then related Opportunity needs to be 
	 * created and opp name format - Acc Name + Current DateTime Stamp */
    
    public static void createAccountRelatedOpps(List<Account> AccNewList){
        
        List<Opportunity> oppList = new List<Opportunity>();
        for(Account accRec: AccNewList){
            
            if(accRec.Name != null){
                Opportunity op = new Opportunity();
                DateTime dt = DateTime.now();
                String dateTimestr = dt.format('dd/mm/yyyy hh:mm:ss');
                op.AccountId = accRec.Id;
                op.StageName = 'Prospecting';
                op.CloseDate = System.TODAY() + 7;
                op.Name = accRec.Name+ ' ' + dateTimestr;
                oppList.add(op);
            }
        }
        if(!oppList.isEmpty()){
            INSERT oppList;
        }
    }
    
    
    public static void updateAccountOwnerBasedOnEmail(List<Account> accNewList, Map<Id, Account> oldMap){
        
        //Collect all the new email values from account being update
        Set<String> accEmail = new Set<String>();
        System.debug('accEmail = ' + accEmail);
        for(Account acc : accNewList){
            //add to set if Email__c is not null and has been changed
            if(acc.Email__c != null && acc.Email__c != oldMap.get(acc.Id).Email__c){
                accEmail.add(acc.Email__c);
            }
        }
        //Map User emails to their IDs
        map<String, Id> userEmailstoIdMap = new Map<String, Id>();
        
        if(!accEmail.isEmpty()){
            //Query User whose email matches the account emails
            for(User user: [select Id, Name, Email from User where Email in:accEmail]){
                userEmailstoIdMap.put(user.Email, user.id);
            }
        }
        
        //Update Account ownerId based on matching User email
        for(Account acc:AccNewList){
            if(userEmailstoIdMap.containsKey(acc.Email__c)){
                acc.OwnerId = userEmailstoIdMap.get(acc.Email__c);
            }
        }
    }
    
    public static void accountStatusValidation(List<Account> accNewList, Map<Id, Account> oldMap){
        //set to collect Account Ids where Active status is changing from 'Yes' to 'No'
        
        Set<Id> accIds = new Set<Id>();
        
        //Identify account Active status is being changed from 'Yes' to 'No'
        for(Account acc: AccNewList){
            if(acc.Active__c == 'No' && oldMap.get(acc.id).Active__c == 'Yes'){
                accIds.add(acc.Id);
            }
        }
        
        //Query related opportunities for the identified accounts
        
        List<Opportunity> relatedOpps = [Select Id, AccountId, StageName from Opportunity 
                                        where AccountId IN : accIds AND StageName != 'Closed Won' AND StageName != 'Closed Lost'];
        
        //Map to track account with open opportunities
        
        Set<Id> accIdsWithOpenOpps = new Set<Id>();
        
        //populate the set with accountId that have open opps
        
        for(Opportunity opp: relatedOpps){
            if(opp.AccountId != null){
                accIdsWithOpenOpps.add(opp.AccountId);
            }
        }
        
        //prevent changing the Active status if there are open opps associated with accounts
        
        for(Account acc: AccNewList){
            if(accIdsWithOpenOpps.contains(acc.Id)){
                acc.Active__c.addError('Cannot change Active status to No because there is an open opps associated with Account.');
            }
        }
    }
    
    public static void updateRelatedOppDesc(List<Account> accList, Map<Id, Account> oldMap){
        Map<Id, Account> accountIdtoAccMap = new Map<Id, Account>();
        for(Account acc : accList){
            if(oldMap != null && acc.Phone != oldMap.get(acc.Id).Phone){
                accountIdtoAccMap.put(acc.Id, acc);
            }
        } 
        List<Opportunity> oppListToUpdated = new List<Opportunity>();
        for(Opportunity opp : [SELECT id, AccountId, Description FROM Opportunity WHERE AccountId IN : accountIdtoAccMap.keySet()]){
            if(accountIdtoAccMap.ContainsKey(opp.AccountId)){
                opp.Description = accountIdtoAccMap.get(opp.AccountId).Phone;
                oppListToUpdated.add(opp);
            }
        } 
        if(!oppListToUpdated.isEmpty()){
            UPDATE oppListToUpdated;
        }
    }
    
    
    //After Insert:
    //Whenever the Account is created with Industry as Banking then create a contact for 
	//account, Contact Lastname as Account name and contact phone as account phone.

    public static void insertContactOnAccCreation(List<Account> accList){
        
        List<Contact> conListToCreate = new List<Contact>();
        
        for(Account acc : accList){
            if(acc.Industry == 'Banking'){
                Contact con = new Contact();
                con.LastName = acc.Name;
                con.Phone = acc.Phone;
                con.AccountId = acc.Id;
                conListToCreate.add(con);
            }
        }
        if(!conListToCreate.isEmpty()){
            INSERT conListToCreate;
        }
    }
    
    /* Creates the number of contacts which are equal to the number which we will enter in the 
		Number of Locations field on the Account Object. */
    
    public static void createContactOnAccUpdation(List<Account> accList){
        
        List<Contact> contactsToInsert = new List<Contact>();
        
        for(Account acc : accList){
            //Ensure Number of Location has valid number
            if(acc.NumberofLocations__c != null && acc.NumberofLocations__c > 0){
                //Calculate the difference in number of contacts to create
                Decimal numberOfContactsToCreate = acc.NumberofLocations__c;
                
                //create Contact based on Number of Location
                for(Integer i = 0; i < numberOfContactsToCreate; i++){
                    Contact con = new Contact();
                    con.LastName = acc.Name + ' - Location ' + (i + 1);
                    con.AccountId = acc.Id;
                    contactsToInsert.add(con);
                }
                
            }
        }
        //insert all new contacts
        if(!contactsToInsert.isEmpty()){
            INSERT contactsToInsert;
        }
    }
	
}