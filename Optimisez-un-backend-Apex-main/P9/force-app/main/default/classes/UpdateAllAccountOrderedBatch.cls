/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-27-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
global class UpdateAllAccountOrderedBatch implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext info){ 
       //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
       //return Database.getQueryLocator('SELECT Id FROM Account');
       return Database.getQueryLocator('SELECT AccountId, Status FROM Order WHERE Status = "Ordered"');
   }
    
   global void execute(Database.BatchableContext info, List<Account> scope){      
       List<Order> listOrders =  [SELECT Id, TotalAmount, AccountId FROM Order];
		for(integer i=0; i < scope.size(); i++){
			Account myAccount = scope[i];
			myAccount.Chiffre_d_affaire__c = 0;
           for(integer j=0; j < listOrders.size(); j++){
               if(listOrders[j].AccountId == myAccount.Id){
                   myAccount.Chiffre_d_affaire__c = myAccount.Chiffre_d_affaire__c + listOrders[j].TotalAmount;
               }                   
           }
       }
       
       update scope;
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}