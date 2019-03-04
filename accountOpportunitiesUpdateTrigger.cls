// Challenge: Please build out a trigger on account updates to make a change to all of their child opportunities.

trigger accountOpportunitiesUpdateTrigger on Account (after update) {
  // chose after update event because the original list can be updated directly,
  // i.e. no need to create a second list storing the changes processed in the loop

  // Assigning SOQL Query returning all opportunities 
  // associated with the current account being updated
  // to a List of Opportunities
  List<Opportunity> childOpportunities = [SELECT Id, Account.Id, Update_Counter__c
                                           FROM Opportunity 
                                           WHERE Account.Id IN: Trigger.New];

    for(opportunity opp: childOpportunities){
      // Update_Counter__c is a Number field on the Opportunity
      // Update_Counter is null by default. The logic initializes the Update_Counter__c to store 1 if it is blank. 
      // If Update_Counter is not blank, Update_Counter__c increments each time the Account is edited and saved 
        if(opp.Update_Counter__c == null) {
          opp.Update_Counter__c = 1;  
        } else {
          opp.Update_Counter__c += 1; 
        }
    }
    
    // Update the list of Opportunities
    update childOpportunities; 
}