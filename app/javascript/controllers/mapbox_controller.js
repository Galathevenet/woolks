import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {

  static targets = ['input'];

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

      // When current position is available, launch map
      navigator.geolocation.getCurrentPosition(this.#launchMap);
    }
  }

  endWalk() {
    console.log("end");

    navigator.geolocation.clearWatch(this.watchPositionId);

    // Write coordinates in params
    this.inputTarget.value = this.currentWalkData.features[0].geometry.coordinates;
  }

  #launchMap = (position) => {
    console.log("initializeMap")

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
      center: [position.coords.longitude, position.coords.latitude],
      zoom: 13
    });

    this.map.on('load', () => {
      // Display hotspots and original walk
      this.#addHotspotsToMap();
      this.#addOriginalWalkToMap();

      // Initialize current walk and current position marker
      this.#initializeCurrentWalk()

      // Loop to watch position live
      this.watchPositionId = navigator.geolocation.watchPosition(this.#currentWalkToMap);
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

    this.map.addSource('original-walk', { type: 'geojson', data: data });

    this.waypointsValue.forEach((waypoint) => {
      data.features[0].geometry.coordinates.push([waypoint.longitude, waypoint.latitude])
    })
    this.map.getSource('original-walk').setData(data);


    this.map.addLayer({
      'id': 'original-walk',
      'type': 'line',
      'source': 'original-walk',
      'layout': {
        'line-join': 'round',
        'line-cap': 'round'
      },
      'paint': {
        'line-color': 'blue',
        'line-width': 4
      }
    });
  }

  #initializeCurrentWalk = () => {
    console.log("#initializeCurrentWalk");

    this.currentWalkData = {
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

    this.map.addSource('current-walk', { type: 'geojson', data: this.currentWalkData });

    this.map.addLayer({
      'id': 'current-walk',
      'type': 'line',
      'source': 'current-walk',
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
    console.log("#currentWalkToMap");

    // Create current position marker
    const currentPositionEl = document.createElement('i');
    currentPositionEl.classList.add('fa-solid');
    currentPositionEl.classList.add('fa-location-crosshairs');
    currentPositionEl.style.fontSize = '24px';
    currentPositionEl.style.color = 'red';

    if (!this.currentPositionMarker) {
      this.currentPositionMarker = new mapboxgl.Marker(currentPositionEl)
      .setLngLat([position.coords.longitude, position.coords.latitude])
      .addTo(this.map);
    } else {
      this.currentPositionMarker.setLngLat([position.coords.longitude, position.coords.latitude]);
    }

    this.currentWalkData.features[0].geometry.coordinates.push([position.coords.longitude, position.coords.latitude]);

    this.map.getSource('current-walk').setData(this.currentWalkData);
  }
}
