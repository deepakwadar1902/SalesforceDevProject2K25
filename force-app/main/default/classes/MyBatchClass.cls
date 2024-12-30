public class MyBatchClass implements Database.Batchable<SObject>  {

    public Database.QueryLocator start(Database.BatchableContext bc){
        //1M--> 2000 Batches
        return Database.getQueryLocator('SELECT Id, Name FROM Account');	//It will not hit exception even the query return 1M records
    } 
    public void execute(Database.BatchableContext bc, List<Account> subListFromStartMethod){
        //Logic to process all 2000 records
        for(Account acc: subListFromStartMethod){
            acc.Name = 'Updated From Batch - ' + acc.Name;
        }
        UPDATE subListFromStartMethod;
    }
    public void finish(Database.BatchableContext bc){
        //Post process Logic
        System.debug('Batch Job Completed...');
        //Call Another batch from here if you want to chain batch job
    }
}