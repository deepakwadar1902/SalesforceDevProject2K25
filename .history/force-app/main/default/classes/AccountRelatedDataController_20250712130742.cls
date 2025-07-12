public with sharing class AccountRelatedDataController {
    
    @AuraEnabled(Cacheable=true)
    public static void getAccounts(){
        return [Select Id, Name from Account];
    }

}