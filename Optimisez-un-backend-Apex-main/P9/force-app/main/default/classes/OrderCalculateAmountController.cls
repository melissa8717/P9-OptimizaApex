/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-15-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public without sharing class OrderCalculateAmountClass {
	public void calculateTotal(List<Order>listOrders){
        for(Integer i=0;i<listOrders.size();i++){
           listOrders[i].NetAmount__c = listOrders[i].TotalAmount - listOrders[i].ShipmentCost__c;
        }
		
    }
}