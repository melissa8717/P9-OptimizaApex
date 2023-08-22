public without sharing class MyTeamOrdersController {
    
   private ApexPages.StandardController controller {get; set;}
   private Order ord;

    public Decimal SumOders{
        get{
  			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order WHERE Status = 'Activated'];
			return (decimal)groupedResults.get('total');

        }
        set;
    }
     public MyTeamOrdersController(ApexPages.StandardController controller) {
        //initialize the stanrdard controller
        this.controller = controller;
        this.ord = (Order)controller.getRecord();
    }
}