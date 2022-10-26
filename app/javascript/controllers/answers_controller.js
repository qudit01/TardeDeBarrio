import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="block"
export default class extends Controller {
    static targets = ["hidden_content"]
    
    seeAnswers() {
        this.hidden_contentTarget.style.display = (this.hidden_contentTarget.style.display == 'block') ? 'none' : 'block'
    }
}