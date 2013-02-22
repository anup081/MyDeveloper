public class VerifyPassword {

    public final String LOGIN_DOMAIN = 'www'; //other options: test, prerellogin.pre
    
    public String password {get; set;}

    public String username { get{return UserInfo.getUsername();} }

   
    //this method is to verify the password. prepare the http request
    public PageReference doVerify() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://' + LOGIN_DOMAIN + '.salesforce.com/services/Soap/u/22.0');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'text/xml; charset=UTF-8');
        request.setHeader('SOAPAction', '""');
        request.setBody(buildSoapLogin(username,password));
        
        //if there is a loginResponse element, then login succeeded; else there would be soap fault element after body
        
        final boolean verified = (new Http()).send(request).getBodyDocument().getRootElement()
        .getChildElement('Body','http://schemas.xmlsoap.org/soap/envelope/')
        .getChildElement('loginResponse','urn:partner.soap.sforce.com') != null;
        
        if(verified){
        	Apexpages.addMessage(new Apexpages.Message(Apexpages.Severity.CONFIRM, 'Correct Password'));
        }else{
        	Apexpages.addMessage(new Apexpages.Message(Apexpages.Severity.ERROR, 'InCorrect Password'));
        }
        
        return null;
    }
    
    
    //this method is to build soap login
    public static String buildSoapLogin(String username, String password){
    	
    	Xmlstreamwriter w = new Xmlstreamwriter();
    	w.writeStartElement('', 'login', 'urn:partner.soap.sforce.com');
    	w.writeNamespace('', 'urn:partner.soap.sforce.com');
    	w.writeStartElement('', 'username', 'urn:partner.soap.sforce.com');
    	w.writeCharacters(username);
    	w.writeEndElement();
    	w.writeStartElement('', 'password', 'urn:partner.soap.sforce.com');
    	w.writeCharacters(password);
    	w.writeEndElement();
    	w.writeEndElement();
    	
    	String xmlOutput = '<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/"><Body>'
    						+ w.getXmlString()
    						+ '</Body></Envelope>';
    	
    	w.close();
    	return xmlOutput;
    	
    }

}