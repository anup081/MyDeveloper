global with sharing class remoteTest {
public String accountName { get; set; }
public static Account account { get; set; }
public remoteTest() { } // empty constructor 
    
 @RemoteAction
global static Account getAccount(String accountName) {
        account = [SELECT id, name, phone, type, numberofemployees FROM 
                   Account WHERE name = :accountName];
        return account;
    }
}