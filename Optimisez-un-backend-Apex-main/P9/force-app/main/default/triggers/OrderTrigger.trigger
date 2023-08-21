/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-21-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger OrderTrigger on Order (before update, after update) {
    if (Trigger.isupdate) {
         if (Trigger.isBefore) {
             List<Order> listOrder= trigger.new;
             OrderCalculateAmountClass instance = new OrderCalculateAmountClass();
                instance.calculateTotal(listOrder);
 
         } else if (Trigger.isAfter) {
             OrderTotal instance = new OrderTotal();
             instance.getTotal(trigger.new); 
         }        
     }
         
    
 }