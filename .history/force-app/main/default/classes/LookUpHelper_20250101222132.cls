public with sharing class LookUpHelper {
    
    public LookUpHelper() {

    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accId){
        try{
            return [SELECT Id, Name, Phone FROM Contact WHERE AccountId=:accId];
        }catch(exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}