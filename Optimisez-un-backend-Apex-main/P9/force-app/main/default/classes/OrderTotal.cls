/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-15-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public without sharing class OrderTotal {
    public void getTotal(List<Order> orders){
        List<Account> accounts = [SELECT id,Chiffre_d_affaire__c FROM Account];

            for(integer i=0; i < orders.size(); i++){
               if(orders[i].AccountId == accounts[i].Id){
                   accounts[i].Chiffre_d_affaire__c = accounts[i].Chiffre_d_affaire__c + orders[i].TotalAmount;
               	
               }                   
             
        }
    }
}