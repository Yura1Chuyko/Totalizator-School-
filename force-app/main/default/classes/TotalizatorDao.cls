//-------------------SOQL-------------------//
public class TotalizatorDao {
    public static  List<Player__c> getPlayers(Integer limitNumber, Integer offset){
        List<Player__c> players = [SELECT Name,Name__c FROM Player__c WHERE Is_Black_List__c = false LIMIT :limitNumber OFFSET :offset];
        return players;
    }
    
    public static  List<AggregateResult> getGamesCount(){
        List<AggregateResult> countGames = [SELECT COUNT(Id) FROM Game__c];
        return countGames;
    }
    
    public static  Integer getGamesCount2(){
        Integer countGames = [SELECT COUNT() FROM Game__c];
        return countGames;
    }
    
    public static Map<Id, Decimal> getTotalMoneyWon(Set<Id> playerIds){
        List<Player__c> playersWithBets = [SELECT Id, (SELECT Amount__c, Status__c FROM Bets__r) FROM Player__c WHERE Id IN :playerIds];
        Map<Id, Decimal> playerIdToTotalMoneyWon = new Map<Id, Decimal>();
        for(Player__c player : playersWithBets){
        	Decimal amountForPlayer = 0;
            for(Bet__c bet : player.Bets__r){
                if (bet.Status__c == 'Won'){
                    amountForPlayer += bet.Amount__c;
                } else if (bet.Status__c == 'Lost'){
                    amountForPlayer -= bet.Amount__c;
                }
            }
            playerIdToTotalMoneyWon.put(player.Id, amountForPlayer);
            
        }
        return playerIdToTotalMoneyWon;
    }
    public static List<Player__c> getTopPlayers(Integer limitNumber, Integer offset){
        List<Player__c> maxTotalMoneyWon = [SELECT Name,Name__c,Total_Money_Won__c FROM Player__c ORDER BY Total_Money_Won__c DESC LIMIT :limitNumber OFFSET :offset];
        return maxTotalMoneyWon;
    }
    public static Map<Id, Integer> getMostPopularGames(){
        List<Game__c> gamesWithBets = [SELECT Id,(Select Id FROM Bets__r) FROM Game__c];
        Map<Id,Integer> popularGames = new Map<Id,Integer>();
        for(Game__c game : gamesWithBets){
            Integer betsSize = game.Bets__r.size();
            popularGames.put(game.Id,betsSize);
        }     
        return popularGames;
    }
    //-------------------DML-------------------//   
    public static void createPlayer(String playerName, String playerEmail){
       Player__c player = new Player__c(Name__c = playerName,Email__c = playerEmail);
        Database.insert(player);
    }
    public static void updateBet(Id betId, Decimal amount, Decimal percent){
        if ( (amount != null) || (percent != null) ){
            Bet__c bet = new Bet__c(Id = betId);
            if (amount != null){
                bet.Amount__c = amount;
            }
            if(percent != null){
                bet.Win_Rate__c = percent;
            }
            Database.update(bet);
        }
    }
    public static void deleteBets(List<Id> betIds){
        Database.delete(betIds);
    }
    public static void createBet(Id game, Id player, Decimal amount, Decimal winRate){
        Bet__c bet = new Bet__c(Game__c = game, Player__c = player, Amount__c = amount, Win_Rate__c = winRate, Status__c = 'Pending');
        Database.insert(bet);
    }
}