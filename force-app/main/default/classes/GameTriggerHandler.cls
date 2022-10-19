public class GameTriggerHandler {
    public static void onAfterUpdate(Map<Id, Game__c> oldGamesMap,Map<Id, Game__c> newGamesMap){
        Boolean gamesWithChangedTotalMoneyBet = false;
        for(Game__c game : newGamesMap.values()){
            if(game.Total_Money_Bet__c != oldGamesMap.get(game.Id).Total_Money_Bet__c){
                gamesWithChangedTotalMoneyBet = true;
            }
        }
        if(gamesWithChangedTotalMoneyBet == true){
            recalculateGameRating();
        } 
    }
    private static void recalculateGameRating(){
        List<Game__c> games = [SELECT Id, Total_Money_Bet__c, Game_Rating__c FROM Game__c ORDER BY Total_Money_Bet__c DESC];
        Integer rating = 1;
        for(Game__c game : games){
            game.Game_Rating__c = rating;
            rating++;
            if(rating > 11){
                game.Game_Rating__c = null;
            }
        }
        update games;
    }
}