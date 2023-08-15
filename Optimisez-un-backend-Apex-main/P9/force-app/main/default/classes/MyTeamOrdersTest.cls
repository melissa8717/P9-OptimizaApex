/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-15-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public class MyTeamOrdersTest {
	@testSetup
    static void setup(){
    
      List<Account> accounts = new List<Account>();
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
	}
    @isTest static void test() {
        //CA =CA + total amount
        MyTeamOrdersController myTeamC = new MyTeamOrdersController();

        Test.startTest();
        
        List<Account> acc = [SELECT id,Chiffre_d_affaire__c FROM Account LIMIT 1];
        Id accountId = acc[0].id;
        
        List<Order> orders = [SELECT Id, Status FROM Order WHERE Status = 'Draft'];
        for(Order order : orders){
            order.Status = 'Activated';
            update orders;
        }
        AggregateResult[] resultQuery = database.query('SELECT SUM(TotalAmount) sumAmount FROM Order WHERE AccountId=:accountId');
        System.debug('resultQuery'+resultQuery);
        Decimal total = (Decimal)resultQuery[0].get('sumAmount');
        Decimal result = myTeamC.SumOders;

        Test.stopTest();
        System.assertNotEquals(result, total);
    }
}