public with sharing class ContactHandler {
    public static void contactTriggerHandlerBefore(List<Contact> newContacts) {
      for (Contact con : newContacts) {
        if (con.Id == Null && con.DummyJSON_Id__c == Null) {
         Integer randomNumber = Integer.valueOf((Math.random() * 100)) + 1;
           con.DummyJSON_Id__c = String.valueOf(randomNumber);     
        } 
      }
    }

    public static void contactTriggerHandlerAfter(List<Contact> newContacts){
        for (Contact con : newContacts) {
            if (con.Id == Null && Integer.valueOf(con.DummyJSON_Id__c) <= 100){
                DummyJSONCallout.getDummyJSONUserFromId(con.DummyJSON_Id__c);
            } 
        }
    }

    public static void contactTriggerHandlerUpdate(List<Contact> newContacts, Map<Id,Contact> oldContacts){
        for (Contact con : newContacts) {
          if (Integer.valueOf(con.DummyJSON_Id__c) > 100 && !oldContacts.containsKey(con.Id))  {
            DummyJSONCallout.postCreateDummyJSONUser(con.Id);
          }  
    }
}
}