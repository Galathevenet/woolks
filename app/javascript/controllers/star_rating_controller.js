import { Controller } from "stimulus"
import "jquery-bar-rating";
import $ from 'jquery';

export default class extends Controller {
  static targets = [ ]

  connect() {
    $('#review_rating').barrating({
      theme: 'css-stars'
    });
  }
}
