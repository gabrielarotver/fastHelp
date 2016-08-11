var handler;
var crd;
var id;
$(document).on('turbolinks:load', function(){

  if($('div#map-canvas').length > 0) {

    $.ajax("/events.json").done(function(event){
      var events = event;
      $.ajax("/organizations.json").done(function(orgs){
        var organizations = orgs;

        // work with googlemaps APIs
        handler = Gmaps.build('Google');
        var centerOnMarker = organizations[0];
        // console.log(centerOnMarker);
        var url = window.location.pathname;
        var zoomInValue;

        if(url === "/") {
          zoomInValue = 10;
          // show search field on main map
          $('#geocoding_fields').show();
          $('#geocoding').addClass('active');
        } else {
          getLocation();
          zoomInValue = 20;
          id = parseInt(url.substring(url.lastIndexOf('/') + 1));
          centerOnMarker = url.match("/events/") ? events.find(findObjById) : organizations.find(findObjById);
          // console.log(centerOnMarker);
        }

        var mapOptions = {
          provider:{
            zoom: zoomInValue,
            mapTypeId: google.maps.MapTypeId.NORMAL,
            panControl: true,
            scaleControl: false,
            streetViewControl: true,
            overviewMapControl: true,
          },
          internal: {id: 'map-canvas'}
        };

        if(centerOnMarker.latitude === undefined || centerOnMarker.longitude ===undefined) {

          centerOnMarker.latitude = 37.0902;
          centerOnMarker.longitude = 95.7129;
        }

        handler.buildMap(mapOptions, function(){
          handler.map.centerOn({lat: centerOnMarker.latitude, lng: centerOnMarker.longitude});

          for(var i = 0; i < events.length; i++) {
            markers = handler.addMarkers([
              {
                "picture": {
                  "url": "http://icons.iconarchive.com/icons/icons-land/vista-map-markers/32/Map-Marker-Marker-Outside-Azure-icon.png",
                  "width":  32,
                  "height": 32
                },
                "lat": events[i].latitude,
                "lng": events[i].longitude,
                "infowindow": 'Event: <a href="/events/'+ event[i].id + '">' + events[i].title + '</a>' + "<br>" + events[i].street_address
              }
            ]);
          }


          for(var i = 0; i < organizations.length; i++) {
            markers = handler.addMarkers([
              {
                "picture": {
                  "url": "http://icons.iconarchive.com/icons/icons-land/vista-map-markers/32/Map-Marker-Marker-Outside-Pink-icon.png",
                  "width":  32,
                  "height": 32
                },
                "lat": organizations[i].latitude,
                "lng": organizations[i].longitude,
                "infowindow": 'Org: <a href="/organizations/'+ organizations[i].id + '">' + organizations[i].org_name + '</a>' + "<br>" + organizations[i].street_address
              }
            ]);
          }


          if(url !== "/" && crd !== null && crd !== undefined) {
              console.log("GETTING DIRECTIONS");
              setTimeout(getDirections(centerOnMarker), 5000);
          }

        });
          $("#submit_button_geocoding").click(function(){
            var geocoding  = new google.maps.Geocoder();
            codeAddress(geocoding, handler);
          });

      });
     });

  }
});

function codeAddress(geocoding){
  console.log(handler);
  var address = $("#search_box_geocoding").val();
  if(address.length > 0){
    geocoding.geocode({'address': address},function(results, status){
      if(status == google.maps.GeocoderStatus.OK){
        handler.map.centerOn(results[0].geometry.location);
        handler.getMap().setZoom(13);
        var marker  =  new google.maps.Marker({
          position: results[0].geometry.location
        });
        }else{
        alert("Geocode was not successful for the following reason: " + status);
      }
    });
  }else{
    alert("Search field can't be blank");
  }
}

function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(success, error);
    } else {
        console.log("Geolocation is not supported by this browser.");
        crd = null;
    }
}

function success(pos) {
  crd = pos.coords;

  console.log('Your current position is:');
  console.log('Latitude : ' + crd.latitude);
  console.log('Longitude: ' + crd.longitude);
};

function error(err) {
  console.warn('ERROR(' + err.code + '): ' + err.message);
  crd = null;
};


function getDirections(destination) {
  var directionsService = new google.maps.DirectionsService();
  var directionsDisplay = new google.maps.DirectionsRenderer();
  console.log("Debug 1");
  // map = new google.maps.Map(document.getElementById("map-canvas"));

  directionsDisplay.setMap(handler.getMap());

  console.log("Debug 2");
  var request = {
    origin:      new google.maps.LatLng(crd.latitude, crd.longitude),
    destination: new google.maps.LatLng(destination.latitude, destination.longitude),
    travelMode:  google.maps.TravelMode.DRIVING
  };
  directionsService.route(request, function(response, status) {
    //Check if request is successful.
    if (status == google.maps.DirectionsStatus.OK) {
      console.log(status);
      directionsDisplay.setDirections(response); //Display the directions result
    }
  });
}


function findObjById(eventOrg) {
    return eventOrg.id === id;
}
