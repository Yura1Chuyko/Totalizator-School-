public class TotalizatorDao {
    public static  List<Player__c> getPlayers(Integer limitNumber, Integer offset){
        List<Player__c> players = [SELECT Name,Name__c FROM Player__c WHERE Is_Black_List__c = false LIMIT :limitNumber OFFSET :offset];
        List<Player__c> getplayer = new List<Player__c>();
        for(Player__c player : players){
            getplayer.add(player);
        }
        return getplayer;
    }
}