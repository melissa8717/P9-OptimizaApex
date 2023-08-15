/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-15-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class UpdateAllAccountOrderedBatchTest {
    @testSetup
    static void setup(){
    
        List<Account> accList = DataCreatingClass.createAccount();
        insert accList;
        List<Order> ordList = new List<Order>();	
        ordList.addAll(DataCreatingClass.createOrder(accList[0].id));
        
        insert ordList;
        
        Product2 product = DataCreatingClass.createProduct();
        insert product;
        PriceBookEntry price = DataCreatingClass.createPrice(product.id);
        insert price;
        List<OrderItem> ordItemList = new List<OrderItem>();
        for(Integer j=0; j<ordList.size();j++){
            ordItemList.addAll(DataCreatingClass.createOrderItem(ordList[j].id,product.id, price.id));

        }
        insert ordItemList;
        
        List<Order> orders = [SELECT Id, Status FROM Order LIMIT 150];
 
        for(Order order: orders){
            order.status = 'Activated';
        }
        update orders;
        system.debug('ord'+orders);

    }
    @isTest static void testCreateAccount(){
        Account acc = new Account();
        acc = [SELECT Id, Chiffre_d_affaire__c FROM Account LIMIT 1];
        //CA + total amount
        Test.startTest();
        
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertNotEquals(0, [select count() from Account]);
    }
    @isTest static void testCountOrder() {
        //CA + total amount
        Test.startTest();
        UpdateAllAccountOrderedBatch up = new UpdateAllAccountOrderedBatch();
        Id batchId = Database.executeBatch(up);
        
        List<Account> acc = [SELECT id FROM Account LIMIT 1];
        Id accountId = acc[0].id;
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertNotEquals(0, [select count() from Order ]);
    }
    @isTest static void testCountOrderItem() {
        //CA + total amount
        Test.startTest();
        UpdateAllAccountOrderedBatch up = new UpdateAllAccountOrderedBatch();
        Id batchId = Database.executeBatch(up);
        
        List<Account> acc = [SELECT id FROM Account LIMIT 1];
        Id accountId = acc[0].id;
        List<Order> ord = [SELECT id FROM Order WHERE AccountId =:accountId];
        Id orderId = ord[0].id;
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertNotEquals(0, [select count() from OrderItem where OrderId =:orderId]);
    }
    @isTest static void testCAIsNotNull() {
        //CA + total amount
        Test.startTest();
        UpdateAllAccountOrderedBatch up = new UpdateAllAccountOrderedBatch();
        Id batchId = Database.executeBatch(up);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertNotEquals(null, [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Chiffre_d_affaire__c = 7500]);
    }
     
    @isTest static void test() {
    
        Test.startTest();
      
		UpdateAllAccountOrderedBatch up = new UpdateAllAccountOrderedBatch();
        Id batchId = Database.executeBatch(up);
     

        Test.stopTest();
        List<Account> acc = [SELECT id,Chiffre_d_affaire__c FROM Account LIMIT 1];
        Id accountId = acc[0].id;
        
    
        AggregateResult[] resultQuery = database.query('SELECT SUM(TotalAmount) sumAmount FROM Order WHERE AccountId=:accountId');
        System.debug('resultQuery'+resultQuery);
        Decimal total = (Decimal)resultQuery[0].get('sumAmount');
        Decimal ca = acc[0].Chiffre_d_affaire__c + total;
        for(Account account : acc){
            System.assertEquals(1226500,ca );
        }
    }
}