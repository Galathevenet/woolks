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
      // Initiate map, markers and originalWalk
      navigator.geolocation.getCurrentPosition(this.#initializeMap);

      // Loop to watch position live
      navigator.geolocation.watchPosition(this.#currentWalkToMap);
    }
  }

  #initializeMap = (position) => {
    console.log("initializeMap")
    console.log(this)
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
      center: [position.coords.longitude, position.coords.latitude],
      zoom: 14
    });

    this.map.on('load', () => {
      this.#addHotspotsToMap();
      this.#addOriginalWalkToMap();
    })
  }

  #addHotspotsToMap = () => {
    console.log("#addHotspotsToMap");

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
      .setLngLat([-0.572, 44.859])
      .addTo(this.map);

    new mapboxgl.Marker(parkEl)
    .setLngLat([-0.575, 44.86])
    .addTo(this.map);

    new mapboxgl.Marker(fountainEl)
      .setLngLat([-0.573, 44.86])
      .addTo(this.map);
  }

  #addOriginalWalkToMap = () => {
    console.log("#addOriginalWalkToMap");

    this.map.addSource(
      'route',
      {
        type: 'geojson',
        data: {
          'type': 'FeatureCollection',
          'features': [
            {
              'type': 'Feature',
              'geometry': {
                'type': 'LineString',
                'coordinates': [
                  [-0.565, 44.859],
                  [-0.572, 44.858]
                ]
              }
            }
          ]
        }
      }
    );

    this.map.addLayer({
      'id': 'route',
      'type': 'line',
      'source': 'route',
      'layout': {
        'line-join': 'round',
        'line-cap': 'round'
      },
      'paint': {
        'line-color': 'red',
        'line-width': 4
      }
    });
  }

  #currentWalkToMap = (position) => {
    console.log("#addCurrentWalkToMap");
    const currentPositionEl = document.createElement('i');
    currentPositionEl.classList.add('fa-solid');
    currentPositionEl.classList.add('fa-location-crosshairs');
    currentPositionEl.style.fontSize = '24px';
    currentPositionEl.style.color = 'red';

    new mapboxgl.Marker(currentPositionEl)
    .setLngLat([position.coords.longitude, position.coords.latitude])
    .addTo(this.map);
  }
  
}
