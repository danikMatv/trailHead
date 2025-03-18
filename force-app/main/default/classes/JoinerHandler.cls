public with sharing class JoinerHandler {
    
    @InvocableMethod(label='Separate Strings')
    public static List<String> joinStrings(List<InputRequest> inputRequests) {
        String response = '';
        for(InputRequest req : inputRequests){
            req.separatorString = req.separatorString == null ? ',' : req.separatorString;
            response = String.join(req.stringsToJoin,req.separatorString);
        }
        return new List<String>{response};
    }

    public class InputRequest {
        @InvocableVariable(defaultValue=',')
        public String separatorString;

        @InvocableVariable(label='List of Strings to separate')
        public List<String> stringsToJoin;
    } 
}