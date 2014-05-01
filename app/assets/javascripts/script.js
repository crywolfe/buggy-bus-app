  $( document ).ready(function() {
    // EVENT HANDLER
    // 1. CLICK ON LOGIN
    $( "#login_detail" ).hide();
    $( "#login" ).click(function () {
      $( "#login_detail" ).slideDown( 100, function() {
        });
    });

// 1. CLICK ON BADA BING SUBMIT
    $( "#submit" ).click(function () {
      $( "#login_detail" ).slideUp( 100, function() {
        });
    });

    // 2. CLICK BADA BUS SEARCH
    $( "#search" ).click(function () {
      $( ".small-block-grid-4" ).slideUp( 250, function() {
        });
    });

    // 3. CLICK LUCKY
    $( "#lucky_results" ).hide();
    $( "#lucky" ).click(function () {
      $( "#lucky_results" ).slideDown( "slow", function() {
        });
    });

    // NEED TO BE ABLE TO SLIDE DOWN ALL THE DIVS ON THE PAGE WHEN THESE SLIDEDOWN EVENTS OCCUR





  });






