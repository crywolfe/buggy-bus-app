//journey results init
(function ($) {
	$(function () {
		$('.searchButton').click(function () {
			if ($('input[id$=txtOutboundDate]').val().length == 0) {
				return false;
			}
		});
		//initialize search button
		$('input.addJourneyButton').controlEnable($('.searchSelect:checked').length != 0);
		// Click event for the radio button
		$('.searchSelect').click(function() {
			// Make that button clickable
			$('input.addJourneyButton').controlEnable(true);
			$('input.continueButton').controlEnable(true);
			// Sleeper behaviour for public only 
			if ($('div.journeyresult').length) {
				// If there is a sleeper on the page
				if ($(this).parents('div.journeyresult').find('ul.journey.sleeper').length > 0) {

					var $journey = $(this).parents('ul.journey');
					var $journeyCollection = $(this).parents('div.journeyresult');
					var totalJourneys = $journeyCollection.find('ul.journey').length;
					var journeyIndex = $journeyCollection.find('ul.journey').index($journey);

					// If the selected result is in the last two and we did not click on "No return journey"
					if (journeyIndex + 1 > totalJourneys - 2 && $journey != null) {
						// Show the sleeper
						$journeyCollection.find('ul.journey.sleeper').addClass('sleeper-show').removeClass('sleeper-hide');
					} else {
						// Hide the sleeper
						$journeyCollection.find('ul.journey.sleeper').addClass('sleeper-hide').removeClass('sleeper-show');
					}
				}
				// If there is megabus gold on the page
				if ($(this).parents('div.journeyresult').find('ul.journey.megabusgold').length > 0) {

					var $journey = $(this).parents('ul.journey');
					var $journeyCollection = $(this).parents('div.journeyresult');
					var totalJourneys = $journeyCollection.find('ul.journey').length;
					var journeyIndex = $journeyCollection.find('ul.journey').index($journey);

					// If the selected result is in the last two and we did not click on "No return journey"
					if (journeyIndex + 1 > totalJourneys - 2 && $journey != null) {
						// Show Megabus Gold
						$journeyCollection.find('ul.journey.megabusgold').addClass('megabusgold-show').removeClass('megabusgold-hide');
					} else {
						// Hide Megabus Gold
						$journeyCollection.find('ul.journey.megabusgold').addClass('megabusgold-hide').removeClass('megabusgold-show');
					}
				}
			}
		});
	});
})(jQuery);