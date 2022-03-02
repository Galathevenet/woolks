import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {

  static values = {
    apiKey: String
  };

  connect() {
    console.log("Connected to mapbox_controller.js");

    mapboxgl.accessToken = this.apiKeyValue;

    if (!navigator.geolocation) {
      console.log('Geolocation is NOT supported by your browser');
    } else {
      console.log('Geolocation IS supported by your browser');

      // Center map on current position
      navigator.geolocation.getCurrentPosition(
        position => {
          this.map = new mapboxgl.Map({
            container: this.element,
            style: "mapbox://styles/mapbox/streets-v10",
            center: [position.coords.longitude, position.coords.latitude],
            zoom: 14
          });
        }
      );

      this.#addHotspotsToMap();
    }
  }

  #addHotspotsToMap() {
    const dispenserEl = document.createElement('i');
    dispenserEl.classList.add('fa-solid');
    dispenserEl.classList.add('fa-trash-can');
    dispenserEl.style.fontSize = '24px';
    dispenserEl.style.color = 'red';

    const parkEl = document.createElement('i');
    parkEl.classList.add('fa-solid');
    parkEl.classList.add('fa-tree');
    parkEl.style.fontSize = '24px';
    parkEl.style.color = 'green';

    const fountainEl = document.createElement('i');
    fountainEl.classList.add('fa-solid');
    fountainEl.classList.add('fa-faucet');
    fountainEl.style.fontSize = '24px';
    fountainEl.style.color = 'blue';

    new mapboxgl.Marker(dispenserEl)
      .setLngLat([-0.5722858, 44.8584662])
      .addTo(this.map);

    new mapboxgl.Marker(parkEl)
    .setLngLat([-0.572, 44.858])
    .addTo(this.map);

    new mapboxgl.Marker(fountainEl)
      .setLngLat([-0.573, 44.86])
      .addTo(this.map);
  }

  // #addMarkersToMap() {
  //   this.markersValue.forEach((marker) => {
  //     const popup = new mapboxgl.Popup().setHTML(marker.info_window)
  //     const customMarker = document.createElement("div")
  //     customMarker.className = "marker"
  //     customMarker.style.backgroundImage = `url('${marker.image_url}')`
  //     customMarker.style.backgroundSize = "contain"
  //     customMarker.style.width = "25px"
  //     customMarker.style.height = "25px"

  //     new mapboxgl.Marker(customMarker)
  //       .setLngLat([ marker.lng, marker.lat ])
  //       .addTo(this.map)
  //       .setPopup(popup)
  //   });
  // }

  // #fitMapToMarkers() {
  //   const bounds = new mapboxgl.LngLatBounds()
  //   this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
  //   this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  // }
}
