@isTest
public class UtilsTest {
    @isTest 
    static void groupRecordsByFieldTest(){
        List<Game__c> games = TestDataFactory.createGames(4);
        
        Test.startTest();
        Map<String, List<SObject>> groupedRecordsByField = Utils.groupRecordsByField(games, 'Type__c');
        Test.stopTest();
        
        System.assert(groupedRecordsByField.keySet().size() > 0, 'Method should populate the map');
        System.assert(groupedRecordsByField.containsKey('Cars'), 'Method should use the Type__c value');
        System.assertEquals(groupedRecordsByField.get('Cars').size(),4);
    }
    
    @isTest 
    static void filterRecordsTest(){
        List<Game__c> games = TestDataFactory.createGames(4);
        
        
        Test.startTest();
        List<SObject> filteredRecords = Utils.filterRecords(games, 'Type__c', new Set<String>{'Cars'});
        Test.stopTest();
        
        System.assert(filteredRecords.size()>0, 'List has to be populated');

    }
    @isTest 
    static void filterRecordsEmptyTest(){
        List<Game__c> games = TestDataFactory.createGames(4);
        
        
        Test.startTest();
        List<SObject> filteredRecords = Utils.filterRecords(games, 'Type__c', new Set<String>{'Hourses'});
        Test.stopTest();
        
        System.assert(filteredRecords.isEmpty(), 'List has to be empty');

    }
}