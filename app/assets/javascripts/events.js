$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
      // put your options and callbacks here
      events: '/events.json',

      // calendar will only have the necessary # of rows per month
      fixedWeekCount: false,

      eventMouseover: function(calEvent, jsEvent) {
          var tooltip = '<div class="tooltipevent">' + calEvent.title + '</div>';
          $("body").append(tooltip);
          $(this).mouseover(function(e) {
              $(this).css('z-index', 10000);
              $('.tooltipevent').fadeIn('500');
              $('.tooltipevent').fadeTo('10', 1.9);
          }).mousemove(function(e) {
              $('.tooltipevent').css('top', e.pageY + 10);
              $('.tooltipevent').css('left', e.pageX + 20);
          });
      },

      eventMouseout: function(calEvent, jsEvent) {
           $(this).css('z-index', 8);
           $('.tooltipevent').remove();
      },

    })

});
