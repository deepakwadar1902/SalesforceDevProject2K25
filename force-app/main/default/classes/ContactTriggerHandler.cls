public class ContactTriggerHandler {
	public static Boolean isTriggerRan=false;
    public static void createDuplicateContact(List<Contact> newConList){
        List<Contact> dupConsToInsert = new List<Contact>();
        for(Contact con: newConList){
            Contact con1 = new Contact();
            con1.lastname = 'Duplicate Contact';
            dupConsToInsert.add(con1);
        }
        if(dupConsToInsert.size()>0){
            INSERT dupConsToInsert;
        }
    }
}