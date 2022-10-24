public class BetTriggerHandler {
    public static void onAfterInsert(List<Bet__c> newBets){
        calculateTotalMoneyWon(newBets);
        calculateTotalIncome(newBets);
    }
    private static void calculateTotalMoneyWon(List<Bet__c> newBets){
        Set<Id> playerIds = new Set<Id>();
        for(Bet__c bet : newBets){
            playerIds.add(bet.Player__c);
        }
        Map<Id, Decimal> playerIdToTotalMoneyWon = TotalizatorDao.getTotalMoneyWon(playerIds);
        List<Player__c> players = new List<Player__c>();
        for(Id playerId : playerIdToTotalMoneyWon.keySet()){
            Player__c player = new Player__c(Id = playerId,Total_Money_Won__c = playerIdToTotalMoneyWon.get(playerId));
            players.add(player);
        }
        update players;
    }
    private static void calculateTotalIncome(List<Bet__c> newBets){
        Set<Id> gameIds = new Set<Id>();
        for(Bet__c bet : newBets) {
            gameIds.add(bet.Game__c);
        }
        List<Game__c> gamesWithBets = [SELECT Id, (SELECT Amount__c, Status__c FROM Bets__r WHERE Status__c = 'Lost') FROM Game__c WHERE Id IN :gameIds ];
        for(Game__c game : gamesWithBets){
            game.Total_Income__c = 0;
            for(Bet__c bet : game.Bets__r){
                    game.Total_Income__c += bet.Amount__c;
            }
        }
		update gamesWithBets;
    }
}