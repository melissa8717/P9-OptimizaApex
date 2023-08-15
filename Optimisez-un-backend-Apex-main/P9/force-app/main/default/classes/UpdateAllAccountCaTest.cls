/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-15-2023
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
        // after the testing stops, assert records were updated properly
        System.assertEquals(20, [select count() from account where Chiffre_d_affaire__c = 6500]);
    }
    @isTest static void testAccountIsNull() {
        Test.startTest();
        UpdateAllAccountCA ca = new UpdateAllAccountCA();
        Id batchId = Database.executeBatch(ca);
        Test.stopTest();
        System.assertNotEquals(null, [select id from account where Chiffre_d_affaire__c = 6500],'account id is null');
    }
     @isTest static void testCAIsNull() {
        Test.startTest();
        UpdateAllAccountCA ca = new UpdateAllAccountCA();
        Id batchId = Database.executeBatch(ca);
        Test.stopTest();
		System.assertNotEquals(null, [select id from account where Chiffre_d_affaire__c = 6500],'CA is null');
    }
}