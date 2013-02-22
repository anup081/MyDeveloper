public with sharing class RestTestController {

   public String getname {get;set;}
    public String name{get;set;}
    public String url{get;set;}
    public String requestType{get;set;}
    
     public RestTestController(){
     	url = 'https://ap1.salesforce.com/services/apexrest/GetService/';
     }
     
     public PageReference submit()     {
    	 
    	
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod(requestType);
        //String url = 'https://ap1.salesforce.com/services/apexrest/GetService/001900000095Itk';        
        if(requestType != 'BLANK'){
        	req.setEndpoint(url);
        }
        
        req.setHeader('Authorization', 'OAuth '+UserInfo.getSessionId());
        System.debug('Qebug : session id :' +UserInfo.getSessionId());
        HTTPResponse resp = http.send(req);
        system.debug(resp);
        getname = resp.getBody();
        return null;
    }
    
    
    
    


}