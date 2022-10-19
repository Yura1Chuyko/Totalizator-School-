trigger GameTrigger on Game__c (after update) {
    if(Trigger.isAfter){
    	if(Trigger.isUpdate){
            GameTriggerHandler.onAfterUpdate(Trigger.OldMap,Trigger.NewMap);
        }
    }
}