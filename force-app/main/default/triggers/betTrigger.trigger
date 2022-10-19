trigger betTrigger on Bet__c (after insert){
    if(Trigger.isAfter){
    	if(Trigger.isInsert){
    		BetTriggerHandler.onAfterInsert(Trigger.New);
    	}
    }
}