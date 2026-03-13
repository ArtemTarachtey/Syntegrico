public with sharing class TaskController {

    @AuraEnabled(cacheable=true)
    public static List<Task__c> getTasks() {
        try {
            List<Task__c> tasks = [SELECT Id, Name, Subject__c, Done__c, DueDate__c FROM Task__c];
            return tasks;
        } 
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=false)
    public static void markDone(Id taskId){
        try {
            Task__c task = [SELECT Done__c FROM Task__c WHERE Id = :taskId LIMIT 1];
            task.Done__c = true;
            update task;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}