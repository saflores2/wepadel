import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

export default class extends Controller {
  connect() {
    console.log("estoy conectado al controlador")
    // new Typed(this.element, {
    //   strings: ["Encuentra los Mejores Torneos de Padel"],
    //   typeSpeed: 50,
    //   loop: true
    // })
  }
}
