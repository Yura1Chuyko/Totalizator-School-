@isTest
public class TotalizatorDaoTest {
    /////////////////////SOQLTESTS/////////////////////
    @isTest 
    static void getPlayersTest(){
        TestDataFactory.createPlayers(3);
        
        Test.startTest();
        List<Player__c> players = TotalizatorDao.getPlayers(5, 1);
        Test.stopTest();
        
        System.assert(!players.isEmpty(), 'Method has to return records');
        System.assertEquals(2, players.size(), 'Method has to use LIMIT and OFFSET');
        
    }
    
    @isTest 
    static void getGamesCountTest(){
        TestDataFactory.createGames(3);
        Test.startTest();
        Integer gamesCount = TotalizatorDao.getGamesCount();
        Test.stopTest();
	
        System.assertEquals(3, gamesCount, 'Method has to create games');
    }
    
    @isTest 
    static void getTotalMoneyWonTest(){
        List<Player__c> players = TestDataFactory.createPlayers(2);
        Set<Id> playerIds = new Set<Id>{players.get(0).Id, players.get(1).Id};
       
        Game__c game = TestDataFactory.createGames(1).get(0);
        Bet__c bet1 = TestDataFactory.createBet(game.Id,players.get(0).Id,'Won', 5000, false);
        Bet__c bet2 = TestDataFactory.createBet(game.Id,players.get(1).Id,'Won', 5000, false);
       
        Bet__c bet3 = TestDataFactory.createBet(game.Id,players.get(0).Id,'Won', 10000, false);
        Bet__c bet4 = TestDataFactory.createBet(game.Id,players.get(1).Id,'Lost', 2000, false);
        insert new List<Bet__c>{bet1, bet2, bet3, bet4};
        Test.startTest();
        Map<Id, Decimal> totalMoneyWon = TotalizatorDao.getTotalMoneyWon(playerIds);
        Test.stopTest();
        
        System.assertEquals(15000, totalMoneyWon.get(players.get(0).Id), 'TotalMoneyWon is incorrect');
        System.assertEquals(3000, totalMoneyWon.get(players.get(1).Id), 'TotalMoneyWon is incorrect');
       
    }
    
    @isTest 
    static void getTopPlayersTest(){
        TestDataFactory.createPlayers(5);
        
        Test.startTest();
        List<Player__c> players = TotalizatorDao.getTopPlayers(5, 2);
        Test.stopTest();
        
        System.assert(!players.isEmpty(), 'Method has to return records');
        System.assertEquals(3, players.size(), 'Method has to use LIMIT and OFFSET');
    }
    
    @isTest static void getMostPopularGamesTest(){
        List<Player__c> players = TestDataFactory.createPlayers(1);
       
        List<Game__c> games = TestDataFactory.createGames(3);
        Bet__c bet1 = TestDataFactory.createBet(games.get(0).Id,players.get(0).Id, 'Won', 5000, false);
        Bet__c bet2 = TestDataFactory.createBet(games.get(0).Id,players.get(0).Id, 'Won', 5000, false);
       
        Bet__c bet3 = TestDataFactory.createBet(games.get(1).Id,players.get(0).Id, 'Won', 10000, false);
        Bet__c bet4 = TestDataFactory.createBet(games.get(1).Id,players.get(0).Id, 'Lost', 2000, false);
        insert new List<Bet__c>{bet1, bet2, bet3, bet4};
        
        Test.startTest();
        Map<Id, Integer> popularGames = TotalizatorDao.getMostPopularGames();
        Test.stopTest();
        
        System.assert(!popularGames.isEmpty(), 'Method has to return populated Map');
        System.assertEquals(2, popularGames.get(games.get(0).Id), 'First Game has 2 games');
        System.assertEquals(2, popularGames.get(games.get(1).Id), 'Second Game has 2 games');
        System.assertEquals(0, popularGames.get(games.get(2).Id), 'Third Game has 0 games');
    }
        
      /////////////////////DMLTESTS/////////////////////
      
    @isTest 
    static void createPlayerTest(){
        Test.startTest();
        TotalizatorDao.createPlayer('Yura', 'yura@gmail.com');
        Test.stopTest();
        List<Player__c> players = [SELECT Id,Name__c FROM Player__c];
        System.assertEquals('Yura', players.get(0).Name__c, 'Player should be created and have the correct Name');
    }
    
    @isTest 
    static void updateBetTest(){
        List<Player__c> players = TestDataFactory.createPlayers(2);
        Set<Id> playerIds = new Set<Id>{players.get(0).Id, players.get(1).Id};
       
        Game__c game = TestDataFactory.createGames(1).get(0);
        Bet__c bet = TestDataFactory.createBet(game.Id, players.get(0).Id, 'Won', 5000, true);
        
        Test.startTest();
        TotalizatorDao.updateBet(bet.Id, 3000, 5);
        Test.stopTest();
        
        List<Bet__c> bets = [SELECT Id, Amount__c, Win_Rate__c FROM Bet__c];
        System.assertEquals(3000 , bets.get(0).Amount__c, 'Player amount should be updated');
        System.assertEquals(5 , bets.get(0).Win_Rate__c, 'Player WinRate should be updated');
    }
    
    @isTest 
    static void updateBetWithNullTest(){
        List<Player__c> players = TestDataFactory.createPlayers(2);
        Set<Id> playerIds = new Set<Id>{players.get(0).Id, players.get(1).Id};
       
        Game__c game = TestDataFactory.createGames(1).get(0);
        Bet__c bet = TestDataFactory.createBet(game.Id, players.get(0).Id, 'Won', 5000, true);
        
        Test.startTest();
        TotalizatorDao.updateBet(bet.Id, null, null);
        Test.stopTest();
        
        List<Bet__c> bets = [SELECT Id, Amount__c, Win_Rate__c FROM Bet__c];
        System.assertEquals(5000 , bets.get(0).Amount__c, 'Player amount should NOT be updated');
    }
    
    @isTest static void deleteBetsTest(){
        List<Player__c> players = TestDataFactory.createPlayers(2);
        Set<Id> playerIds = new Set<Id>{players.get(0).Id, players.get(1).Id};
       
        Game__c game = TestDataFactory.createGames(1).get(0);
        Bet__c bet = TestDataFactory.createBet(game.Id, players.get(0).Id, 'Won', 5000, true);
        
        List<Id> betIdsToDelete = new List<Id>{bet.Id};
        
        Test.startTest();
        TotalizatorDao.deleteBets(betIdsToDelete);
        Test.stopTest();
        
        List<Bet__c> bets = [SELECT Id FROM Bet__c];
        System.assert(bets.isEmpty(),'No Bets after delete');
    }
    
    @isTest 
    static void createBetTest(){
        Player__c player = TestDataFactory.createPlayers(1).get(0);
       
        Game__c game = TestDataFactory.createGames(1).get(0);
        Test.startTest();
        TotalizatorDao.createBet(game.Id, player.Id, 15000, 5);
        Test.stopTest();
        List<Bet__c> bets = [SELECT Id,Game__c, Player__c, Status__c FROM Bet__c];
        System.assert(bets.size()>0, 'Bet has to be created');
        System.AssertEquals('Pending', bets.get(0).Status__c, 'Bet Status is incorrect');
    }
    
}