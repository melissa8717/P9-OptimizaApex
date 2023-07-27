/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-26-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class UpdateAllAccountCA implements Database.Batchable<sObject>{
   // public UpdateAmountAccount() {
    public Integer recordsProcessed = 0;
        public Database.QueryLocator start(Database.BatchableContext bc) {
            // collect the batches of records or objects to be passed to execute
            return Database.getQueryLocator('SELECT  Id, Chiffre_d_affaire__c FROM Account');

        }
        public void execute(Database.BatchableContext bc, List<Account> accList){
            //account to update
            List<Account> accounts = new List<Account>();
            for (Account scope_account : accList) {
                for (Account account : accounts) {
                    if(account.id==scope_account.id){
                        account.Chiffre_d_affaire__c =scope_account.Chiffre_d_affaire__c;
                    
                    // add account to list to be updated
                    accounts.add(account);
                    // increment the instance member counter
                    recordsProcessed = recordsProcessed + 1;
                    }
                }
            }
            update accounts;
        }
        public void finish(Database.BatchableContext bc){
            // execute any post-processing operations
            System.debug(recordsProcessed + ' records processed. Shazam!');

        }
    //}
}