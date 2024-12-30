@RestResource(urlMapping = '/accountmgmttwo/')
global class AccountMgmtTwo {

    @HttpGet
    global static List<Account> getTopAccounts(){
        List<Account> accList = [SELECT id, Name, Industry, Rating, annualRevenue FROM Account WHERE annualRevenue != null];
        return accList;
    }
}