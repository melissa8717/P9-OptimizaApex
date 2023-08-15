/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-15-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class DataCreatingClass {
    public static List<Account> createAccount(){
        List<Account> accounts = new List<Account>();
        for(Integer i=0;i<20;i++){
            accounts.add(new Account(name='Account'+i,
                Chiffre_d_affaire__c=6500)); 
        }
        return accounts;
    }
    
    public static Product2 createProduct() {
        Product2 p = new Product2();
        p.Name = ' Test Product ';
        p.Description='Test Product Entry 2';
        p.productCode = 'ABCD';
        p.isActive = true;
        return p;
    }
    
    public static PricebookEntry createPrice(Id product2Id){
        PricebookEntry standardPrice = new PricebookEntry();
        standardPrice.Pricebook2Id = Test.getStandardPricebookId();
        standardPrice.Product2Id = product2Id;
        standardPrice.UnitPrice = 1;
        standardPrice.IsActive = true;
        standardPrice.UseStandardPrice = false;
        return standardPrice;
    }
    public static List<Order> createOrder(Id accountId){
        List<Order> orders = new List<Order>();
        for(Integer i=0;i<20;i++){
            orders.add(new Order(AccountId = accountId, Status='Draft', ShipmentCost__c = 100,Pricebook2Id= Test.getStandardPricebookId(),Name='Order'+i,EffectiveDate=Date.Today()));
        }
        return orders;
    }
    public static List<OrderItem> createOrderItem(Id orderId,Id product2Id, Id standardpriceId){
        List<OrderItem> orderItems = new List<OrderItem>();
        for(Integer i=0;i<20;i++){
            orderItems.add(new OrderItem(Product2id = product2Id,PriceBookEntryId=standardpriceId, Quantity =1, OrderId = orderId, UnitPrice=1000));
  
        }
        return orderItems;
    }
}