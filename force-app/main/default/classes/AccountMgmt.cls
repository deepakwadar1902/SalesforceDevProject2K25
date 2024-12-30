@RestResource(urlMapping = '/accountmgmt/')
global class AccountMgmt {

    @HttpGet
    global static AccountWrapper getTopAccounts(){
        //give paramenter while accessing details
        Map<String, String> mapParams = RestContext.request.params;
        Set<Id> accountSetId = new Set<Id>();
        String accIndustry = mapParams.get('Industry');
        List<Account> accList = [SELECT id, Name, Industry, Rating, annualRevenue FROM Account WHERE annualRevenue != null and Industry = :accIndustry ORDER BY annualRevenue desc limit 10];
    	
        for(Account acc : accList){
            accountSetId.add(acc.Id);
        }
        
        List<Contact> conList = [SELECT Id, LastName, FirstName, Email FROM Contact WHERE accountId IN :accountSetId];
        List<Case> caseList = [SELECT Id, Priority, Subject FROM Case WHERE accountId IN :accountSetId];
        
        AccountWrapper accWrapper = new AccountWrapper();
        accWrapper.accList = accList;
        accWrapper.conList = conList;
        accWrapper.caseList = caseList;
        return accWrapper;
    }
    
    @HttpPost
    /*global static String createAccount(String accName, String accRating, String accIndustry){
        Account acc = new Account();
        acc.Name = accName;
        acc.Rating = accRating;
        acc.Industry = accIndustry;
        try{
            insert acc;
            return 'Account created successfully';
        }catch(exception e){
            return e.getMessage();
        }
    }*/
    
    global static String createAccountAndContact(AccountInformation information){
        Account accRecord = information.accountRecord;
        Contact conRecord = information.contactRecord;
        
        try{
            insert accRecord;
            conRecord.accountId = accRecord.Id;
            insert conRecord;
            return 'Account and Contact successfully created';
                }catch(exception es){
                    return es.getMessage();
                }
    }
    
    @HttpDelete
    global static String deleteAccount(){
        Map<String, String> mapParams = RestContext.request.params;
        String accountId = mapParams.get('accid');
        List<Account> accList = [SELECT Id FROM Account WHERE id = :accountId];
        if(!accList.isEmpty()){
            try{
                delete accList;
                return 'Account deleted successfully';
            }catch(exception ex){
                return ex.getMessage();
            }
        }else{
            return 'Record no found';
        }
    }
    //Wrapper class access multiple objects
    global class AccountWrapper{
        global List<Account> accList;
        global List<Contact> conList;
        global List<Case> caseList;
    }
    
    global class AccountInformation{
        global Account accountRecord{get;set;}
        global Contact contactRecord{get;set;}
    }
}