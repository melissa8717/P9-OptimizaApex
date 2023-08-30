/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-27-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
global class UpdateAllAccountOrderedBatch implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext info){ 
       //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Activated'
       return Database.getQueryLocator('SELECT Id,AccountId, Status FROM Order WHERE Status=\'Activated\' ');
   }
   global void execute(Database.BatchableContext info, List<Order> listOrders){ 
   
       OrderTotal instance = new OrderTotal();
       instance.getTotal(listOrders);
   }    
    
   global void finish(Database.BatchableContext info){     
       
   } 
}
