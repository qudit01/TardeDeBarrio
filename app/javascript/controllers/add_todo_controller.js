import {
    Controller
} from '@hotwired/stimulus'

export default class extends Controller {
    static targets = ["todo"];

    task() {
        console.log(`Task: ${this.todo}`);
    }

    get todo() {
        return this.todoTarget.value
    }
}