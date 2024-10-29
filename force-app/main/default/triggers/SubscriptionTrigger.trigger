trigger SubscriptionTrigger on Subscription__c(
  after insert,
  after update,
  after delete
) {
  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      SubscriptionCounter counter = new SubscriptionCounter(Trigger.new);
      counter.Claclulate();
    } else if (Trigger.isUpdate) {
      SubscriptionCounter counter = new SubscriptionCounter(Trigger.new);
      counter.Claclulate();
    } else if (Trigger.isDelete) {
      SubscriptionCounter counter = new SubscriptionCounter(Trigger.old);
      counter.Claclulate();
    }
  }
}
