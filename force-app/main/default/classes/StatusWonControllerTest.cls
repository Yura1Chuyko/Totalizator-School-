@isTest
public class StatusWonControllerTest {
    @isTest
    static void getBetsByPlayerIdsTest(){
        List<Player__c> players = TestDataFactory.createPlayers(2);
        Game__c game = TestDataFactory.createGames(1).get(0);
        Bet__c bet = TestDataFactory.createBet(game.Id, players.get(0).Id, 'Won', 2500, true);
        
        Test.startTest();
    	List<Bet__c> betsByPlayerIds = StatusWonController.getBetsByPlayerIds(players.get(0).Id);
    	Test.stopTest();
        
        System.assert(!betsByPlayerIds.isEmpty(), 'Method has to return records');
        System.assertEquals('Won', betsByPlayerIds.get(0).Status__c, 'Bet Status is incorrect');
    }
}