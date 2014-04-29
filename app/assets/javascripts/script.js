  $( document ).ready(function() {
    // EVENT HANDLER
    // 1. CLICK ON LOGIN
    $( "#login_detail" ).hide();
    $( "#login" ).click(function () {
      $( "#login_detail" ).slideDown( "slow", function() {
        });
    });
    // 2. CLICK SEARCH
    $( "#search_results" ).hide();
    $( "#search" ).click(function () {
      $( "#search_results" ).slideDown( "slow", function() {
        });
    });

    // 3. CLICK LUCKY
    $( "#lucky_results" ).hide();
    $( "#lucky" ).click(function () {
      $( "#lucky_results" ).slideDown( "slow", function() {
        });
    });





  });






