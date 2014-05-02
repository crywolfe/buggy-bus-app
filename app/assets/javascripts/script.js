  $( document ).ready(function() {
    // EVENT HANDLER
    // 1. CLICK ON LOGIN
    $( "#login_detail" ).hide();
    $( "#login" ).click(function () {
      $( "#login_detail" ).slideDown( 200, function() {
      });
    });

    // 2. CLICK ON BADA BING SUBMIT
    $( "#submit" ).click(function () {
      $( "#login_detail" ).slideUp( 200, function() {
      });
    });

    // 3. CLICK BADA BUS SEARCH
    $( "form" ).on('submit', function(event) {
      event.preventDefault();
      $( ".small-block-grid-4" ).slideUp( 300, function() {
      });
      var buttonTag = $("<button id='search_2'>");
      buttonTag.text("BADA BUS");
      buttonTag.appendTo("body");
    
      $( "#search_2" ).click( function() {
        $( ".small-block-grid-4" ).slideDown( 350, function() {
          $("#search_2").remove();
        });
      });

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
        url: '/',
        dataType: 'json',
        data: data_hash,
        error: function(data) {
          console.log("failure");
          console.log(data);
        }
        }).done(function(response) {
          // debugger;
          var first_rowTag = $("<li class='results_header'>");
          first_rowTag.appendTo("body");
          first_row = "DEPARTURE" + "  " + "ARRIVAL" + "  " + "DEPARTURE DATE";
          first_rowTag.html(first_row);


            $.each(response, function(i,e) {
              var rowTag = $("<li class='results'>");
              rowTag.text(e.departure_date + " " + e.arrival_location + " " + e.departure_location); 
              rowTag.appendTo("body");
            });

          
          $( "#search_2" ).click( function() {
              $(".results").remove();
              $(".results_header").remove();
              

              // $( "#search_2" ).click( function() {
              //   $( ".small-block-grid-4" ).slideDown( 350, function() {
              //     $("#search_2").remove();
              //   });
              // });
          });

          // render results dynamically

        });
    });

    // 4. CLICK BADA BUS SEARCH

    // 4. CLICK LUCKY
    $( "#lucky_results" ).hide();
    $( "#lucky" ).click(function () {
      $( "#lucky_results" ).slideDown( "slow", function() {
      });
    });

  });






