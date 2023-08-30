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
       
    }
        @isTest static void test() {
        
        Test.startTest();

        List<Order> orderList = [SELECT Id, Status FROM Order WHERE Status='Draft' LIMIT 150];
        List<Account> acc = [SELECT id,Chiffre_d_affaire__c FROM Account LIMIT 1];

       	Id accountId = acc[0].id;
        
        for(Integer i=0;i<orderList.size();i++){
           orderList[i].Status = 'Activated';     
        }
        update orderList;
            
        AggregateResult[] resultQuery = database.query('SELECT SUM(TotalAmount) sumAmount FROM Order WHERE AccountId=:accountId');
        System.debug('resultQuery'+orderList);
        
        Decimal total = (Decimal)resultQuery[0].get('sumAmount');
        Decimal ca = acc[0].Chiffre_d_affaire__c + total;
        update acc[0];

        Test.stopTest();

        System.assertEquals(406500.00, ca);
    }
}