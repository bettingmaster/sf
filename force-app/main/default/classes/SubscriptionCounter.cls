global with sharing class SubscriptionCounter {
  private Map<Id, List<Subscription__c>> contactsToSubscriptions;

  private List<Subscription__c> contactsToUpdate;

  //Constructor accepting list of subscription records
  global SubscriptionCounter(Subscription__c[] newSubs) {
    this.contactsToUpdate = new List<Contact>();
    Subscription__c[] allSubs = [
      SELECT Id, Contact__c, Course_Type__c
      FROM Subscription__c
      WHERE Contact__c IN :getContactIds(newSubs)
    ];

    this.contactsToSubscriptions = createSubscriptionList(allSubs);
  }

  //calculates contact subscription totals and updates records to reflect calculations
  global void Claclulate() {
    System.debug('Calculating...');
    for (Id contactId : contactsToSubscriptions.keySet()) {
      Contact thisContact = new Contact(Id = contactId);
      thisContact.Business_Subscriptions__c = 0;
      thisContact.Cooking_Subscriptions__c = 0;
      thisContact.Crafts_Subscriptions__c = 0;
      thisContact.Development_Subscriptions__c = 0;
      thisContact.Music_Subscriptions__c = 0;
      thisContact.Teaching_Subscriptions__c = 0;
    }
    //Roll-up subs
    for (Subscription__c sub : this.contactsToSubscriptions.get(contactId)) {
      switch on sub.Course_Type__c {
        when 'Business' {
          thisContact.Business_Subscriptions__c++;
        }
        when 'Cooking' {
          thisContact.Cooking_Subscriptions__c++;
        }
        when 'Crafts' {
          thisContact.Crafts_Subscriptions__c++;
        }
        when 'Development' {
          thisContact.Development_Subscriptions__c++;
        }
        when 'Music' {
          thisContact.Music_Subscriptions__c++;
        }
        when 'Teaching' {
          thisContact.Teaching_Subscriptions__c++;
        }
        when else {
        }
      }
      this.contactsToUpdate.add(thisContact);
    }
    //update all changed records
    update this.contactsToUpdate;
  }

  //Return all Contact__c lookup values on Subscription list
  private Set<Id> getContactIds(Subscription__c[] newSubs) {
    Set<Id> contactIds = new Set<Id>();
    for (Subscription__c sub : newSubs) {
      contactIds.add(sub.Contact__c);
    }
    return contactIds;
  }

  //Build a map of Contact IDs to associated Subscriptions
  private Map<Id, List<Subscription__c>> createSubscriptionList(
    Subscription__c[] allSubs
  ) {
    Map<Id, List<Subscription__c>> subMap = new Map<Id, List<Subscription__c>>();
    //Loop through all subs queried
    for (Subscription__c sub : allSubs) {
      //initialize a blank list
      List<Subscription__c> contactsSubscriptions = new List<Subscription__c>();
      //if the map already has the Contact id as a key, get the list of subscriptions from the map
      if (subMap.containsKey(sub.Contact__c)) {
        //add the subscription to the list
        contactsSubscriptions = subMap.get(sub.Contact__c);
      }
      //add the subscription to the list
      contactsSubscriptions.add(sub);
      //add the list back to the map
      subMap.put(sub.Contact__c, contactsSubscriptions);
    }
    //return the map of Contact ids to list of Subscriptions
    return subMap;
  }
}
