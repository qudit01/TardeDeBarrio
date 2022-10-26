import {
  Controller
} from "@hotwired/stimulus"

// Connects to data-controller="block"
export default class extends Controller {
  static targets = ["likeCount"]
  static values = {
    url: String,
  }

  async giveLike(event) {
    let body = '';
    const csrfToken = document.querySelector("[name='csrf-token']").content
    const response = await fetch(this.urlValue, {
      method: 'POST',
      headers: {
        "X-CSRF-Token": csrfToken,
        "Content-Type": "application/json"
      },
      body: body
    })
    const changes = await response.json();
    let likes = document.getElementsByClassName(this.likeCountTarget.attributes.class.value)
    Array.from(likes).forEach(element => element.innerHTML = changes.likes)
  }
}