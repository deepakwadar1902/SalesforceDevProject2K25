trigger OrderTrigger on Order (after insert, after update, after delete, after undelete) {
	/*if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete) {
            OrderTriggerHandler.handleOrder(Trigger.new, Trigger.old, Trigger.isInsert, Trigger.isUpdate, Trigger.isDelete, Trigger.isUndelete);
        }
    }*/
}