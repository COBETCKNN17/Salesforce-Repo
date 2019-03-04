trigger accountOpportunitiesUpdateTrigger on Account (after update) {
	List<Opportunity> childOpportunities = [SELECT Id, Name, Account.Id 
                                           FROM Opportunity 
                                           WHERE Account.Id IN: Trigger.New];
    System.debug(childOpportunities); 
    update childOpportunities; 
}