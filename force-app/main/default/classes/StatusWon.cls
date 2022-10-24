public with sharing class StatusWon {

    @auraEnabled(cacheable = true)
    public static List<Bet__c> getBetsList(){
        List<Bet__c> bets = [SELECT Id,Name, Game__c, Status__c FROM Bet__c WHERE Status__c = 'Won'];
        return bets;
    }
}
