trigger ContactTrigger on Contact (after insert, before delete) {

    //NON BULKIFICATION OF CODE
    /*
    if(Trigger.isInsert && Trigger.isBefore){
        Trigger.new[0].lastname = Trigger.new[0].lastname + 'ABC'; //Deepak --> Deepak ABC
    }
    
    //BULKIFICATION OF CODE
    if(Trigger.isInsert && Trigger.isBefore){
        for(Contact con: Trigger.new){
            con.lastname = con.lastname + 'ABC'; //Deepak --> Deepak ABC
        }
    }
	
    
    if(Trigger.isAfter && Trigger.isInsert && !ContactTriggerHandler.isTriggerRan){
        ContactTriggerHandler.isTriggerRan = true;
        ContactTriggerHandler.createDuplicateContact(Trigger.new);
    }
    
    if(Trigger.isBefore && Trigger.isDelete){
        ContactTriggerHandler.preventConDeletionIfAccIsActive(Trigger.old);
    }*/
}