public with sharing class LookUpHelper {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accId){
        System.debug('Acc ID :'+ accId);
        List<Contact> conList;
        try{
            if(accId !=null){
                return conList = [SELECT Id, Name, Phone FROM Contact WHERE AccountId=:accId LIMIT 10];
            }else{
                return conList;
            }
        }catch(exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}
