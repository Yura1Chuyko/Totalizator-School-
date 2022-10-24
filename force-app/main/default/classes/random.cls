public class random {
    public static void calc(){
        Integer countExist = [SELECT Count() FROM Player__c];
        System.debug(countExist);
    }
}