trigger OpportunityLineItemTrigger on OpportunityLineItem (after insert, after update, after delete, after undelete) {
    OpportunityLineItemTriggerHandler.updateOpportunityAmounts(
        Trigger.new,
        Trigger.old,
        Trigger.isInsert,
        Trigger.isUpdate,
        Trigger.isDelete,
        Trigger.isUndelete
    );
}