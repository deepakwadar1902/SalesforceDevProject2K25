public with sharing class wireAndImperativeController {
    @AuraEnabled(cacheable=true)
    public static Account getAccountDetails(String name){
        try{
            return [SELECT Id, Name FROM Account WHERE Name=:name LIMIT 1];
        } catch(Exception e){
            throw new AuraHandledException('Error fetching Accounts:' + e.getMessage());
        }
    }
}