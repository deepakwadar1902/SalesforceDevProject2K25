global class AccountBatchClass implements Database.Batchable<SObject> {
    
    global Integer numberOfDirectCustomers = 0;

    global Database.queryLocator start(Database.BatchableContext BC){
        String query = 'SELECT id, Name FROM Account';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Account> accList){
        
        for(Account acc: accList){
            acc.Name = acc.Name + 'Updated from Batch';
        }
        try{
            
        }
    }
}