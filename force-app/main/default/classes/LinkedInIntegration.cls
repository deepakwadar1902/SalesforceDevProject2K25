public class LinkedInIntegration {

        Public static void postOnLinkedId(String Message){
        
        String loginId = loginToLinkedIn();
       	postMassage(loginId, Message);
    }
    public static String loginToLinkedIn(){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('callout:LinkedInToSFNamc/v2/me');
        
        HttpResponse res = http.send(req);
        //System.debug('response : ' + res.getBody());
        //System.debug('Status Code : ' + res.getStatusCode());
        
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        String loginId = (String)result.get('id');
        //System.debug('Login Id : ' + loginId);
        return loginId;
    }
    
    
    public static void postMassage(String loginId, String postMassage){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('X-Restli-Protocol-Version', '2.0.0');
        req.setHeader('Content-Type', 'application/json');
        String authorId = 'urn:li:person:' + loginId;
        String linkedInPostBody = 
           '  {  ' +
                ' "author": " '+authorId+' ", ' +
                ' "lifecycleState": "PUBLISHED", ' +
                ' "specificContent": { ' +
                    ' "com.linkedin.ugc.ShareContent": { ' +
                        ' "shareCommentary": { ' +
                            ' "text": "'+postMassage+'" ' +
                        ' }, ' +
                        ' "shareMediaCategory": "NONE" ' +
                    ' } ' +
                ' }, ' +
                ' "visibility": { ' +
                 '    "com.linkedin.ugc.MemberNetworkVisibility": "PUBLIC" ' +
                ' } ' +
            ' }	';
        
        req.setBody(linkedInPostBody);
        req.setEndpoint('callout:LinkedInToSFNamc/v2/ugcPosts');
        
        HttpResponse res = http.send(req);
        System.debug('Response : ' + res.getBody());
        System.debug('Status Code : ' + + res.getStatusCode());
    }
}