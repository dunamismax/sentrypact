import { Controller } from "@hotwired/stimulus"

const DARK_THEME = "dark"
const LIGHT_THEME = "light"

export default class extends Controller {
  static targets = ["label"]

  connect() {
    this.applyTheme(this.currentTheme())
  }

  toggle() {
    const nextTheme = this.currentTheme() === DARK_THEME ? LIGHT_THEME : DARK_THEME
    localStorage.setItem("sentrypact-theme", nextTheme)
    this.applyTheme(nextTheme)
  }

  currentTheme() {
    return document.documentElement.dataset.theme || DARK_THEME
  }

  applyTheme(theme) {
    document.documentElement.dataset.theme = theme
    document.documentElement.style.colorScheme = theme
    this.element.setAttribute("aria-pressed", theme === DARK_THEME)
    this.element.setAttribute("aria-label", `Switch to ${theme === DARK_THEME ? "light" : "dark"} mode`)

    if (this.hasLabelTarget) {
      this.labelTarget.textContent = theme === DARK_THEME ? "Dark" : "Light"
    }
  }
}
