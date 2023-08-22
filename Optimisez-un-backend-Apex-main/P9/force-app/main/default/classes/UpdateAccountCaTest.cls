/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-22-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public class UpdateAccountCaTest {
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
        Id accountId = accList[0].id;
        AggregateResult[] resultQuery = database.query('SELECT SUM(TotalAmount) sumAmount FROM Order WHERE AccountId=:accountId');
        System.debug('resultQuery'+resultQuery);
        
        Decimal total = (Decimal)resultQuery[0].get('sumAmount');
        Decimal ca = accList[0].Chiffre_d_affaire__c + total;
        update accList[0];
    }
        @isTest static void test() {
        
        List<Order> orders = [SELECT Id, Status FROM Order LIMIT 150];
        for(Order order: orders){
            order.status = 'Activated';
        }
        update orders;

        Test.startTest();
        
		OrderTotalControllerOrderTotalController= new OrderTotal();
        List<Account> acc = [SELECT id,Chiffre_d_affaire__c FROM Account LIMIT 1];
        Id accountId = acc[0].id;
 
    
        AggregateResult[] resultQuery = database.query('SELECT SUM(TotalAmount) sumAmount FROM Order WHERE AccountId=:accountId');
        System.debug('resultQuery'+resultQuery);
        Decimal total = (Decimal)resultQuery[0].get('sumAmount');
        Decimal ca = acc[0].Chiffre_d_affaire__c + total;
		AggregateResult[] CAresultQuery = database.query('select Id, Chiffre_d_affaire__c from Account where Chiffre_d_affaire__c = 7500');
        Decimal resultCA = (Decimal)CAresultQuery[0].get('Chiffre_d_affaire__c');
        Test.stopTest();
        Decimal result = OrderTotal.getTotal();

        System.assertNotEquals(result, resultCA);
    }
}