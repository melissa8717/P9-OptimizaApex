/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-26-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class UpdateAllAccountCABatch implements Database.Batchable<sObject>{
        public Database.QueryLocator start(Database.BatchableContext bc) {
            // collect the batches of records or objects to be passed to execute
            return Database.getQueryLocator('SELECT  Id, Chiffre_d_affaire__c FROM Account');

        }
        public void execute(Database.BatchableContext bc, List<Account> accList){
			OrderTotalController instance = new OrderTotalController();
    		instance.getTotal(accList);            
            update accList;
        }
        public void finish(Database.BatchableContext bc){
        }
    
}