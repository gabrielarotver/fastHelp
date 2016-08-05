var handler;
$(document).on('turbolinks:load', function(){


  if(window.location.pathname === "/") {
    $('#geocoding_fields').show();
    $('#geocoding').addClass('active');
    $.ajax("/events.json").done(function(event){
      var events = event;
      console.log(events[1].latitude);
      $.ajax("/organizations.json").done(function(orgs){
        var organizations = orgs;
        console.log(organizations);

        // work with googlemaps APIs
        handler = Gmaps.build('Google');

        var mapOptions = {
          provider:{
            zoom: 10,
            mapTypeId: google.maps.MapTypeId.NORMAL,
            panControl: true,
            scaleControl: false,
            streetViewControl: true,
            overviewMapControl: true,
          },
          internal: {id: 'map-canvas'}
        };

        handler.buildMap(mapOptions, function(){
          handler.map.centerOn({lat: organizations[0].latitude, lng: organizations[0].longitude});
          for(var i = 0; i < events.length; i++) {
            markers = handler.addMarkers([
              {
                "lat": events[i].latitude,
                "lng": events[i].longitude,
                "infowindow": "Event: " +events[i].event_name + "<br>" + events[i].street_address
              }
            ]);
          }

          for(var i = 0; i < organizations.length; i++) {
            markers = handler.addMarkers([
              {
                "lat": organizations[i].latitude,
                "lng": organizations[i].longitude,
                "infowindow": "Org: " + organizations[i].org_name + "<br>" + organizations[i].street_address
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
