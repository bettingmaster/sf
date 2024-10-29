trigger EsercizioTrigger1 on Project__c(before insert) {
  EsercizioTrigger1Handler.beforeInsert(Trigger.new);
}
