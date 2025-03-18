
@IsTest
private class JoinerHandlerTest {

    @IsTest
    static void testJoinStringsComma() {
        JoinerHandler.InputRequest req = new JoinerHandler.InputRequest();
        req.stringsToJoin = new List<String>{'John','Doe','Smith'};
        req.separatorString    = ',';
        Test.startTest();
            List<String> result = JoinerHandler.joinStrings(new List<JoinerHandler.InputRequest>{ req });
        Test.stopTest();
        System.assertEquals('John,Doe,Smith', result[0]);
    }

    @IsTest
    static void testJoinStringsColon() {
        JoinerHandler.InputRequest req = new JoinerHandler.InputRequest();
        req.stringsToJoin = new List<String>{'John','Doe','Smith'};
        req.separatorString    = ':';
        Test.startTest();
            List<String> result = JoinerHandler.joinStrings(new List<JoinerHandler.InputRequest>{ req });
        Test.stopTest();
        System.assertEquals('John:Doe:Smith', result[0]);
    }
    @IsTest
    static void testJoinStringsNullSeparatpr() {
        JoinerHandler.InputRequest req = new JoinerHandler.InputRequest();
        req.stringsToJoin = new List<String>{'John','Doe','Smith'};
        Test.startTest();
            List<String> result = JoinerHandler.joinStrings(new List<JoinerHandler.InputRequest>{ req });
        Test.stopTest();
        System.assertEquals('John,Doe,Smith', result[0]);
    }
}