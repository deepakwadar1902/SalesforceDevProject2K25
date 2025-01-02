public with sharing class WireDecoratorClass {
    @AuraEnabled(Cacheable=true)
    public static string showMessage(){
        System.debug('Happy New Year 2025..');
        return 'This message coming from Apex..';
    }
}