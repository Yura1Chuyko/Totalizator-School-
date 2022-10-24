@isTest
public class TestDataFactory {
    
    public static List<Player__c> createPlayers(Integer numberOfPlayers){
        List<Player__c> players = new List<Player__c>();
        for(Integer i = 0 ; i<numberOfPlayers ; i++) {
            players.add(new Player__c(Name__c = 'TestPlayer'+i,Email__c = i+'test@gmail.com'));
        }
        insert players;
        return players;
    }
    
    public static List<Game__c> createGames(Integer numberOfGames){
        List<Game__c> games = new List<Game__c>();
        for(Integer i = 0 ; i<numberOfGames ; i++) {
            games.add(new Game__c(Name = 'TestGame'+i, Start_Date__c  = DateTime.now().addDays(5), Type__c = 'Cars'));
        }
        insert games;
        return games;
    }
    
    public static Bet__c createBet(Id gameId, Id playerId, String status, Decimal amount, Boolean executeDML) {
        Bet__c newBet = new Bet__c(Game__c = gameId, Player__c = playerId, Status__c = status, Amount__c = amount);
        if(executeDML){
            insert newBet;
        }
       
        return newBet;
        
    }

}