import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["field", "imageTemplate"]

  displayPhotoMiniature(event) {
    this.#cleanPreviews()
    Array.from(event.target.files).forEach((file) => {
      let blobUrl = URL.createObjectURL(file)
      this.imageTemplateTarget.content.querySelector("img").src = blobUrl
      const content = this.imageTemplateTarget.innerHTML
      this.fieldTarget.insertAdjacentHTML ("beforeend", content)
    });
  }

  #cleanPreviews() {
    if (this.fieldTarget.children.length > 1) {
      let array = Array.from(this.fieldTarget.children)
      array.shift()
      array.forEach(img => img.remove());
    }
  }
}
