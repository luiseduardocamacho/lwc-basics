trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
    
    List<BatchLeadConvertErrors__c> recordsToInsert = new List<BatchLeadConvertErrors__c>(); 
    
    For (BatchApexErrorEvent baee :trigger.new)
    {
        BatchLeadConvertErrors__c blcd = new BatchLeadConvertErrors__c(
            AsyncApexJobId__c = baee.AsyncApexJobId,
            Records__c = baee.JobScope,
            StackTrace__c = baee.StackTrace);
        
        recordsToInsert.add(blcd);
    }
    Insert recordsToInsert;
}