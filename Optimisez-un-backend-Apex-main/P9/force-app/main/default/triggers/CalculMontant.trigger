/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-15-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger CalculMontant on Order (before update) {
    //un triggerpar objet
    List<Order> listOrder= trigger.new;
    //Order order = [SELECT Id, NetAmount__c FROM Order WHERE Id =:newOrder.id ];
	OrderCalculateAmountClass instance = new OrderCalculateAmountClass();
    instance.calculateTotal(listOrder);
    
    //update order; 
}