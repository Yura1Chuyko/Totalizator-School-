public class Utils {
 	public static Map<String, List<SObject>> groupRecordsByField(List<SObject> recordsToBeGrouped, String groupByField){
        Map<String, List<SObject>> groupedRecordsByField = new Map<String, List<SObject>>();
        for (SObject record : recordsToBeGrouped){
            String value = String.valueof(record.get(groupByField));
            if(!groupedRecordsByField.containsKey(value)){
                groupedRecordsByField.put(value, new List<SObject>());
            }
            groupedRecordsByField.get(value).add(record);
        }
        return groupedRecordsByField;
	}
    
    public static List<sObject> filterRecords(List<sObject> dataList, String fieldApiName, Set<String> validValues){
        List<sObject> filteredRecords = new List<sObject>();
        for(sObject record : dataList){
            String fieldValue = String.valueof(record.get(fieldApiName));
            if(validValues.contains(fieldValue)){
              filteredRecords.add(record);
            }
        }
        return filteredRecords;
    }
}