import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ['test']
  toggle_dropdown() {
    this.testTarget.classList.toggle("hidden");
  }
}
