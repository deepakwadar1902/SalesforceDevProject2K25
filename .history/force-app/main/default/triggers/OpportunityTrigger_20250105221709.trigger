trigger OpportunityTrigger on Opportunity (before insert, before update, after insert, after update, after delete) {

    
    switch on Trigger.operationType{
        when BEFORE_INSERT, BEFORE_UPDATE{
            //Update the next step on Opportunity to 'Onboard a Contact'
            //List<Opportunity> opps= Trigger.New;
            //Opportunity opp = opps[0];

            for(Opportunity opp : Trigger.New){
                if(opp.StageName == 'Closed Won'){
                    opp.NextStep = 'Onboard a Contact';
                }
            }
        }
        when AFTER_INSERT, AFTER_UPDATE{
            //Create follow-up tasks for the sales team to engage 
            //with the customer, schedule a welcome call,
            //and send a thank-you email 
            //List<Opportunity> opps= Trigger.New;
            //Opportunity opp = opps[0];
            List<Task> tasks = new List<Task>();
            for(Opportunity opp : Trigger.New){
                
                if(opp.StageName == 'Closed Won'){
                    Task engageWithCustomer = new Task();
                    engageWithCustomer.WhatId = opp.Id;
                    //engageWithCustomer.WhoId = opp.OwnerId;
                    engageWithCustomer.Subject = 'Engage with the customer';
                    tasks.add(engageWithCustomer);
                    
                    Task scheduleWelcomeCall = new Task();
                    scheduleWelcomeCall.WhatId = opp.Id;
                    //scheduleWelcomeCall.WhoId = opp.OwnerId;
                    scheduleWelcomeCall.Subject = 'Schedule a welcome call';
                    tasks.add(scheduleWelcomeCall);

                    Task sendThankYouEmail = new Task();
                    sendThankYouEmail.WhatId = opp.Id;
                    //sendThankYouEmail.WhoId = opp.OwnerId;
                    sendThankYouEmail.Subject = 'Send as Thank You email';
                    tasks.add(sendThankYouEmail);
                }
            }
            insert tasks;
        }
    } 
    
    
    if(Trigger.isAfter && Trigger.isDelete){
        OpportunityTriggerHandler.createTaskOnOpportunityDeletion(Trigger.old);
    }
    
    if(Trigger.isBefore && Trigger.isInsert){
        OpportunityTriggerHandler.preventCreatingMoreThanOneOpps(Trigger.New);
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        OpportunityTriggerHandler.preventCreatingMoreThanOneOpps(Trigger.New);
    }
}