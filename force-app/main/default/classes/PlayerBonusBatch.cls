public class PlayerBonusBatch implements Database.Batchable<sObject>, Schedulable {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Name, Bonus__c, (SELECT Id FROM Bets__r WHERE CreatedDate = THIS_MONTH) FROM Player__c WHERE Is_Black_List__c = false'
        );
    }
    
    public void execute(Database.BatchableContext bc, List<Player__c> scope){
        PlayerService.calculatePlayerBonus(scope);
    }
    
    public void finish(Database.BatchableContext bc){
        
    }
    
    public void execute(SchedulableContext ctx) {
        Id batchId = Database.executeBatch(new PlayerBonusBatch());
    }

}