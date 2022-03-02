import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {

  static values = {
    apiKey: String,
    hotspots: Array,
    waypoints: Array
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

    this.hotspotsValue.forEach((hotspot) => {
      const hotspotEl = document.createElement('i');
      hotspotEl.classList.add('fa-solid');
      hotspotEl.style.fontSize = '24px';

      switch (hotspot.category) {
        case 'dispenser':
          hotspotEl.classList.add('fa-trash-can');
          hotspotEl.style.color = 'red';
          break;
        case 'park':
          hotspotEl.classList.add('fa-tree');
          hotspotEl.style.color = 'green';
          break;
        case 'fountain':
          hotspotEl.classList.add('fa-faucet');
          hotspotEl.style.color = 'blue';
          break;
        default:
          break;
      }

      new mapboxgl.Marker(hotspotEl)
      .setLngLat([hotspot.longitude, hotspot.latitude])
      .addTo(this.map);

    })
  }

  #addOriginalWalkToMap = () => {
    console.log("#addOriginalWalkToMap");

    const data = {
      'type': 'FeatureCollection',
      'features': [
        {
          'type': 'Feature',
          'geometry': {
            'type': 'LineString',
            'coordinates': [
              // [-0.565, 44.859]
            ]
          }
        }
      ]
    }

    this.map.addSource('route', { type: 'geojson', data: data });

    this.waypointsValue.forEach((waypoint) => {
      data.features[0].geometry.coordinates.push([waypoint.longitude, waypoint.latitude])
    })
    this.map.getSource('route').setData(data);


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
