global class AccountBatchClass implements Database.Batchable<SObject> {
    
    global Integer numberOfDirectCustomers = 0;

    global Database.queryLocator start(Database.BatchableContext BC){
        String query = 'SELECT id, Name FROM Account';
        
    }
}