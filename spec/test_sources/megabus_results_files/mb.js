
///script file for general megabus functions shared between all sites.
(function ($, undefined) {
	$(function () {

		//validation enable functions
		$.fn.validateEnable = function (enable) {
			return $(this).each(function () { ValidatorEnable(this, enable); });
		};
		//control enable functions
		$.fn.controlEnable = function (enable) {
			if (enable === undefined) {
				$(this).each(function () {
					if ($(this).attr("disabled")) {
						$(this).addClass("disabled");
					}
				});
			}
			else if (enable) {
				return $(this).removeAttr('disabled').removeClass("disabled");
			} else {
				return $(this).attr('disabled', 'true').addClass("disabled");
			}
		};

		//fancy text boxes
		$.fn.fancyTextBox = function (options) {
			function hideText() {
				var $this = $(this);
				$this.removeClass('inactive');
				var initText = $this.attr('data-init');
				if ($this.val() == initText) {
					$this.val('');
				}
			}

			function showText() {
				var $this = $(this);
				var initText = $this.attr('data-init');
				if ($this.val() == initText || $this.val() == '') {
					$this.val(initText).addClass('inactive');
				} else {
					$this.removeClass('inactive');
				}
			}

			switch (options) {
				case 'hasValue':
					return (this.val() != this.attr('data-init') && this.val() != '');
				case 'clear':
					return this.each(hideText);
				case 'disable':
					return this.each(hideText);
				case 'enable':
					return this.each(showText);
			}

			var settings = $.extend({}, options);
			return this.each(function () {
				var $this = $(this);
				var initText = $this.attr('data-init');
				if ($this.val() == initText || $this.val() == '') {
					$this.val(initText).addClass('inactive');
				}
				$this.focus(hideText).blur(showText).change(showText);
			});
		};

		$('div.contact-form').each(function () {
			var $this = $(this);
			var $subject = $this.find('select.ddl-subject').change(update);
			var $name = $this.find('input.txt-name').keyup(update);
			var $email = $this.find('input.txt-email').keyup(update);
			var $comment = $this.find('textarea').keyup(update).fancyTextBox();
			var $submit = $this.find('input.btn');

			function update() {
				var hasSubject = $subject.val() != "0";
				var hasName = $name.val() != '';
				var hasEmail = ($email.val() != '' && $email.val().indexOf('@') != -1);
				var hasComment = $comment.fancyTextBox('hasValue');
				$name.controlEnable(hasSubject);
				$email.controlEnable(hasSubject);
				$comment.controlEnable(hasSubject);
				$submit.controlEnable(hasSubject && hasName && hasEmail && hasComment);
			}
			update();
		});

		$('div.feedbackform').each(function () {
			var $this = $(this);
			var $button = $this.find('input.btn');
			var $text = $this.find('textarea').fancyTextBox().keyup(update);
			function update() {
				$button.controlEnable($text.fancyTextBox('hasValue'));
			}
			update();
		});


		//login widget
		$('div.login-widget').each(function () {
			var $this = $(this);
			var $email = $this.find('input.txt-email').fancyTextBox();
			var $pass = $this.find('input.txt-password').fancyTextBox();
			var $button = $this.find('input.btn-login');
			function updateControls() {
				var hasEmail = $email.fancyTextBox('hasValue');
				$pass.controlEnable(hasEmail);
				$button.controlEnable($pass.fancyTextBox('hasValue') && hasEmail && $pass.focus());
			}
			$email.on('input propertychange', updateControls);
			$pass.on('input propertychange', updateControls);
			updateControls();
		});


		//reservation widget code...
		$('div.reservation-widget').each(function () {
			var $this = $(this);
			var $resNo = $this.find('input.txtResNo').on('input propertychange', updateControls).fancyTextBox();
			var $email = $this.find('input.txtResEmail').on('input propertychange', updateControls).fancyTextBox();
			var $button = $this.find('input.find_btn');
			function updateControls() {
				var hasResNo = $resNo.fancyTextBox('hasValue');
				$email.controlEnable(hasResNo);
				$button.controlEnable(hasResNo && $email.fancyTextBox('hasValue'));
			}
			updateControls();
		});

		function setOtherDisabledText() {
			var $this = $(this);
			$this.parents('li').find('input.txt-disability-other').controlEnable($this.is(':checked'));
		}
		$('span.chk-disability-other input').each(setOtherDisabledText).change(setOtherDisabledText);

		//tooltips
		$('.tooltip').lwtooltip({ 'anchor': 'bl', yoffset: -20, xoffset: 20 });
		//dateselector
		$('.date_select').each(function () {
			var $this = $(this);
			var dy = $this.find('.date_day');
			var mn = $this.find('.date_month');
			var yr = $this.find('.date_year');
			mn.unbind().removeAttr('onchange');
			yr.unbind().removeAttr('onchange');

			function daysInMonth(Month, Year) {
				return 32 - new Date(Year, Month, 32).getDate();
			}
			function populateDays() {
				var days = daysInMonth(mn.val() - 1, yr.val());
				var selected = dy.val();
				if (days < selected) {
					selected = days;
				}
				dy.html('');
				dy.append('<option value="0">Day</option>');
				for (var i = 1; i <= days; i++) {
					dy.append('<option value="' + i + '">' + (i > 9 ? '' : '0') + i + '</option>');
				}
				dy.val(selected);
			}
			mn.change(function (e) { populateDays(); });
			yr.change(function (e) { populateDays(); });
		});

		$('div.expandlink').each(function () {
			var $this = $(this);
			var $content = $this.find('.content').hide();
			$this.find('a.link').click(function () {

				$content.slideToggle();
			});
		});

		//start journey planner
		$('div#searchandbuy').each(function () {
			//cache all important controls..
			var $jp = $(this);
			var $contentPanel = $jp.find('div.content-panel');
			var $loaderAnim = $jp.find('div.loader-anim');
			var $region = $jp.find('select.ddl-region');
			var $origin = $jp.find('select.ddl-origin');
			var $dest = $jp.find('select.ddl-dest');
			var $travelType = $jp.find('select.ddl-traveltype');
			var $deptDate = $jp.find('input.txt-out').fancyTextBox();
			var $returnDate = $jp.find('input.txt-return').fancyTextBox();
			var $paxCounts = $jp.find('input.pax-count');
			var $submit = $jp.find('input.submit-btn');
			var $miscControls = $jp.find('span.chkbox input, input.txt-promo');
			//variables for keeping track of stuff
			var loadCount = 0, busyTimer, loadDatesTimer, loadDestTimer, loadOrigTimer, hasOutboundDates = false, hasReturnDates = false, lastControl;
			var loadPause = 250, lockDelay = 2000;


			function dateValidate() {
				hideWarnings();
				updateEnable();
			}

			$jp.find('input.datepicker').each(function () {
				var $this = $(this);
				$this.datepicker({
					dateFormat: $this.attr('data-format'), firstDay: $this.attr('data-firstday'), buttonImage: "/images/icon_calendar.gif", showOn: "both", buttonImageOnly: true, onSelect: dateValidate
				});
			});

			//start ajax request
			function beginRequest() {
				if (lastControl == null) {
					lastControl = document.activeElement;
				}
				loadCount++;
				busyTimer = setTimeout(function () {

					if (loadCount > 0) {
						disableForm();
						$contentPanel.fadeTo('fast', 0.8);
						$loaderAnim.show();
					}
				}, lockDelay);
			}
			//end an ajax request
			function endRequest(sender, args) {
				loadCount--;
				if (loadCount == 0) {

					clearTimeout(busyTimer);
					$contentPanel.fadeTo('fast', 1);
					$loaderAnim.hide();
					updateEnable();
					lastControl.focus();
					lastControl = null;
				}
			}

			//disable all form elements
			function disableForm() {
				$deptDate.datepicker('disable');
				$returnDate.datepicker('disable');
				//disables entire form
				$jp.find('input, select').controlEnable(false);
			}

			//enable/disable submit based on pax count
			function validatePax() {
				var totalPax = 0;
				$paxCounts.each(function (i, n) {
					totalPax += parseInt($(n).val(), 10);
				});
				if (totalPax > 0) {
					$miscControls.controlEnable(true);
					$submit.controlEnable(true);
				}
			}


			//update forms enable state
			function updateEnable() {
				//hideWarnings();
				//disable everything
				$deptDate.fancyTextBox('disable');
				$returnDate.fancyTextBox('disable');
				var rtDate = $returnDate.datepicker('getDate');
				if (rtDate != null && rtDate < $deptDate.datepicker('getDate')) {
					$returnDate.val('');
					$jp.find('.invalid-dep').show();
				}

				disableForm();
				$origin.controlEnable(true);
				$region.controlEnable(true);
				if ($origin.val() > 0) {
					$dest.controlEnable(true);
					if ($dest.val() > 0 && hasOutboundDates) {
						$travelType.controlEnable(true);
						//control enable to remove disabled styling too
						$deptDate.datepicker('enable').controlEnable(true); ;
						var outbound = $deptDate.datepicker('getDate');
						if (outbound != null) {
							$paxCounts.controlEnable(true);
							if (hasReturnDates) {
								$returnDate.datepicker('option', 'minDate', outbound).datepicker('enable').controlEnable(true);
							}
							validatePax();
						}
					}
				}
				$deptDate.fancyTextBox('enable');
				$returnDate.fancyTextBox('enable');
			}

			//populate a locations dropdown
			function popLocations($target, values, defaultText, preValue, callback) {
				$target.empty().append($('<option value="0">' + defaultText + '</option>'));
				for (var i = 0; i < values.length; i++) {
					var city = values[i];
					var selected = city.idField == preValue;
					$target.append($('<option value="' + city.idField + '" ' + (selected ? 'selected="selected"' : '') + '>' + city.descriptionField + '</option>'));
					if (selected) {
						callback();
					}
				}
			}

			//populate transport type dropdown
			function popTransportType(values) {
				if ($travelType.length == 0)
					return;
				$travelType.empty().append($('<option value="0">All</option>'));
				if (values == null)
					return;
				for (var i = 0; i < values.length; i++) {
					var type = values[i];
					$travelType.append($('<option value="' + type.idField + '">' + type.nameField + '</option>'));
				}
			}

			function setControlDates(con, minDate, data) {
				//disable fancy textbox thing for duration or datepicker will think there's a date entered
				con.fancyTextBox('disable');
				var max = null, min = null;
				var ranges = [];
				if (data != null) {
					for (var i = 0; i < data.length; i++) {
						var start = $.datepicker.parseDate("yy-mm-dd", data[i].Start);
						start.setHours(0);
						var end = $.datepicker.parseDate("yy-mm-dd", data[i].End);
						end.setHours(0);
						if (start < minDate) {
							start = minDate;
						}
						if (end > minDate) {
							if (min == null || start < min) {
								min = start;
							}
							if (max == null || end > max) {
								max = end;
							}
							ranges.push({ 'Start': start, 'End': end });
						}
					}
					con.data('validdates', ranges);
					con.datepicker('option', 'minDate', min);
					con.datepicker('option', 'maxDate', max);
				} else {
					con.data('validdates', []);
					con.val('');
					con.controlEnable(false).datepicker('disable');
				}
				con.fancyTextBox('enable');
			}

			//get destinations by origin
			function getDests() {
				var current = $dest.val();
				clearTimeout(loadDestTimer);

				loadDestTimer = setTimeout(function () {
					hideWarnings();
					var originId = $origin.val();

					beginRequest(this);
					$.ajax({
						type: "GET",
						url: "/support/journeyplanner.svc/GetDestinations",
						data: { 'originId': originId },
						success: function (result) {
							popLocations($dest, result.d, 'Select destination', current, getDates);
							endRequest();
						},
						error: function (xhr, status, error) {
							endRequest();
						}
					});
				}, loadPause);
			}
			//fetch origins from service based on selected region and populates the origins list
			function getOrigins() {
				clearTimeout(loadOrigTimer);
				var current = $origin.val();
				loadOrigTimer = setTimeout(function () {
					hideWarnings();
					var regionId = $region.val();
					beginRequest();
					$.ajax({
						type: "GET",
						url: "/support/journeyplanner.svc/GetOrigins",
						data: { 'regionId': regionId },
						success: function (result) {
							popLocations($origin, result.d, 'Select origin', current, getDests);
							popLocations($dest, [], 'Select destination');
							endRequest();
						},
						error: function (xhr, status, error) {
							endRequest();
						}
					});
				}, loadPause);
			}
			//fetch dates and journey type if applicable
			function getDates() {
				clearTimeout(loadDatesTimer);
				loadDatesTimer = setTimeout(function () {
					hideWarnings();
					var originId = $origin.val();
					var destId = $dest.val();
					if (destId > 0 && originId > 0) {
						beginRequest();
						$.ajax({
							type: "GET",
							url: "/support/journeyplanner.svc/GetTravelDates",
							data: { 'originId': originId, 'destId': destId },
							success: function (result) {
								var now = new Date();
								var today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
								hasReturnDates = (result.d.Return != null);
								hasOutboundDates = (result.d.Out != null);

								if (!hasOutboundDates) {
									$jp.find("div.no-outbound").show();
								} else {
									$jp.find("div.no-outbound").hide();
								}
								if (!hasReturnDates) {
									$jp.find("div.no-return").show();
								} else {
									$jp.find("div.no-return").hide();
								}
								setControlDates($deptDate, today, result.d.Out);
								setControlDates($returnDate, today, result.d.Return);
								popTransportType(result.d.TransportTypes);
								endRequest();
							},
							error: function (xhr, status, error) {
								endRequest();
							}
						});
					} else {
						updateEnable();
					}
				}, loadPause);
			}

			function hideWarnings() {
				$jp.find('div.error_msg').hide();
			}

			$region.change(getOrigins);
			$origin.change(getDests);
			$dest.change(getDates);

			$deptDate.change(dateValidate);
			$returnDate.change(dateValidate);

			$paxCounts.on('keydown keyup change', function () {
				var totalPax = 0;
				$paxCounts.each(function (i, n) {
					totalPax += parseInt($(n).val(), 10);
				});
				$miscControls.controlEnable(totalPax > 0);
				$submit.controlEnable(totalPax > 0);
			});

			if ($jp.find('span.hid-state input').val() != $region.val()) {
				getOrigins();
			}

			if ($jp.find('span.hid-origin input').val() != $origin.val()) {
				getDests();
			}

			getDates();
			updateEnable();
		});
		//end journey planner

		//control style initialisation
		function applyDisabledStyle() {
			$('input,select').controlEnable();
		}
		if (typeof (Sys) != 'undefined') {
			Sys.WebForms.PageRequestManager.getInstance().add_endRequest(applyDisabledStyle);
		}
		applyDisabledStyle();

		//end document.ready
	});
})(jQuery);
//banners (banners.js)
(function (a, b) { a(function () { a(".mb-banner").each(function () { function i() { var b = a('<div class="banner-status"></div>'); d = a('<span class="banner-status-text"></span>'); b.append(d).append(a('<a href="#" class="banner-button banner-prv">Previous</a>').click(function () { l(-1) })).append(a('<a href="#" class="banner-button banner-play">Play</a>').click(j)).append(a('<a href="#" class="banner-button banner-nxt">Next</a>').click(function () { l(1) })); c.append(a('<div class="banner-back">&#160;</div>')).append(a('<div class="banner-curves banner-curves-tl">&#160;</div><div class="banner-curves banner-curves-tr">&#160;</div><div class="banner-curves banner-curves-bl">&#160;</div><div class="banner-curves banner-curves-br">&#160;</div>')).append(b) } function j() { a(this).toggleClass("banner-pause"); h = !h; if (!h) { g = setTimeout(l, 2e3) } else { clearInterval(g) } } function k() { d.html(f + 1 + " of " + e.length) } function l(a) { clearInterval(g); if (a == b) { a = 1 } e[f].fadeOut(400); f += a; if (f > e.length - 1) { f = 0 } if (f < 0) { f = e.length - 1 } e[f].fadeIn(400); k(); if (!h) { g = setTimeout(l, 5e3) } } var c = a(this); var d; var e = []; var f = 0; var g; var h = false; c.html(""); var m = c.attr("data-banner-spec"); a.get(m, function (b) { var d = a(b); d.find("image").each(function () { var b = a(this); var d = a('<div class="banner-page" style="display:none; position:absolute; top:0; left:0;"><a href="' + b.attr("link") + '" target="' + b.attr("target") + '"><img src="' + b.attr("src") + '" alt=""/></a></div>'); e.push(d); c.append(d) }); if (e.length > 0) { e[f].show() } if (e.length > 1) { g = setTimeout(l, 5e3); i(); k() } }) }) }) })(jQuery);
//language select (language.js)
(function (a, b) { a(function () { function d() { if (c != null) { e(c) } var d = a(this).parent().find("div.lang"); if (d.length == 0) { return true } else { c = d; d.eq(0).show().find("ul").slideDown(); b = setTimeout(function () { e(d) }, 5e3); return false } } function e(a) { a.find("ul").slideUp(200, function () { a.hide() }); c = null } var b = null; var c = null; a("a.flag-icon").click(d); a("div.lang").mouseleave(function () { var c = a(this); b = setTimeout(function () { e(c) }, 500) }).mouseenter(function () { clearTimeout(b) }) }) })(jQuery);
/* jQuery lightweight Tooltip */
(function (e, t) { e.fn.lwtooltip = function (n) { var r = { xoffset: -10, yoffset: -10, classname: "ui_tooltip", anchor: "bl" }; if (n) { e.extend(r, n) } return this.on("mouseover", function (n) { if (this.tt === t || this.tt === null) { var i = e(this).find(".tip"); this.tt = e("<div/>").addClass(r.classname).css("position", "absolute").html(i.html()).addClass(i.attr("class")).hide().appendTo("body").fadeIn() } }).on("mouseout", function () { if (this.tt !== t && this.tt !== null) { this.tt.remove(); this.tt = null } }).on("mousemove", function (e) { if (this.tt !== t && this.tt !== null) { var n = r.xoffset; var i = r.yoffset; switch (r.anchor) { case "tl": break; case "br": n -= this.tt.width(); i -= this.tt.height(); break; case "tr": n -= this.tt.width(); break; default: case "bl": i -= this.tt.height() } this.tt.offset({ top: e.pageY + i, left: e.pageX + n }) } }) } })(jQuery);
