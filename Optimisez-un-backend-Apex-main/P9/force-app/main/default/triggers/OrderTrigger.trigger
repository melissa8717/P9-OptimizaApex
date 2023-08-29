/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-18-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger OrderTrigger on Order (before update) {
   if (Trigger.isUpdate) {
        if (Trigger.isBefore) {
			OrderCalculateAmountClass instance = new OrderCalculateAmountClass();
   			instance.calculateTotal(trigger.new);
            OrderTotal instanceOrder = new OrderTotal();
    		instanceOrder.getTotal(trigger.new);

        }        
    }
   
        
   
}
