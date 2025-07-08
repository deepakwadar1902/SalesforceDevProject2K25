trigger CaseTrigger on Case (before insert) {

    if(trigger.isBefore && trigger.isInsert){
        CaseTriggerHandler.updateCaseStatusPriority(Trigger.new);
    }
}