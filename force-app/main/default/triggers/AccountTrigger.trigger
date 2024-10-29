trigger AccountTrigger on Account(before insert, before update) {
  if (Trigger.isBefore) {
    if (Trigger.isInsert) {
      AcccountTriggerHandler.beforeInsert(Trigger.new);
    }
    if (Trigger.isUpdate) {
      AcccountTriggerHandler.beforeUpdate(Trigger.newMap, Trigger.oldMap);
    }
  }
}
