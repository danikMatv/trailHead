@isTest
private class LeadServiceTest {
    
    private static Lead createTestLead() {
        Lead lead = new Lead();
        lead.FirstName = 'Test';
        lead.LastName = 'Lead';
        lead.Company = 'Test Company';
        lead.Status = 'Open';
        insert lead;
        return lead;
    }

    @IsTest
    static void testConvertLeads() {
        List<LeadService.ConvertLeadRequest> requests = new List<LeadService.ConvertLeadRequest>();
        LeadService.ConvertLeadRequest request = new LeadService.ConvertLeadRequest();
        request.leadId = createTestLead().Id;
        request.convertedStatus = 'Closed - Converted';
        requests.add(request);
        List<LeadService.ConvertLeadResult> results = new List<LeadService.ConvertLeadResult>();

        Test.startTest();
            results = LeadService.convertLeads(requests);
        Test.stopTest();
        
        LeadService.ConvertLeadResult result = results[0];
        
        System.assertEquals(1, results.size());
        System.assertNotEquals(null, result.accountId);
        System.assertNotEquals(null, result.contactId);
        System.assertNotEquals(null, result.opportunityId);
    }
    
    
    @IsTest
    static void testConvertLead() {
        LeadService.ConvertLeadRequest request = new LeadService.ConvertLeadRequest();
        request.leadId = createTestLead().Id;
        request.convertedStatus = 'Closed - Converted';
        
        Test.startTest();
            LeadService.ConvertLeadResult result = LeadService.convertLead(request);
        Test.stopTest();
        
        System.assertNotEquals(null, result.accountId);
        System.assertNotEquals(null, result.contactId);
        System.assertNotEquals(null, result.opportunityId);
    }
    
}