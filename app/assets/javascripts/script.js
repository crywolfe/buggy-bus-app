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
    $( "#search" ).click(function () {
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

    });

    // 4. CLICK BADA BUS SEARCH

    // 4. CLICK LUCKY
    $( "#lucky_results" ).hide();
    $( "#lucky" ).click(function () {
      $( "#lucky_results" ).slideDown( "slow", function() {
      });
    });

  });






