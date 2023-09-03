/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-22-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public class OrderCalculateAmountTest {
    @testSetup
    static void setup() {
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
        
        Id accountId = accList[0].id;
        AggregateResult[] resultQuery = database.query('SELECT SUM(TotalAmount) sumAmount FROM Order WHERE AccountId=:accountId');
		Decimal total = (Decimal)resultQuery[0].get('sumAmount');
        Decimal totalOrder = total - (Decimal)ordList[0].ShipmentCost__c;
        ordList[0].NetAmount__c = totalOrder;
	}
    
    @isTest static void test() {
        OrderCalculateAmountController orderCalculate = new OrderCalculateAmountController();
        Test.startTest();
        
        List<Account> acc = [SELECT id FROM Account LIMIT 1];
        Id accountId = acc[0].id;
 
        AggregateResult[] resultShipment = database.query('SELECT SUM(ShipmentCost__c) sumShipment FROM Order WHERE AccountId=:accountId');

        AggregateResult[] resultTotal = database.query('SELECT SUM(TotalAmount) sumAmount FROM Order WHERE AccountId=:accountId');
        Decimal totalAmount = (Decimal)resultTotal[0].get('sumAmount');
        Decimal shipment = (Decimal)resultShipment[0].get('sumShipment');
        Decimal netAmount = totalAmount - shipment;

        Test.stopTest();
        OrderCalculateAmountController instance = new OrderCalculateAmountController();
	
 
        System.assertEquals(398000,netAmount );
    }
}
