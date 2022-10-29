public class PlayerService {
    public static void calculatePlayerBonus(List<Player__c> scope){
        for(Player__c player : scope){
            if(player.Bets__r.size() > 5){
                player.Bonus__c = player.Bets__r.size();
            }
        }
        update scope;
    }
}