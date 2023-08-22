/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-15-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public without sharing class OrderTotal {
    public void getTotal(List<Order> orders){
        system.debug('order'+orders);
        List<Account> accounts = [SELECT id,Chiffre_d_affaire__c FROM Account];

            for(integer i=0; i < orders.size(); i++){
               if(orders[i].AccountId == accounts[i].Id){
                  Id accountId =accounts[i].Id;
                  AggregateResult[] resultQuery = database.query('SELECT SUM(TotalAmount) sumAmount FROM Order WHERE AccountId=:accountId');
       			  Decimal totalAmount = (Decimal)resultQuery[0].get('sumAmount');
                  accounts[i].Chiffre_d_affaire__c = accounts[i].Chiffre_d_affaire__c + totalAmount;
               	
               }                   
             
        }
        update accounts;
    }
}