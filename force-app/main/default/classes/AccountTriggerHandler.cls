public class AccountTriggerHandler {

    
    
    
    //AFTER DELETE LOGIC
    //Scenario - 7
    //Trigger.new is not available in Delete Operation(and newMap)
    //Trigger.old and oldMap is Available  
    public static void sendEmailOnAfterDelete(List<Account> accListOld){
        //Sending email is not user who deletes the records
        List<Messaging.SingleEmailMessage> emailToBeSend = new List<Messaging.SingleEmailMessage>();
        for(Account accRecOld: accListOld){
            Messaging.SingleEmailMessage emailObj = new Messaging.SingleEmailMessage();
            List<String> emailAddress = new List<String>();
            emailAddress.add(Userinfo.getUserEmail());
            emailObj.setToAddresses(emailAddress);
            emailObj.setSubject('Account has been successfully deleted: ' + accRecOld.Name);
            emailObj.setPlainTextBody('Hello.. no body written here.. Please refer subject');
            emailToBeSend.add(emailObj);
        }
        Messaging.sendEmail(emailToBeSend);
    }
    
    //AFTER UNDELETE
    //Scenario - 8
    //Sending email is not user who retores the records 
    //Trigger.new is available in UNDELETE
    //Trigger.Old in not available in UNDELETE  
    public static void sendEmailOnUndelete(List<Account> accListNew){
        List<Messaging.SingleEmailMessage> emailToBeSend = new List<Messaging.SingleEmailMessage>();
        for(Account accRecNew: accListNew){
            Messaging.SingleEmailMessage emailObj = new Messaging.SingleEmailMessage();
            List<String> emailAddress = new List<String>();
            emailAddress.add(Userinfo.getUserEmail());
            emailObj.setToAddresses(emailAddress);
            emailObj.setSubject('Account has been successfully restored: ' + accRecNew.Name);
            emailObj.setPlainTextBody('Hello.. no body written here.. Please refer subject');
            emailToBeSend.add(emailObj);
        }
        Messaging.sendEmail(emailToBeSend);
    }
    
    
}