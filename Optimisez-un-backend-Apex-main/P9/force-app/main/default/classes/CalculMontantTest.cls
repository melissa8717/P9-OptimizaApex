/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-22-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public class CalculMontantTest {
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
        //CA =CA + total amount
        OrderCalculateAmountController orderCalculate = new OrderCalculateAmountController();
        Test.startTest();
        
        List<Account> acc = [SELECT id FROM Account LIMIT 1];
        Id accountId = acc[0].id;
        System.debug('id acc'+accountId);
 
    	//List<Order> order = [SELECT id,ShipmentCost__c  FROM Order WHERE AccountId=:accountId];
        AggregateResult[] resultShipment = database.query('SELECT SUM(ShipmentCost__c) sumShipment FROM Order WHERE AccountId=:accountId');

        AggregateResult[] resultTotal = database.query('SELECT SUM(TotalAmount) sumAmount FROM Order WHERE AccountId=:accountId');
        //System.debug('order'+resultQuery);
        system.debug('idacc'+accountId);
		//AggregateResult[] orderUpdated = database.query('select SUM(NetAmount__c)  sumNet FROM Order WHERE AccountId=:accountId');
        //system.debug('query'+orderUpdated[0]);
        Decimal totalAmount = (Decimal)resultTotal[0].get('sumAmount');
        Decimal shipment = (Decimal)resultShipment[0].get('sumShipment');
        Decimal netAmount = totalAmount - shipment;

        Test.stopTest();
        OrderCalculateAmountController instance = new OrderCalculateAmountController();
		//system.debug('netamount'+netAmount);
  		//Decimal result = instance.calculateTotal(order);
 
        System.assertEquals(398000,netAmount );
    }
}