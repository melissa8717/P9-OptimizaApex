/**
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
        List<Account> accounts = new List<Account>();
        List<Contact> contacts = new List<Contact>();
        // insert 10 accounts
        for (Integer i=0;i<10;i++) {
            accounts.add(new Account(name='Account '+i,
                Chiffre_d_affaire__c=6500));
        }
        insert accounts;
        
    }
    @isTest static void test() {
        Test.startTest();
        UpdateAllAccountCA ca = new UpdateAllAccountCA();
        Id batchId = Database.executeBatch(ca);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(10, [select count() from account where Chiffre_d_affaire__c = 6500]);
    }
}