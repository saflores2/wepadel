import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

// Connects to data-controller="prueba"
export default class extends Controller {
  connect() {
    console.log("estoy conectado al controlador")
    new Typed(this.element, {
      strings: ["Encuentra los Mejores Torneos de Padel"],
      typeSpeed: 50,
      loop: true
    })
    new Typed(this.element, {
      strings: ["We Padel"],
      typeSpeed: 40,
      loop: true
  }
}
