/*
@ Anupam
@ 06/01/2012
Provides an example of an Apex REST class with three methods that you can call to
delete a record, get a record, and update a record.
This sample shows you how to implement a simple REST API in Apex that handles three different HTTP request methods.
*/

@RestResource(urlMapping='/GetService/*')
global with sharing class MyRestResource {
	
	@HttpDelete
	global static void doDelete(){
		Restrequest req = RestContext.request;
		RestResponse res = RestContext.response;
		String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
		Account account = [SELECT Id FROM Account WHERE Id = :accountId];
		delete account;
	}
	
	@HttpGet
	global static Account doGet() {
		RestRequest req = RestContext.request;
		RestResponse res = RestContext.response;
		String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
		Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accountId];
		return result;
		}
	
	@HttpPost
	global static String doPost() {
		RestRequest req = RestContext.request;
		RestResponse res = RestContext.response;
		System.debug('Qebug : Post Request ='+req);
		Account account = new Account();
		account.Name = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
		//account.phone = req.param.get('phone');
		//account.website = req.param.get('website');
		insert account;
		return account.Id;
		}

}