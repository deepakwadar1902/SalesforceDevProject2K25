public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        try{
            return [SELECT Id, Name, ]
        }
    }
}