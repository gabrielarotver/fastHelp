$(document).on('turbolinks:load', function(){


  if(window.location.pathname === "/") {
    $.ajax("/events.json").done(function(event){
      var events = event;
      console.log(events[1].latitude);
      $.ajax("/organizations.json").done(function(orgs){
        var organizations = orgs;
        console.log(organizations);

        // work with googlemaps APIs
        handler = Gmaps.build('Google');
        handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){

        for(var i = 0; i < events.length; i++) {
          markers = handler.addMarkers([
            {
              "lat": events[i].latitude,
              "lng": events[i].longitude,
              "infowindow": events[i].event_name + "<br>" + events[i].street_address
            }
          ]);
        }

        for(var i = 0; i < organizations.length; i++) {
          markers = handler.addMarkers([
            {
              "lat": organizations[i].latitude,
              "lng": organizations[i].longitude,
              "infowindow": organizations[i].org_name + "<br>" + organizations[i].street_address
            }
          ]);
        }

        handler.bounds.extendWith(markers);
        handler.fitMapToBounds();
        });

      });
     });
  }


});
