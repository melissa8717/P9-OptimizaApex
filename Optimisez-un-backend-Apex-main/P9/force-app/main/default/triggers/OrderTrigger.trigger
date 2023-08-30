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
			OrderCalculateAmountController instance = new OrderCalculateAmountController();
   			instance.calculateTotal(trigger.new);
            OrderTotalController instanceOrder = new OrderTotalController();
    		instanceOrder.getTotal(trigger.new);

        }        
    }
   
        
   
}
