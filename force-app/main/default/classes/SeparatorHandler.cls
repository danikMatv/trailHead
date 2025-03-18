public with sharing class SeparatorHandler {
    
    @InvocableMethod(label='Separate Strings')
    public static List<String> separateStrings(List<InputRequest> inputRequests) {
        String response = '';
        for(InputRequest req : inputRequests){
            req.separatorString = req.separatorString == null ? ',' : req.separatorString;
            response = String.join(req.stringsToSeparate,req.separatorString);
        }
        return new List<String>{response};
    }

    public class InputRequest {
        @InvocableVariable(defaultValue=',')
        public String separatorString;

        @InvocableVariable(label='List of Strings to separate')
        public List<String> stringsToSeparate;
    } 
}