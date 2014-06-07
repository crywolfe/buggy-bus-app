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
        var first_rowTag = $("<li class='results_header'>");
        first_rowTag.appendTo("body");
        first_row = "DEPARTURE" + "  " + "ARRIVAL" + "  " + "DEPARTURE DATE";
        first_rowTag.html(first_row);

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
            debugger;
            $('body').append(results_template(templateData));

            console.log(e)

            // $('body').append('<div>' + e.departure_date + '</div>')

            // var resultsTag = $("<div class='results'>");
            // resultsTag.appendTo("body");
            // var companyPriceRowTag = $("<div class='row'>");
            // companyPriceRowTag.appendTo(".results");
            // var small4Tag = $("<div class='small-4 columns'>");
            // small4Tag.text(e.company_id);
            // small4Tag.appendTo(".row");

            // var small8Tag = $("<div class='small-8 columns'>");
            // small8Tag.text(e.price);
            // small8Tag.appendTo(".row");


            // // var departureRowTag = $("<div class='row'>");
            // // departureRowTag.appendTo(".results");

            // var small42Tag = $("<div class='small-4 columns'>");
            // small42Tag.text(e.departure_date);
            // small42Tag.appendTo(".row");

            // var small82Tag = $("<div class='small-8 columns'>");
            // small82Tag.text(e.departure_location);
            // small82Tag.appendTo(".row");

            // // var departureRowTag = $("<div class='row'>");
            // // departureRowTag.appendTo(".results");

            // var small43Tag = $("<div class='small-4 columns'>");
            // small43Tag.text(e.arrival_date);
            // small43Tag.appendTo(".row");

            // var small83Tag = $("<div class='small-8 columns'>");
            // small83Tag.text(e.arrival_location);
            // small83Tag.appendTo(".row");

          });

        $( "#search_2" ).click( function() {
            $(".results").remove();
            $(".results_header").remove();

        });
      });
  });
});
