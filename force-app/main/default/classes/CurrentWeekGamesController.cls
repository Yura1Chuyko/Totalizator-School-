public class CurrentWeekGamesController {
	@AuraEnabled
    public static List<Game__c> getCurrentWeekGames(){
        List<Game__c> games = [SELECT Id, Name, Total_Money_Bet__c, Total_Income__c, Start_Date__c FROM Game__c WHERE Start_Date__c = THIS_WEEK ];
        return games;      
    }
}