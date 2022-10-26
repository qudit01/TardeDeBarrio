import {
  Controller
} from "@hotwired/stimulus"
import { EmojiButton } from '@joeattardi/emoji-button'

export default class extends Controller {
  static targets = ["button", "input"]

  connect() {
    this.picker = new EmojiButton()
    this.picker.on('emoji', emoji => {
      this.inputTarget.value += emoji.emoji
    })
  }

  async toggle(event) {
    event.preventDefault()
    this.picker.togglePicker(event.target)
  }
}