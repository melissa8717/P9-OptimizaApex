/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-27-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public without sharing class OrderTotal {
    public void getTotal(List<Order> orders){
        system.debug('orders'+orders);
      Map<Id, Decimal> accountMap = new Map<Id, Decimal>();           
          
      List<Account> resultAccount= null;

      resultAccount = [SELECT Id, Chiffre_d_affaire__c FROM Account];
        for(Integer i =0; i<orders.size();i++){
          	accountMap.put((Id)resultAccount[i].get('Id'), (Decimal)resultAccount[i].get('Chiffre_d_affaire__c'));
         }
       
       
        Decimal ca =0;
        AggregateResult[] orderTotal = database.query('select SUM(TotalAmount) total FROM Order WHERE Id in:orders');
 system.debug(orderTotal);
         for(Order ord : orders){
                if(accountMap.containsKey(ord.AccountId)==true){
                     for(Integer i=0;i<orderTotal.size();i++){
                        Decimal total = (Decimal)orderTotal[i].get('total');
            			resultAccount[i].Chiffre_d_affaire__c += total;
           			  }
                    system.Debug('ca'+ca);
                }
            }
 
        }
     
        public void getTotal(List<Account> accounts){
        	    // Use a map to store the total amount for each account 
            Map<Id, Decimal> accountCA = new Map<Id, Decimal>();
           
            AggregateResult[] resultOrder= null;
            for(Integer i=0;i<accounts.size();i++){
                Id accountId = accounts[i].Id;
                 system.debug('accs'+accountId);
            	resultOrder = database.query('SELECT AccountId, SUM(TotalAmount) totalAmount FROM Order WHERE AccountId=:accountId GROUP BY AccountId');            
            }

           for(Integer i=0;i<resultOrder.size();i++){
                accountCA.put((Id)resultOrder[i].get('AccountId'),(Decimal)resultOrder[i].get('totalAmount'));
           }
           
            for(Account acc : accounts){
                if(accountCA.containsKey(acc.Id)==true){
                acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + accountCA.get('TotalAmount');
                }
            }
            if(accounts.size()!=0){
            	update accounts;
            }

            
        }

}
