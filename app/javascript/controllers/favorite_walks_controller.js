import { Controller } from "stimulus"

window.addEventListener("load", () => {
  console.log("Hello test test")
  const links = document.querySelectorAll("a[data-remote]");
  links.forEach((element) => {
    element.addEventListener(click, (event) => {
      event.preventDefault();
      alert("Alert");
    });
  });
});
