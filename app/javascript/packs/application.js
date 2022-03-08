// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "controllers"
import "bootstrap"

const addRemoveFavorite = (user, walk) => {
  const heart = document.getElementById("fa-heart")
  heart.addEventListener("click", (event) => {
    console.log(event);
    console.log(event.currentTarget);
    // const user = current_user;
    // const walk = document.querySelector(`#${walkId}`);
    // if (user.favorited?(walk) {
    //   user.unfavorite(walk)
    // } else {
    //   user.favorite(walk)
    // }
  })
};

addRemoveFavorite("", "");

// methode hors stimulus

//HTML
//mettre une classe commune à tous les coeurs
//

//JS
// Retrouver tous les cœurs de la page
// Pour chaque cœur
//     - mettre un écouteur au click
//     - si cœur solid => enlever la classe solid et passer à vide
//     - sinon inverse
//     - Dire au serveur que le current_user a cliqué
