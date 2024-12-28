trigger AccountTrigger on Account (before insert) {

    System.debug('I am in Trigger. Please confirm...');
}