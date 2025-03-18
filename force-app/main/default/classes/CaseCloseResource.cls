@RestResource(urlMapping='/case/*/close')
global with sharing class CaseCloseResource {
    
    @HttpPost
    global static void closeCase(String reason){
        RestRequest req = RestContext.request;
        String caseId = req.requestURI.substringBetween('/case/', '/close');
        CaseService.closeCases(new Set<Id>{caseId}, reason);
    }
}