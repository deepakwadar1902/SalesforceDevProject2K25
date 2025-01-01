/*public with sharing class LookUpHelper {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accId){
        System.debug('Acc ID :'+ accId);
        try{
            if(accId !=null){
                return [SELECT Id, Name, Phone FROM Contact WHERE AccountId=:accId LIMIT 10];
            }
        }catch(exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}*/
public with sharing class LookUpHelper {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accId){
        System.debug('Acc ID :'+ accId);
        try{
            if(accId != null){
                // Check for read access on Contact object
                if (Schema.sObjectType.Contact.isAccessible()) {
                    return [SELECT Id, Name, Phone FROM Contact WHERE AccountId=:accId LIMIT 10];
                } else {
                    throw new AuraHandledException('Insufficient permissions to access Contact records.');
                }
            } else {
                return new List<Contact>();
            }
        } catch(exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}