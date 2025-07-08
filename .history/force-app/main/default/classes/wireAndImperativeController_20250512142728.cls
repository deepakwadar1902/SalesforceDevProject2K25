public with sharing class wireAndImperativeController {
    @AuraEnabled(cacheable=true)
    public static Account getAccountDetails(){
        try{
            return [SELECT Id, Name, Industry, Phone FROM Account LIMIT 1];
        } catch(Exception e){
            throw new AuraHandledException('Error fetching Accounts:' + e.getMessage());
        }
    }
}