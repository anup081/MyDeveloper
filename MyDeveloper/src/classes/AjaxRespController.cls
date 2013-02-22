public class AjaxRespController { //this is a test page
    public JSONObject json {get;set;}
     
    /** invoked on an Ajax request */   
    public void doSearch() {
        Map<string,string> params = ApexPages.currentPage().getParameters();
        json = new JSONObject();
         
        // Do SOQL query to see if there are any records !
        List<Contact> records = getRecords(params.get('q'));
         
        if (!records.isEmpty()) {
            // Jsonify the results !
            List<JSONObject.value> values = new List<JSONObject.value>(); 
            for (Contact c : records) {
                JSONObject cjson = new JSONObject();
                cjson.putOpt('name', new JSONObject.value(c.Name));
                cjson.putOpt('email', new JSONObject.value(c.email));
                values.add(new JSONObject.value(cjson));
            }   
            json.putOpt('contacts', new JSONObject.value(values));
             
        }
    }
     
    // Does the SOQL query, using Ajax request data
    public List<Contact> getRecords(String contactName) {
        List<Contact> records = new List<Contact>();
        if (contactName != null && contactName.trim().length() > 0){
            // Protect from SOQL injection            
            String contactNameToFilter = '%' + contactName  + '%';
            records = [select id, name, email from contact where Name like :contactNameToFilter];
             
        }   
        return records;      
    }    
 
    // Returns the JSON result string
    public String getResult() {
        return json.ValuetoString();
    }
     
}