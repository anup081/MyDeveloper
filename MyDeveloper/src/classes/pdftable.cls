public class pdftable {

    public pdftable(ApexPages.StandardController controller) {
        accList = [Select a.CreatedById, a.Budget_Low__c, a.Budget_High__c, a.BillingStreet, a.BillingState, a.BillingPostalCode, a.BillingCountry, a.BillingCity, a.AnnualRevenue, a.Active__c, a.Account_Description__c, a.AccountNumber From Account a limit 10];

    }


public List<Account> accList{get;set;}

public pdftable(){

accList = [Select a.CreatedById, a.Budget_Low__c, a.Budget_High__c, a.BillingStreet, a.BillingState, a.BillingPostalCode, a.BillingCountry, a.BillingCity, a.AnnualRevenue, a.Active__c, a.Account_Description__c, a.AccountNumber From Account a limit 10];

}


}