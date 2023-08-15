/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-15-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger UpdateAccountCA on Order (after update) {
    	
     OrderTotal instance = new OrderTotal();
     instance.getTotal(trigger.new); 

 //Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id =:newOrder.AccountId ];
// acc.Chiffre_d_affaire__c = (Decimal)instance.getTotal();
 //update acc;
     
}