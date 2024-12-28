trigger AccountTrigger on Account (before insert) {
    //Prepopulate shipping address from billing address
    //CONTEXT VARIABLES(Value which developer need to write logic)
    //CONTEXT VARIABLES 1: Trigger.new -> List
    //System.debug('I am in Trigger. Please confirm...');
    System.debug('Inserted Record:' + Trigger.new);

    if()
}