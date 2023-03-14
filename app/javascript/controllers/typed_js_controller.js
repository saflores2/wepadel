import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

// Connects to data-controller="typed-js"
export default class extends Controller {
  connect() {
    console.log("subscribed to typed-js")
    new Typed(this.element, {
      strings: ["Encuentra los Mejores Torneos de Padel"],
      typeSpeed: 50,
      loop: true
    })
  }
}
