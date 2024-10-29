global class calculateTaxHandler {
  private static void calculateTax(Opportunity opp) {
    opp.Tax__c = opp.Amount * (opp.Tax_Percentage__c / 100);
    opp.Total_Price__c = opp.Amount + opp.Tax__c;
  }

  public static void beforeInsert(List<Opportunity> newRecords) {
    for (Opportunity newRecord : newRecords) {
      if (newRecord.Amount != null && newRecord.Tax_Percentage__c != null) {
        calculateTax(newRecord);
      }
    }
  }

  public static void beforeUpdate(
    Map<Id, Opportunity> newMap,
    Map<Id, Opportunity> oldMap
  ) {
    for (Id oppId : newMap.keySet()) {
      Opportunity newRecord = newMap.get(oppId);
      Opportunity oldRecord = oldMap.get(oppId);
      if (newRecord.Amount != null && newRecord.Tax_Percentage__c != null) {
        if (
          newRecord.Amount != oldRecord.Amount ||
          newRecord.Tax_Percentage__c != oldRecord.Tax_Percentage__c
        ) {
          calculateTax(newRecord);
        }
      }
    }
  }
}
