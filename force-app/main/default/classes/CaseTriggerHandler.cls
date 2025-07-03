public class CaseTriggerHandler {

    //1.Whenever a case is created with origin as email then set status as new and Priority as Medium. 
    
    public static void updateCaseStatusPriority(List<Case> caseList){
        
        for(Case cs : caseList){
            
            if(cs.Origin == 'Email' && cs.Status == 'New'){
                //cs.Status = 'New';    //Required field
                cs.Priority = 'Medium';
            }
        }
    }
}