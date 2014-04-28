
<<<<<<< HEAD
  $(document.body).click(function() {
    $("#login.detail").slideDown( "slow", function() {

      alert("Slide")

=======
  $( document ).ready(function() {
    $( "#login_detail" ).hide();
    $( "#login" ).click(function () {
      $( "#login_detail" ).slideDown( "slow", function() {
        });
>>>>>>> css
    });


  });

  // $( "#login" ).click(function() {
  //   $( "#login_detail" ).slideDown( "slow", function() {
  //     alert("SLIDEDOWN")
  //     // Animation complete.
  //   });
  // });






