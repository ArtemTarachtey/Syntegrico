@isTest
private class TaskControllerTest {

    @testSetup
    static void setup() {
        List<Task__c> tasks = new List<Task__c>();
        for(Integer i=0; i<10; i++) {
            tasks.add(new Task__c(Name = 'Task ' + i, Subject__c = 'Subj ' + i, Done__c = false, DueDate__c = Date.today()));
        }
        insert tasks;
    }

    @isTest
    static void getTasks_positiveTest() {
        Test.startTest();
        List<Task__c> result = TaskController.getTasks();
        Test.stopTest();
        Assert.areEqual(10, result.size(), 'There should be 10 records');
    }

    @isTest
    static void markDone_positiveTest() {
        Task__c task = new Task__c(Name = 'Task 1', Subject__c = 'Subj 1', Done__c = false, DueDate__c = Date.today());
        insert task;

        Test.startTest();
        TaskController.markDone(task.Id);
        Test.stopTest();
        Task__c resultTask = [SELECT Done__c FROM Task__c WHERE Id = :task.Id LIMIT 1];
        Assert.areEqual(true, resultTask.Done__c, 'There should be true');
    }

    @isTest
    static void markDone_negativeTest() {
        Task__c task = new Task__c(Name = 'Task 1', Subject__c = 'Subj 1', Done__c = false, DueDate__c = Date.today());
        insert task;
        Id id = task.Id;
        delete task;

        Test.startTest();
        try {
            TaskController.markDone(id);
        } catch (AuraHandledException e) {
            Assert.isNotNull(e.getMessage(), 'There should be error message');
        }
        Test.stopTest();
    }

}