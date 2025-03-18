public with sharing class CaseService {
    
    public static void closeCases(Set<Id> caseIds,String closeReason){
        for(List<Case> cases : [SELECT Id,Status,Reason FROM Case WHERE Id IN :caseIds]){
            for(Case c : cases){
                c.Status = 'Closed';
                c.Reason = closeReason;
            }
            update cases;
        }
    }

}