global class AccountBatchClass implements Database.Batchable<SObject> {
    
    global Integer numberOfDirectCustomers = 0;

    global Database.queryLocator start(Database.BatchableContext BC){
        String query = 'SELECT id, Name, AccountNumber, Type FROM Account';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Account> accList){
        
        for(Account acc: accList){
            if(acc.Type == 'Direct Customer'){
               
            }
        }
    }
    global void finish(Database.BatchableContext BC){
        System.debug('Number of Direct Customers Updated: ' + numberOfDirectCustomers);
    }
}