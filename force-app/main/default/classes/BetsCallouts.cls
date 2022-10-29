public class BetsCallouts {
    public static HttpResponse makeGetCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://avenga-school.herokuapp.com/retrieve-data');
        request.setMethod('GET');
        request.setHeader('projectName', 'Totalizator');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'bets' key as a list
            List<Object> bets = (List<Object>) results.get('bets');
            System.debug('Received the following bets:');
            for(Object bet: bets) {
                System.debug(bet);
            }
        }
        return response;
    }
}
