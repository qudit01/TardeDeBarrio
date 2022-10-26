import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="block"
export default class extends Controller {
  static values = {
    url: String
  }

  async changeStatus(event) {
    const csrfToken = document.querySelector("[name='csrf-token']").content
    const response = await fetch(this.urlValue, {
      method: 'PATCH',
      headers: {
      "X-CSRF-Token": csrfToken, 
      "Content-Type": "application/json"
    } } )
    const body = await response.text()
    this.element.outerHTML = body
  }
}
