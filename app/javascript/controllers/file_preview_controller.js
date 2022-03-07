import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["field", "imageTemplate"]

  connect() {
    console.log('Hello, Stimulus!')
    console.log(this)
  }

  displayPhotoMiniature(event) {
    console.log("coucou from photos")
    console.log(event.target.files);

    if (event.target.files) {
        let file = event.target.files[0]
        let blobUrl = URL.createObjectURL(file)
        this.imageTemplateTarget.content.querySelector("img").src = blobUrl
        const content = this.imageTemplateTarget.innerHTML
        this.fieldTarget.insertAdjacentHTML ("beforeend", content)
      }
    }
  }
