public with sharing class WireDecoratorClass {
    @AuraEnabled(Cacheable=true)
    public static void showMessage(){
        System.debug('Happy New Year 2025..');
    }
}