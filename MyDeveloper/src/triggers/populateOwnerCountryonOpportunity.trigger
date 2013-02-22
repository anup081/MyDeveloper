trigger populateOwnerCountryonOpportunity on Opportunity (after update) {
List<User> lstUser = new List<User>();
Set<String> setOwnerid = new Set<String>();
Set<id> setAccountid = new Set<id>();
List<Account> lstAcc = new List<Account>();
List<Opportunity> UpdateOpps = new List<Opportunity>();
Integer closingIMonth;
string closingSMonth;
Integer closingIYear;
string closingSYear;


for(Opportunity objopp: Trigger.new){
    setAccountid.add(objopp.AccountId);
}

System.debug('aebug: setAccountid = '+setAccountid);

lstAcc = [Select 
          Ownerid,
          name 
          from Account 
          where id IN:setAccountid];
            
system.debug('lstAcc-->'+lstAcc);

/* Updating the Opportunity Owner with Account owner field */

for(Opportunity objopp: Trigger.new){
	System.debug('aebug: objopp.Keep_Manual_Primary_Flag__c = '+objopp.Keep_Manual_Primary_Flag__c);
    if(objopp.Keep_Manual_Primary_Flag__c == false ){
        for(Account objacc: lstAcc){
        	boolean falg = (objopp.AccountId == objacc.Id);
        	System.debug('aebug: objopp.AccountId == objacc.Id = '+falg);
        	if(objopp.AccountId == objacc.Id){
        		system.debug('i am in test');
        		if(objopp.OwnerId != objacc.OwnerId){
	        		Opportunity opp = new Opportunity(id=objopp.id);
	        		opp.OwnerId = objacc.OwnerId;
	            	UpdateOpps.add(opp);           
        		}
            //setOwnerid.add(objopp.OwnerId);            
            //system.debug('setOwnerid1--->'+setOwnerid);
        }

    }

//setOwnerid.add(objopp.OwnerId);
//objopp.ForecastCategoryName = objopp.Forecast_Category__c;
 }
}
System.debug('aebug: UpdateOpps = '+UpdateOpps);
if(UpdateOpps.size() > 0)
	update UpdateOpps;

/*
system.debug('setOwnerid-->'+setOwnerid);
// Searching the country field from User record based on Opportunity Record. 
lstUser= [Select id, country,alias,VZ_ID__c from User where id IN:setOwnerid];
for(Opportunity objopp: Trigger.new){

closingIMonth = objopp.CloseDate.month();

closingSMonth = clsIsRunGlobalVariables.returnMonth(closingIMonth);

closingIYear = objopp.CloseDate.Year();

closingSYear = String.valueof(closingIYear);

for(User objuser:lstUser){

if((objopp.OwnerId == objuser.id) && objuser.Country!=null ){

objopp.Opportunity_Owner_Country__c = objuser.Country;

system.debug('objopp.Opportunity_Owner_Country__c-->'+objopp.Opportunity_Owner_Country__c);

}

system.debug('objopp.OwnerId-->'+objopp.OwnerId);

system.debug('objuser.id -->'+objuser.id);

if(objopp.OwnerId == objuser.id && objuser.VZ_ID__c != null ){

objopp.Forecast_unique__c = objuser.VZ_ID__c+objuser.alias+closingIYear+closingSMonth ;

system.debug('objopp.Forecast_unique__c-->'+objopp.Forecast_unique__c);

}

}

System.debug('objopp--->'+objopp);

}*/

}