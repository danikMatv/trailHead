@isTest
private class InvocableLeadConvertTest {
    
    @TestSetup
    static void makeData(){
        Lead lead = new Lead();
        lead.FirstName = 'Test';
        lead.LastName = 'Lead';
        lead.Company = 'Test Company';
        lead.Status = 'Open';
        insert lead;

        Account account = new Account(
            Name = 'Test Account',
            Industry = 'Technology',
            Type = 'Customer - Direct',
            BillingStreet = '123 Test St',
            BillingCity = 'Test City',
            RecordTypeId = '012bm0000051LIrAAM'
        );
        insert account;

        
        Contact contact = new Contact(
            FirstName = 'Test',
            LastName = 'Contact',
            AccountId = account.Id,
            RecordTypeId = '012bm0000051KWV');
        insert contact;

        Opportunity opportunity = new Opportunity(
            Name = 'Test Opportunity',
            CloseDate = Date.today(),
            StageName = 'Prospecting',
            AccountId = account.Id
        );
        insert opportunity;
    }

    @IsTest
    static void testConvertLeads() {
        List<InvocableLeadConvert.ConvertLeadRequest> requests = new List<InvocableLeadConvert.ConvertLeadRequest>();
        InvocableLeadConvert.ConvertLeadRequest request = new InvocableLeadConvert.ConvertLeadRequest();
        request.leadId = [SELECT Id FROM Lead WHERE Company = 'Test Company' AND FirstName = 'Test' LIMIT 1].Id;
        request.convertedStatus = 'Closed - Converted';
        requests.add(request);
        List<InvocableLeadConvert.ConvertLeadResult> results = new List<InvocableLeadConvert.ConvertLeadResult>();

        Test.startTest();
            results = InvocableLeadConvert.convertLeads(requests);
        Test.stopTest();
        
        InvocableLeadConvert.ConvertLeadResult result = results[0];
        
        System.assertEquals(1, results.size());
        System.assertNotEquals(null, result.accountId);
        System.assertNotEquals(null, result.contactId);
        System.assertNotEquals(null, result.opportunityId);
    }
    
    
    @IsTest
    static void testConvertLead() {
        InvocableLeadConvert.ConvertLeadRequest request = new InvocableLeadConvert.ConvertLeadRequest();
        request.leadId = [SELECT Id FROM Lead WHERE Company = 'Test Company' AND FirstName = 'Test' LIMIT 1].Id;
        Account acc = [SELECT Id,RecordTypeId FROM Account WHERE Name = 'Test Account' LIMIT 1];
        request.accountId = acc.Id;
        request.recordTypeId = acc.RecordTypeId;

        request.opportunityId = [SELECT Id FROM Opportunity WHERE Name = 'Test Opportunity' LIMIT 1].Id;

        request.convertedStatus = 'Closed - Converted';
        
        Test.startTest();
            InvocableLeadConvert.ConvertLeadResult result = InvocableLeadConvert.convertLead(request);
        Test.stopTest();
        
        System.assertNotEquals(null, result.accountId);
        System.assertNotEquals(null, result.contactId);
        System.assertNotEquals(null, result.opportunityId);
    }
    @IsTest
    static void testConvertLeadWithAccountAndOpportunityAndContact() {
        InvocableLeadConvert.ConvertLeadRequest request = new InvocableLeadConvert.ConvertLeadRequest();
        
        request.leadId = [SELECT Id FROM Lead WHERE Company = 'Test Company' AND FirstName = 'Test' LIMIT 1].Id;
        request.accountId = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1].Id;
        
        Contact contact = [SELECT Id,RecordTypeId FROM Contact WHERE FirstName = 'Test' AND LastName = 'Contact' LIMIT 1];
        request.contactId = contact.Id;
        request.recordTypeId = contact.RecordTypeId;
        
        Opportunity opportunity = [SELECT Id,Name FROM Opportunity WHERE Name = 'Test Opportunity' LIMIT 1];
        request.opportunityName = opportunity.Name;

        request.convertedStatus = 'Closed - Converted';
        
        Test.startTest();
            InvocableLeadConvert.ConvertLeadResult result = InvocableLeadConvert.convertLead(request);
        Test.stopTest();
        
        System.assertNotEquals(null, result.accountId);
        System.assertNotEquals(null, result.contactId);
        System.assertNotEquals(null, result.opportunityId);
    }
    
}