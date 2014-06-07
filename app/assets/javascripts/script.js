var results_template, templateData;

$( document ).ready(function() {
  // EVENT HANDLER
  var search_result_template = $('#results-template').html()

  results_template = _.template(search_result_template)

  // 1. CLICK BADA BUS SEARCH
  $( "form" ).on('submit', function(event) {
    event.preventDefault();
    $( ".small-block-grid-4" ).slideUp( 300, function() {
    });
    var buttonTag = $("<button id='search_2'>");
    buttonTag.text("BADA BUS");
    buttonTag.appendTo("body");

    var year = $("#search_departure_date_1i").val();
    var month = $("#search_departure_date_2i").val();
    var day = $("#search_departure_date_3i").val();

    var departure_date = year + "/" + month + "/" + day;

    var departure_location = $("#search_departure_location").val();
    var arrival_location = $("#search_arrival_location").val();
    var data_hash = {
      search: {
        departure_date: departure_date,
        departure_location: departure_location,
        arrival_location: arrival_location
        }
      }
    $.ajax({
      type: 'POST',
      url: '/searches',
      dataType: 'json',
      data: data_hash,
      error: function(data) {
        console.log("failure");
        console.log(data);
      }
      }).done(function(response) {

          $.each(response, function(i,e) {

            templateData = {
              company_name: e.company_name,
              price: e.price,
              link: e.link,
              departure_date: e.departure_date,
              departure_location: e.departure_location,
              departure_time: e.departure_time,
              arrival_location: e.arrival_location,
              arrival_date: e.arrival_date,
              arrival_time: e.arrival_time
            }

            $('body').append(results_template(templateData));

          });

        $( "#search_2" ).click( function() {
            $(".results").remove();
            $(".results_header").remove();

        });
      });
  });
});
