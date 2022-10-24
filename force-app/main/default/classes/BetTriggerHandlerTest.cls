@isTest
public class BetTriggerHandlerTest {
    @isTest 
    static void calculateTotalMoneyWonTest(){
        List<Player__c> players = TestDataFactory.createPlayers(1);
       
        List<Game__c> games = TestDataFactory.createGames(10);
        List<Bet__c> bets = new List<Bet__c>();
       
        for(Game__c game : games){
            bets.add(TestDataFactory.createBet(game.Id,players.get(0).Id, 'Won', 1000, false));
        }
        Test.startTest();
        insert bets;
        Test.stopTest();
        List<Player__c> playersAfterCalculate = [SELECT Id,Total_Money_Won__c FROM Player__c];
        System.assert(playersAfterCalculate.get(0).Total_Money_Won__c == 10000, 'The Total_Money_Won__c is incorrect');
        
    }
    
    @isTest 
    static void calculateTotalIncomeTest(){
        List<Player__c> players = TestDataFactory.createPlayers(10);
       
        List<Game__c> games = TestDataFactory.createGames(1);
        List<Bet__c> bets = new List<Bet__c>();
       
        for(Player__c player : players){
            bets.add(TestDataFactory.createBet(games.get(0).Id, player.Id, 'Lost', 500, false));
        }
        Test.startTest();
        insert bets;
        Test.stopTest();
        
        List<Game__c> gamesAfterCalculate = [SELECT Id,Total_Income__c FROM Game__c];
        System.assert(gamesAfterCalculate.get(0).Total_Income__c == 5000, 'The Total_Income__c is incorrect');
        
    }
}