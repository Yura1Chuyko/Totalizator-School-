public with sharing class StatusWonController {

    @auraEnabled(cacheable = true)
    public static List<Bet__c> getBetsByPlayerIds(Id playerRecordId){
        List<Bet__c> bets = [SELECT Id, Player__c, Name, Game__c, Status__c FROM Bet__c WHERE Status__c = 'Won' AND Player__c = :playerRecordId];
        return bets;
    }
}