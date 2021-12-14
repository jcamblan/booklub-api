import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ['settings', 'menu']

  toggle_settings() {
    this.settingsTarget.classList.toggle("hidden");
  }

  toggle_menu() {
    this.menuTarget.classList.toggle("hidden");
  }
}
