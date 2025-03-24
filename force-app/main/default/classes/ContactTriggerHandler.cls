public class ContactTriggerHandler {
    public static Boolean isTriggerRan=false;
    public static void createDuplicateContact(List<Contact> newConList){
        List<Contact> dupConsToInsert = new List<Contact>();
        for(Contact con: newConList){
            Contact con1 = new Contact();
            con1.lastname = 'Duplicate Contact';
            dupConsToInsert.add(con1);
        }
        if(dupConsToInsert.size()>0){
            INSERT dupConsToInsert;
        }
    }
    
    public static void preventConDeletionIfAccIsActive(List<Contact> ConListOld){
        
        //Collect all Account ID's associated with Contacts being deleted
        Set<Id> accIdSet = new Set<Id>();
        
        for(Contact con: ConListOld){
            if(con.AccountId != null){
                accIdSet.add(con.AccountId);
            }
            System.debug('Account Id Set: ' + accIdSet);
        }
        
        //List of Accounts
        List<Account> accList = [SELECT Id, Active__c FROM Account where Id IN:accIdSet];
        System.debug('Acc List => ' + accList);
        
        //Query the Account status and store in to the Map
        Map<Id, Boolean> IdToBooleanMap = new Map<Id, Boolean>();
        
        for(Account acc: accList){
            Boolean isActive = acc.Active__c == 'Yes';
            IdToBooleanMap.put(acc.Id, isActive);
        }
        System.debug('IdToBooleanMap =>'+IdToBooleanMap);
        
        //prevent deletion of account
        for(Contact con: ConListOld){
            if(con.AccountId != null && IdToBooleanMap.get(con.AccountId) == true){
                con.addError('You cannot delete contact if Account is Active..');
            }
        }
    }
    Public static void preventContactDeletion(List<Contact> conList){
        
        Set<Id> accountIds = new Set<Id>();
        
        // Collect the AccountIds of the Contacts being deleted
        for (Contact c : conList) {
            if (c.AccountId != null) {
                accountIds.add(c.AccountId);
            }
        }
        
        // If there are any AccountIds, check if they have associated Contacts
        if (!accountIds.isEmpty()) {
            Map<Id, Account> accountsWithContacts = new Map<Id, Account>([
                SELECT Id, (SELECT Id FROM Contacts LIMIT 1) 
                FROM Account 
                WHERE Id IN :accountIds
            ]);
            
            // Iterate through the deleted Contacts and check if their Account has contacts.
            for (Contact c : conList) {
                if (c.AccountId != null && accountsWithContacts.containsKey(c.AccountId)) {
                    Account relatedAccount = accountsWithContacts.get(c.AccountId);
                    if (!relatedAccount.Contacts.isEmpty()) {
                        c.addError('Cannot delete Contact associated with an Account. Please delete the Account or disassociate the Contact before deleting.');
                    }
                }
            }
        }
    }
    
    /*Account -> budget__c , Contact -> salary__c 
     * When new contact created or Contact's Salary Changes update sum of salary in  Budget field of Account write apex trigger*/
    
    public static void handleAfter(List<Contact> newContacts, Map<Id, Contact> oldContactsMap) {
        Set<Id> accountIds = new Set<Id>();
        Map<Id, Decimal> accountSalarySums = new Map<Id, Decimal>();

        // Collect relevant Contacts and Account Ids
        for (Contact c : newContacts) {
            if (c.AccountId != null) {
                if (Trigger.isInsert || (Trigger.isUpdate && oldContactsMap != null && oldContactsMap.containsKey(c.Id) && oldContactsMap.get(c.Id).Salary__c != c.Salary__c) || (Trigger.isUpdate && oldContactsMap == null)) {
                    accountIds.add(c.AccountId);
                }
            }
        }

        if (!accountIds.isEmpty()) {
            // Aggregate Salary Sums per Account
            for (Contact c : [SELECT Id, AccountId, Salary__c FROM Contact WHERE AccountId IN :accountIds]) {
                if (accountSalarySums.containsKey(c.AccountId)) {
                    accountSalarySums.put(c.AccountId, accountSalarySums.get(c.AccountId) + (c.Salary__c != null ? c.Salary__c : 0));
                } else {
                    accountSalarySums.put(c.AccountId, (c.Salary__c != null ? c.Salary__c : 0));
                }
            }

            // Update Account Budget fields
            List<Account> accountsToUpdate = new List<Account>();
            for (Account a : [SELECT Id, Budget__c FROM Account WHERE Id IN :accountIds]) {
                if (accountSalarySums.containsKey(a.Id)) {
                    a.Budget__c = accountSalarySums.get(a.Id);
                    accountsToUpdate.add(a);
                }
            }

            if (!accountsToUpdate.isEmpty()) {
                update accountsToUpdate;
            }
        }
    }
    
    /*on Account we have field isContactUpdated whenever Contact updated then on its related 
     * Account isContactUpdated field should make is as true write apex trigger*/
    
    public static void updateAccFieldWhenConUpdated(List<Contact> conList, Map<Id, Contact> oldMap){     
        
        //collect all account id's associated with contacts
        Set<Id> accIdsToUpdate = new Set<Id>();
        for(Contact con : conList){
            if(con.AccountId != null){
                accIdsToUpdate.add(con.AccountId);
            }
        }
        
        //retrive updated account
        List<Account> accountsToUpdate = [Select Id, isContactUpdated__c from Account where Id IN :accIdsToUpdate];
        
        for(Account acc : accountsToUpdate){
            if(acc.isContactUpdated__c != true){
             	acc.isContactUpdated__c = true;   
            }
        }
        UPDATE accountsToUpdate;
    }
}