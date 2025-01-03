public class OpportunityTriggerHandler {

    public static void createTaskOnOpportunityDeletion(List<Opportunity> oppListOld){
        
        //Store all Account IDs from Opportunity
        Set<Id> accIdSet = new Set<Id>();
        List<Task> createTask = new List<Task>();
        for(Opportunity opps : oppListOld){
            accIdSet.add(opps.AccountId);
        }
        
         //List Account which are related to opportunity
         List<Account> AccListFromOpps = [SELECT Id, ownerId FROM Account WHERE Id IN:accIdSet];
        
        //Store Account Id and Account in Map
        Map<Id, Account> idToAccMap = new Map<Id, Account>();
        
        for(Account acc:AccListFromOpps){
            idToAccMap.put(acc.Id, acc);
        }
        
        for(Opportunity opps:oppListOld){
            if(idToAccMap.containsKey(opps.AccountId) && opps.AccountId != null){
                Account acc = idToAccMap.get(opps.AccountId);
                Task tsk = new Task();
                tsk.Subject = 'Follow-up on Opportunity deletion.';
                tsk.Description = 'The Opportunity '+ opps.Name + ' was deleted.';
                tsk.OwnerId = acc.OwnerId;		//Assigns the task to the owner of the related account.
                tsk.WhatId = opps.AccountId;	//Relates the task to the account (AccountId).
                tsk.Priority = 'High';
                tsk.Status = 'Not Started';
                createTask.add(tsk);
            }
        }
        if(createTask.size()>0){
            INSERT createTask;
        }
    }
    
    public static void preventCreatingMoreThanOneOpps(List<Opportunity> oppListNew){
        
        //Collect ID's from incoming opportunities
        Set<Id> accIdSet = new Set<Id>();
        
        for(Opportunity opps: oppListNew){
            if(opps.AccountId != null){
                accIdSet.add(opps.AccountId);
            }
        }
        //Query accounts and its related opportunity create today
        List<Account> accRelOpp = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities WHERE createdDate = today) FROM Account WHERE Id IN:accIdSet];
        
        //Map to store the count of opps for each account
        Map<Id, Integer> accIdToIntegerMap = new Map<Id, Integer>();
        if(!accRelOpp.isEmpty()){
            for(Account acc: accRelOpp){
                accIdToIntegerMap.put(acc.Id, acc.opportunities.size());
            }
        }
        
        //Validate if an Account already has an Opportunity created today
        for(Opportunity opp: oppListNew){
            if(accIdToIntegerMap.get(opp.AccountId)>=1){
                opp.addError('We cant create more the one opportunity');
            }
        }
    }
}