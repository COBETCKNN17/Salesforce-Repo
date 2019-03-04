// Challenge: Please build out a trigger on account updates to make a change to all of their child opportunities.

trigger accountOpportunitiesUpdateTrigger on Account (after update) {
	// Assigning SOQL Query returning all opportunities 
	// associated with the current account being updated
	// to a List of Opportunities
	List<Opportunity> childOpportunities = [SELECT Id, Account.Id, Update_Counter__c
                                           FROM Opportunity 
                                           WHERE Account.Id IN: Trigger.New];
    System.debug(childOpportunities); 
    
    // new list of Opportunities that will contain the updated information 
    List<Opportunity> updatedOpportunities = new List<Opportunity>();
    
    for(opportunity opp: childOpportunities){
    	// Update_Counter__c is a Number field on the Opportunity
    	// This loop will increment Update_Counter__c each time the Account is edited and saved 
    	// Update_Counter is null by default. The logic initializes the Update_Counter__c to store 1 
        if(opp.Update_Counter__c == null) {
          opp.Update_Counter__c = 1;  
        } else {
          opp.Update_Counter__c += 1; 
        }
        // append changes to new list 
        updatedOpportunities.add(opp);
    }
    
    // Update the updated list of Opportunities
    update updatedOpportunities; 
}