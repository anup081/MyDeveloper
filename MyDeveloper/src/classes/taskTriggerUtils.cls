public class taskTriggerUtils {
	
	public static void createTaskForChildAccUsers(List<Task> newList){
		
			// define varibles
			Set<Id> currentParentaccIdSet  = new Set<Id>();
			Map<Id, Set<Id>> userMap = new Map<Id, Set<Id>>();
			Map<Id, Task> accId2TaskMap = new Map<Id, Task>();
			
			System.debug('Aebug : trigger.new = '+newList);
			
			//Collect all the what id for an Account
			for(Task tsk : newList){
				String str = tsk.whatId;
						
				if(str != null){str = str.substring(0,3);}
						
				if(str == '001'){
					currentParentaccIdSet.add(tsk.whatId);
					accId2TaskMap.put(tsk.whatId, tsk);
					userMap.put(tsk.whatId, new Set<Id>());
				}	
					
			}
			
			System.debug('Aebug : currentParentaccIdSet = '+currentParentaccIdSet);
			//If there are no account Ids return without doing anything.
			if(currentParentaccIdSet.size() == 0){
				return;
			}
			
			Boolean endOfStructure = false;
			Integer step = 0;
			Map<Id, Id> orgAcc2AccIdMap = new Map<Id, Id>();
			
			// collect all the owner id for the child accounts
			while(!endOfStructure){
				
				System.debug('Aebug : currentParentaccIdSet = '+currentParentaccIdSet);
				System.debug('Aebug : orgAcc2AccIdMap = '+orgAcc2AccIdMap);
				
				List<Account> al = [select OwnerId, Id, ParentId, Name from Account where ParentId in : currentParentaccIdSet];
				
				System.debug('Aebug : al = '+al);
				
				//Check for the 0 level and set end of structrue flag to true
				if(al.size() == 0){
					endOfStructure = true;
				}else{					
					if(step == 0){ // when queried for the first child
						for(Account acc : al){
							currentParentaccIdSet.clear();						
							userMap.get(acc.ParentId).add(acc.OwnerId);
							currentParentaccIdSet.add(acc.id);
							orgAcc2AccIdMap.put(acc.id, acc.ParentId);
						}
						step++;
						
					}else{// when queried for the second child and so on
						currentParentaccIdSet.clear();
						for(Account acc : al){
							orgAcc2AccIdMap.put(acc.id,orgAcc2AccIdMap.get(acc.ParentId));							
							userMap.get(orgAcc2AccIdMap.get(acc.ParentId)).add(acc.OwnerId);
							currentParentaccIdSet.add(acc.id);
							orgAcc2AccIdMap.remove(acc.ParentId);
						}
					}
					
				}
			
			}
			
			System.debug('Aebug : userMap = '+userMap);
			
			//create insert list to insert task for different users.
			List<Task> task2InsertList = new List<Task>();
			
			// create the task for each unique users:			
			for(Task tsk : newList){
				for(Id usrId : userMap.get(tsk.whatId)){
					Task obj = new Task();
					obj.CallDisposition=tsk.CallDisposition; 
					obj.ActivityDate=tsk.ActivityDate;					
					obj.RecurrenceTimeZoneSidKey=tsk.RecurrenceTimeZoneSidKey; 
					obj.RecurrenceInstance=tsk.RecurrenceInstance;
					obj.RecurrenceType=tsk.RecurrenceType;
					obj.CallType=tsk.CallType;					
					obj.CallObject=tsk.CallObject; 
					obj.RecurrenceEndDateOnly=tsk.RecurrenceEndDateOnly; 
					obj.RecurrenceMonthOfYear=tsk.RecurrenceMonthOfYear;					 
					obj.RecurrenceStartDateOnly=tsk.RecurrenceStartDateOnly; 
					obj.RecurrenceDayOfMonth=tsk.RecurrenceDayOfMonth;
					obj.Type=tsk.Type;
					obj.OwnerId=usrId; 
					obj.IsRecurrence=tsk.IsRecurrence; 
					obj.IsVisibleInSelfService=tsk.IsVisibleInSelfService; 
					obj.IsReminderSet=tsk.IsReminderSet;					
					obj.Description=tsk.Description; 
					obj.CallDurationInSeconds=tsk.CallDurationInSeconds;				
					obj.Subject=tsk.Subject; 
					obj.RecurrenceInterval=tsk.RecurrenceInterval; 
					obj.RecurrenceDayOfWeekMask=tsk.RecurrenceDayOfWeekMask; 
					obj.Priority=tsk.Priority;					 
					obj.Status=tsk.Status;
					obj.ReminderDateTime=tsk.ReminderDateTime;
					
					// add the new object to the insert list
					task2InsertList.add(obj);
				}
				
			}
			
			system.debug('Aebug : task2InsertList = '+task2InsertList);
			
			//insert the task if the list size is greater than zero.
			if(task2InsertList.size() > 0){
				insert task2InsertList;
			}
	}

}