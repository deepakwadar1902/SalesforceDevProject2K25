public class QueueableClass implements Queueable{

    public void execute(QueueableContext qContx){
        //Write your logic that needs to run in background
        //Deleting records
        Delete [select id from case where createddate = LAST_YEAR];
    }
}