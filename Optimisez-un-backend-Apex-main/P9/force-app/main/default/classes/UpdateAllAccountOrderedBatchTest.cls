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
 
        system.debug('ord'+orders);

    }

    @isTest static void test() {
    
        Test.startTest();
      
		UpdateAllAccountOrderedBatch up = new UpdateAllAccountOrderedBatch();
        Id batchId = Database.executeBatch(up);


        Test.stopTest();
        List<Account> acc = [SELECT id,Chiffre_d_affaire__c FROM Account LIMIT 1];
        Id accountId = acc[0].id;
        List<Order>order = [SELECT id, Status FROM Order WHERE Status='Activated'];
        up.execute(null, order);

        
    
        AggregateResult[] resultQuery = database.query('SELECT SUM(TotalAmount) sumAmount FROM Order WHERE AccountId=:accountId');
        System.debug('resultQuery'+resultQuery);
        Decimal total = (Decimal)resultQuery[0].get('sumAmount');
        Decimal ca = acc[0].Chiffre_d_affaire__c + total;
        for(Account account : acc){
            System.assertEquals(406500.00,ca );
        }
        //System.assertEquals(ca, [select Id, Chiffre_d_affaire__c from Account where Chiffre_d_affaire__c = 7500]);
    }
}