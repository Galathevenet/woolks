import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {

  static targets = ['input', 'map'];

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
    mapboxgl.accessToken = this.apiKeyValue;

    if (!navigator.geolocation) {
      console.log('Geolocation is NOT supported by your browser');
    } else {
      console.log('Geolocation IS supported by your browser');

      this.map = new mapboxgl.Map({
        container: this.mapTarget,
        style: "mapbox://styles/mapbox/streets-v10",
        // center: this.center,
        // zoom: 13,
      });

      if (this.currentPositionValue) {
        this.geolocate = new mapboxgl.GeolocateControl({
          positionOptions: {
            enableHighAccuracy: true
          },
          // showAccuracyCircle: false,
          // When active the map will receive updates to the device's location as it changes.
          trackUserLocation: true,
          // Draw an arrow next to the location dot to indicate which direction the device is heading.
          showUserHeading: true,
        })
        this.map.addControl(this.geolocate);
      }

      this.map.on('load', () => {
        // Display hotspots, startPoints and originalWalk
        this.#addHotspotsToMap();
        this.#addStartPointsToMap();
        this.#addOriginalWalkToMap();


        // Display current position
        if (this.currentPositionValue) {
          // this.#displayCurrentPosition(position);
          this.geolocate.trigger();
        }

        // Loop to watch position live
        if (this.liveTrackValue) {
          this.#initializeCurrentWalk(position)
          this.watchPositionId = navigator.geolocation.watchPosition(this.#currentWalkToMap);
        }
      })

      navigator.geolocation.getCurrentPosition(this.#fitMap);

    }
  }

  endWalk() {
    console.log("end");

    navigator.geolocation.clearWatch(this.watchPositionId);

    // To make sure there's at least one position in the waypoints (to avoid calling methods on nil afterwards):
    navigator.geolocation.getCurrentPosition((position) => {
      this.currentWalkData.features[0].geometry.coordinates.push([position.coords.longitude, position.coords.latitude]);
    })

    // Write coordinates in params
    this.inputTarget.value = this.currentWalkData.features[0].geometry.coordinates;
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
      const startPointEl = document.createElement('i');
      startPointEl.classList.add('fa-solid');
      startPointEl.style.fontSize = '20px';
      startPointEl.classList.add('fa-location-dot');
      startPointEl.style.color = '#556644';

      new mapboxgl.Marker(startPointEl)
        .setLngLat([startPoint.longitude, startPoint.latitude])
        .addTo(this.map);
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

  #initializeCurrentWalk = (position) => {
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
        'line-color': '#FE7F2D',
        'line-width': 4
      }
    });
  }

  #currentWalkToMap = (position) => {
    // console.log("#currentWalkToMap");

    this.#displayCurrentPosition(position)

    this.currentWalkData.features[0].geometry.coordinates.push([position.coords.longitude, position.coords.latitude]);

    this.map.getSource('current-walk').setData(this.currentWalkData);
  }

  #displayCurrentPosition = (position) => {
    // Add geolocate control to the map.




    // Create current position marker
    // const currentPositionEl = document.createElement('i');
    // currentPositionEl.classList.add('fa-solid');
    // currentPositionEl.classList.add('fa-location-crosshairs');
    // currentPositionEl.style.fontSize = '20px';
    // currentPositionEl.style.color = '#FE7F2D';

    // if (!this.currentPositionMarker) {
    //   this.currentPositionMarker = new mapboxgl.Marker(currentPositionEl)
    //   .setLngLat([position.coords.longitude, position.coords.latitude])
    //   .addTo(this.map);
    // } else {
    //   this.currentPositionMarker.setLngLat([position.coords.longitude, position.coords.latitude]);
    // }
  }

  #fitMap = (position) => {
    const bounds = new mapboxgl.LngLatBounds()

    if (!this.liveTrackValue) {
      this.hotspotsValue.forEach((marker) => {
        bounds.extend([ marker.longitude, marker.latitude ])
      })
    }

    this.waypointsValue.forEach((marker) => {
      bounds.extend([ marker.longitude, marker.latitude ])
    })

    this.startPointsValue.forEach((marker) => {
      bounds.extend([ marker.longitude, marker.latitude ])
    })

    if (this.currentPositionValue) {
      bounds.extend([ position.coords.longitude, position.coords.latitude ])
    }

    this.map.fitBounds(bounds, { padding: 20, maxZoom: 17, duration: 0 })
  }
}
