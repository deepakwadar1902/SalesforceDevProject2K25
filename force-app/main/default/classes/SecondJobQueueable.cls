public class SecondJobQueueable implements Queueable{

    public void execute(QueueableContext cntx){
        DELETE [SELECT id FROM Contact where createddate = LAST_YEAR];
        //System.debug('I am Second Job');
    }
}