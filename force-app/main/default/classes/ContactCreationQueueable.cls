public class ContactCreationQueueable implements Queueable{
	
    private List<Account> accListToCreateContacts;
    public ContactCreationQueueable(List<Account> expectingAccountsFromTrigger){
        this.accListToCreateContacts = expectingAccountsFromTrigger;
    }
    public void execute(QueueableContext contx){
        List<Contact> conListToInsert = new List<Contact>();
        for(Account acc: accListToCreateContacts){
            Contact con = new Contact();
            con.LastName = acc.Name;
            con.AccountId = acc.Id;
            conListToInsert.add(con);
        }
        if(!conListToInsert.isEmpty()){
            INSERT conListToInsert;
        }
    }
}