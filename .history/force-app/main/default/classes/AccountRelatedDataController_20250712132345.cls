public with sharing class AccountRelatedDataController {
    
    @AuraEnabled(Cacheable=true)
    public static void getAccounts(){
        return [Select Id, Name from Account];
    }

    @AuraEnabled(Cacheable=true)
    public static relatedWrapper getRecords(Id accountId){
        Account acc = [
            Select Id, (select Id, caseNumber, Subject, Status from Cases where status != 'Closed'),
            (select Id, FirstName, LastName, Email, Phone from Contacts) from Account
        ];

        relatedWrapper wrapper = new relatedWrapper();
        wrapper.cases = acc.Cases;
        wrapper.contacts = acc.Contacts;

        return wrapper;
    }

    public class relatedWrapper{
        @AuraEnabled public List<Case> cases;
        @AuraEnabled public List<Contact> contacts;
    }
}