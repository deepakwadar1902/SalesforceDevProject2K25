public class FirstJobQueueable implements Queueable{

    public void execute(QueueableContext ctx){
        DELETE [SELECT id FROM Account where createddate = LAST_YEAR];
        //System.debug('I am First Job');
        //Chain any job if you want
        System.enqueueJob(new SecondJobQueueable());
    }
}