global with sharing class EsercizioTrigger1Handler {
  public static void beforeInsert(List<Project__c> newProject) {
    for (Project__c project : newProject) {
      if (project.Project_Name__c == null) {
        project.Project_Name__c.addError(
          'The field Name should be filled out.'
        );
      }
      if (project.Status__c == null) {
        project.Status__c = 'Proposed';
      }
      if (project.Start_Date__c < System.Today()) {
        project.Start_Date__c.addError(
          'Start Date should be greater than or equal to today.'
        );
      }
      if (project.Budget__c < 0) {
        project.Budget__c.addError('Budget should be greater than 0.');
      }
      if (
        project.Client_Name__c != null &&
        project.Client_Name__c.length() < 3
      ) {
        project.Client_Name__c.addError(
          'Client name should be more than 3 letters'
        );
      }
    }
  }
}
