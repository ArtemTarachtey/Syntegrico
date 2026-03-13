import { LightningElement } from 'lwc';
import { track, wire } from 'lwc';
import getTasks from '@salesforce/apex/TaskController.getTasks';
import markDone from '@salesforce/apex/TaskController.markDone';

export default class TaskList extends LightningElement {
    @track tasks = [];

    @wire(getTasks)
    wiredTasks({ error, data }) {
        if (data) {
            console.log(data);
            this.tasks = data;
        } else if (error) {
            console.error(error);
        }
    }

    handleDoneBtn(e) {
        const id = e.currentTarget.dataset.id;
        markDone({ taskId: id })
        .then(() => {
            this.tasks = this.tasks.map(t => 
                {
                    if (t.Id == id) {
                        return {...t, Done__c: true };
                    }
                    return t;
                }
            )
        })
        .catch (error => {
            console.error(error);
        })
    }
}   