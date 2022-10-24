@isTest
public class GameTriggerHandlerTest {
    
    @isTest 
    static void recalculateGameRatingTest(){
        List<Player__c> players = TestDataFactory.createPlayers(1);
       
        List<Game__c> games = TestDataFactory.createGames(15);
        List<Bet__c> bets = new List<Bet__c>();
        Integer index = 1;
        for(Game__c game : games){
            bets.add(TestDataFactory.createBet(game.Id,players.get(0).Id, 'Won', index * 1000, false));
            index++;
        }
        
        Test.startTest();
        insert bets;
        Test.stopTest();
        
        List<Game__c> gamesWithRating = [SELECT Id,Game_Rating__c FROM Game__c];
        for(Game__c game : gamesWithRating) {
            if(game.Id == games.get(0).Id){
                System.AssertEquals(null, game.Game_Rating__c, 'First Game should not have rating');
            }
            if(game.Id == games.get(14).Id){
                System.AssertEquals(1, game.Game_Rating__c, 'Latest Game should have better rating');
            }
        }

    }
}