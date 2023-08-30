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

    }

    @isTest static void test() {
    	
         List<Order> orders = [SELECT Id, Status FROM Order LIMIT 150];
        for(Order order: orders){
            order.status = 'Activated';
        }
        update orders;
        
        Test.startTest();
      
		UpdateAllAccountOrderedBatch up = new UpdateAllAccountOrderedBatch();
        Id batchId = Database.executeBatch(up);


        Test.stopTest();
        List<Account> acc = [SELECT id,Chiffre_d_affaire__c FROM Account LIMIT 1];
        Id accountId = acc[0].id;
        List<Order>order = [SELECT id, Status FROM Order WHERE Status='Activated'];

    
        AggregateResult[] resultQuery = database.query('SELECT SUM(TotalAmount) sumAmount FROM Order WHERE AccountId=:accountId');
        System.debug('resultQuery'+resultQuery);
        Decimal total = (Decimal)resultQuery[0].get('sumAmount');
        Decimal ca = acc[0].Chiffre_d_affaire__c + total;
        for(Account account : acc){
            System.assertEquals(426500.00,ca );
        }
    }
}
