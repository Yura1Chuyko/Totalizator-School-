trigger betTrigger on Bet__c (before insert){
	List<Player__c> playersWithBets = [SELECT Id, (SELECT Amount__c, Status__c FROM Bets__r) FROM Player__c];
    List<Game__c> games = [SELECT Id, (SELECT Amount__c, Status__c FROM Bets__r) FROM Game__c];
    for(Game__c game : games){
        game.Total_Income__c = 0;
        for(Bet__c bet : game.Bets__r){
            if(bet.Status__c == 'Lost'){
                game.Total_Income__c += bet.Amount__c;
            }
        }
    }
    for(Player__c player : playersWithBets){
        	Decimal amountForPlayer = 0;
            for(Bet__c bet : player.Bets__r){
                if (bet.Status__c == 'Won'){
                    amountForPlayer += bet.Amount__c;
                } else if (bet.Status__c == 'Lost'){
                    amountForPlayer -= bet.Amount__c;
                }
            }
        player.Total_Money_Won__c = amountForPlayer;
    	}
}