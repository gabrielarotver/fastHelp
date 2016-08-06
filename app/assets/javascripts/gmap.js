var handler;

$(document).on('turbolinks:load', function(){

  if(window.location.pathname === "/" || window.location.pathname.match("/events/") || window.location.pathname.match("/organizations/")) {
    $('#geocoding_fields').show();
    $('#geocoding').addClass('active');
    // test
    $.ajax("/events.json").done(function(event){
      var events = event;
      $.ajax("/organizations.json").done(function(orgs){
        var organizations = orgs;

        // work with googlemaps APIs
        handler = Gmaps.build('Google');
        var centerOnMarker = organizations[0];
        var url = window.location.pathname;
        var zoomInValue, id;

        if(url === "/") {
          zoomInValue = 10;
        } else {
          zoomInValue = 20;
          id = parseInt(url.substring(url.lastIndexOf('/') + 1)) - 1;
          centerOnMarker = url.match("/events/") ? events[id-1] : events[id-1];
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

        handler.buildMap(mapOptions, function(){
          handler.map.centerOn({lat: centerOnMarker.latitude, lng: centerOnMarker.longitude});

          for(var i = 0; i < events.length; i++) {
            markers = handler.addMarkers([
              {
                "lat": events[i].latitude,
                "lng": events[i].longitude,
                "infowindow": 'Event: <a href="/events/'+ event[i].id + '">' + events[i].event_name + '</a>' + "<br>" + events[i].street_address
              }
            ]);
          }

          for(var i = 0; i < organizations.length; i++) {
            markers = handler.addMarkers([
              {
                "lat": organizations[i].latitude,
                "lng": organizations[i].longitude,
                "infowindow": 'Org: <a href="/organizations/'+ organizations[i].id + '">' + organizations[i].org_name + '</a>' + "<br>" + organizations[i].street_address
              }
            ]);
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
