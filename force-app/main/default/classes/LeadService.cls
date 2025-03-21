public with sharing class LeadService {
    
    @InvocableMethod(label='Convert Leads')
    public static List<ConvertLeadResult> convertLeads(List<ConvertLeadRequest> requests) {
        List<ConvertLeadResult> results = new List<ConvertLeadResult>();
        for (ConvertLeadRequest request : requests) {
            results.add(convertLead(request));
        }
        return results;
    }
    
    public static ConvertLeadResult convertLead(ConvertLeadRequest request) {
        Database.LeadConvert lc = new Database.LeadConvert();
        lc.setLeadId(request.leadId);
        lc.setConvertedStatus(request.convertedStatus);
        
        if (request.accountId != null) {
            lc.setAccountId(request.accountId);
        }
        
        if (request.contactId != null) {
            lc.setContactId(request.contactId);
        }
        
        if (request.overWriteLeadSource != null && request.overWriteLeadSource) {
            lc.setOverwriteLeadSource(request.overWriteLeadSource);
        }
        
        if (request.createOpportunity != null && !request.createOpportunity) {
            lc.setDoNotCreateOpportunity(!request.createOpportunity);
        }
        
        if (request.opportunityName != null) {
            lc.setOpportunityName(request.opportunityName);
        }
        
        if (request.ownerId != null) {
            lc.setOwnerId(request.ownerId);
        }
        
        if (request.sendEmailToOwner != null && request.sendEmailToOwner) {
            lc.setSendNotificationEmail(request.sendEmailToOwner);
        }
        
        Database.LeadConvertResult lcr = Database.convertLead(lc, true);
        if (lcr.isSuccess()) {
            ConvertLeadResult result = new ConvertLeadResult();
            result.accountId = lcr.getAccountId();
            result.contactId = lcr.getContactId();
            result.opportunityId = lcr.getOpportunityId();
            return result;
        } else {
            throw new ConvertLeadException(lcr.getErrors()[0].getMessage());
        }
    }
    
    public class ConvertLeadRequest {
        @InvocableVariable(required=true)
        public ID leadId;
        
        @InvocableVariable(required=true)
        public String convertedStatus;
        
        @InvocableVariable
        public ID accountId;
        
        @InvocableVariable
        public ID contactId;
        
        @InvocableVariable
        public Boolean overWriteLeadSource;
        
        @InvocableVariable
        public Boolean createOpportunity;
        
        @InvocableVariable
        public String opportunityName;
        
        @InvocableVariable
        public ID ownerId;
        
        @InvocableVariable
        public Boolean sendEmailToOwner;
    }
    
    public class ConvertLeadResult {
        @InvocableVariable
        public ID accountId;
        
        @InvocableVariable
        public ID contactId;
        
        @InvocableVariable
        public ID opportunityId;
    }
    
    class ConvertLeadException extends Exception {}
    
}