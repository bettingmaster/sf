trigger calculateTax on Opportunity(before insert, before update) {
  if (Trigger.isBefore) {
    if (Trigger.isInsert) {
      calculateTaxHandler.beforeInsert(Trigger.new);
    }
    if (Trigger.isUpdate) {
      calculateTaxHandler.beforeUpdate(Trigger.newMap, Trigger.oldMap);
    }
  }

}
