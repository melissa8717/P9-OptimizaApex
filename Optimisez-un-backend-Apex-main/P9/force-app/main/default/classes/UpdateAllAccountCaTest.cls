w/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-26-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
private class UpdateAllAccountCATest {
    @testSetup
    static void setup() {
        List<Account> accList = DataCreatingClass.createAccount();
		insert accList; 
        
    }
    @isTest static void test() {
        Test.startTest();
        UpdateAllAccountCA ca = new UpdateAllAccountCA();
        Id batchId = Database.executeBatch(ca);
       
        Test.stopTest();
        System.assertNotEquals(0, [select count() from account where Chiffre_d_affaire__c = 6500]);
    }
    
}
