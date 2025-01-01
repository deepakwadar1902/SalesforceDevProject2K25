public with sharing class LookUpHelper {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accId){
        System.debug('Acc ID :'+ accId);
        try{
            return [SELECT Id, Name, Phone FROM Contact WHERE AccountId=:accId LIMIT 10];
        }catch(exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}