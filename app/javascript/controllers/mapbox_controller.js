import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {

  static targets = ['map', 'waypoints', 'duration', 'distance'];

  static values = {
    apiKey: String,
    hotspots: Array,
    waypoints: Array,
    startPoints: Array,
    currentPosition: Boolean,
    liveTrack: Boolean,
    centerCurrent: Boolean
  };

  connect() {
    console.log("Connected to mapbox_controller.js");

    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: "mapbox://styles/mapbox/streets-v10",
      // center: this.center,
      // zoom: 13
    });

    this.map.on('load', () => {
      // Display hotspots, startPoints and originalWalk
      this.#addHotspotsToMap();
      this.#addStartPointsToMap();
      this.#addOriginalWalkToMap();
      this.#fitBoundsWithoutCurrentPosition();

      if (this.currentPositionValue) {
        navigator.geolocation.getCurrentPosition(
          (position) => {
            // Display current position
            this.#displayCurrentPosition(position);

            // Extend bounds by taking into account current user position
            this.bounds.extend([position.coords.longitude, position.coords.latitude]);
            this.map.fitBounds(this.bounds, { padding: 20, maxZoom: 17, duration: 0 });
          }
        )
      }

      // Loop to watch position live
      if (this.liveTrackValue) {
        this.#initializeCurrentWalk()
        this.watchPositionId = navigator.geolocation.watchPosition(this.#currentWalkToMap);
        this.startTime = new Date();
      }
    })
  }

  endWalk() {
    console.log("endWalk");

    navigator.geolocation.clearWatch(this.watchPositionId);

    navigator.geolocation.getCurrentPosition(
      (position) => {
        // To make sure there's at least one position in the waypoints (to avoid calling methods on nil afterwards):
        this.currentWalkData.features[0].geometry.coordinates.push([position.coords.longitude, position.coords.latitude]);
      },
      this.#endWalkError
    )

    // Update hidden input field of the "End Walk" button
    this.distanceTarget.value = this.distance;
    this.endTime = new Date()
    this.durationTarget.value = (this.endTime - this.startTime)/1000;
    this.waypointsTarget.value = this.currentWalkData.features[0].geometry.coordinates;
    console.log(this.waypointsTarget.value)
  }

  #endWalkError = (error) => {
    alert('ERROR: ' + error.message + '. Your walk may not be saved completly');
  }

  #addHotspotsToMap = () => {
    // console.log("#addHotspotsToMap");

    this.hotspotsValue.forEach((hotspot) => {
      const hotspotEl = document.createElement('i');
      hotspotEl.classList.add('fa-solid');
      hotspotEl.style.fontSize = '20px';

      switch (hotspot.category) {
        case 'dispenser':
          hotspotEl.classList.add('fa-trash-can');
          hotspotEl.style.fontSize = '16px';
          hotspotEl.style.color = '#FE7F2D';
          break;
        case 'park':
          hotspotEl.classList.add('fa-tree');
          hotspotEl.style.color = '#FE7F2D';//'#5fbf00';
          break;
        case 'fountain':
          hotspotEl.classList.add('fa-faucet');
          hotspotEl.style.color = '#FE7F2D';//'#00afef';
          break;
        default:
          break;
      }

      new mapboxgl.Marker(hotspotEl)
      .setLngLat([hotspot.longitude, hotspot.latitude])
      .addTo(this.map);

    })
  }

  #addStartPointsToMap = () => {
    // console.log("#addStartPointsToMap");
    this.startPointsValue.forEach((startPoint) => {
      const popup = new mapboxgl.Popup().setHTML(startPoint.info_window)
      const startPointEl = document.createElement('i');
      startPointEl.classList.add('fa-solid');
      startPointEl.style.fontSize = '20px';
      startPointEl.style.paddingBottom = '20px';
      startPointEl.classList.add('fa-location-dot');
      startPointEl.style.color = '#556644';

      new mapboxgl.Marker(startPointEl)
        .setLngLat([startPoint.longitude, startPoint.latitude])
        .addTo(this.map)
        .setPopup(popup);
    });
  }

  #addOriginalWalkToMap = () => {
    // console.log("#addOriginalWalkToMap");

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
        'line-color': '#556644',
        'line-width': 4
      }
    });
  }

  #initializeCurrentWalk = () => {
    // console.log("#initializeCurrentWalk");

    this.currentWalkData = {
      'type': 'FeatureCollection',
      'features': [
        {
          'type': 'Feature',
          'geometry': {
            'type': 'LineString',
            'coordinates': [
              // [position.coords.longitude, position.coords.latitude]
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
        'line-color': '#1DA1F2',
        'line-width': 4
      }
    });
  }

  #currentWalkToMap = (position) => {
    // console.log("#currentWalkToMap");

    this.#displayCurrentPosition(position)

    // Distance calculation
    if (this.currentWalkData.features[0].geometry.coordinates.length === 0) {
      this.distance = 0;
    } else {
      this.distance += turf.distance(
        [position.coords.longitude, position.coords.latitude],
        this.currentWalkData.features[0].geometry.coordinates.slice(-1)[0],
        {units: 'kilometers'}
      );
    }
    console.log(`distance: ${this.distance}`);

    this.currentWalkData.features[0].geometry.coordinates.push([position.coords.longitude, position.coords.latitude]);

    this.map.getSource('current-walk').setData(this.currentWalkData);
  }

  #displayCurrentPosition = (position) => {
    // Create current position marker
    const currentPositionEl = document.createElement('i');
    currentPositionEl.classList.add('fa-solid');
    currentPositionEl.classList.add('fa-circle');
    currentPositionEl.style.border = "2px solid white"
    currentPositionEl.style.borderRadius = "50%"
    currentPositionEl.style.boxShadow = "0px 0px 3px black";
    currentPositionEl.style.fontSize = '16px';
    currentPositionEl.style.color = '#1DA1F2';

    if (!this.currentPositionMarker) {
      this.currentPositionMarker = new mapboxgl.Marker(currentPositionEl)
      .setLngLat([position.coords.longitude, position.coords.latitude])
      .addTo(this.map);
    } else {
      this.currentPositionMarker.setLngLat([position.coords.longitude, position.coords.latitude]);
    }
  }

  #fitBoundsWithoutCurrentPosition() {
    this.bounds = new mapboxgl.LngLatBounds()

    if (!this.liveTrackValue) {
      this.hotspotsValue.forEach((marker) => {
        this.bounds.extend([ marker.longitude, marker.latitude ])
      })
    }

    this.waypointsValue.forEach((marker) => {
      this.bounds.extend([ marker.longitude, marker.latitude ])
    })

    this.startPointsValue.forEach((marker) => {
      this.bounds.extend([ marker.longitude, marker.latitude ])
    })

    // Only if this.bounds has been initialized with values:
    if (this.bounds.hasOwnProperty('_ne')) {
      this.map.fitBounds(this.bounds, { padding: 20, maxZoom: 17, duration: 0 })
    }
  }
}
