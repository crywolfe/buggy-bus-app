/*
 *
 * jquery.lib.js
 * requires juery.js (written on version 1.3.2)
 */
 
	var $j = jQuery.noConflict();
 
	$j(document).ready(function() {
		styleCmsOutput();
		initExternalLinks();
		initPaginationNumbering();
		setPrintDocumentListener();
	});

	/* */
	function initExternalLinks() {
	    var links = $j('a.external');
	    setExternalLinkListeners(links);
	    var linksFooter3 = $j('div.column1_3 a')
	    setExternalLinkListeners(linksFooter3);
	    var linksFooter4 = $j('div.column1_4 a')
	    setExternalLinkListeners(linksFooter4);
	    return false;
	}

/* */
	function setExternalLinkListeners(links) {
		$j(links).click(function() {
			window.open($j(this).attr("href"));
			
			return false;
		});
	}

/* */
	function initPaginationNumbering() {
		$j('ul.pagination li:first').addClass("first");
	}

/* */
	function setPrintDocumentListener() {
		$j('#printdoc').click(function() {
			print();
		});		
	}

/* */
	function styleCmsOutput() {
		var cmsOutput = $j('div[xmlns]');
		
		cmsOutput.each(function() {
			$j(this).addClass("cms_output");
		});
	}
	/* */
	function catchEnterOnLoginForm() {
        $j()
       }

	(function ($) {
		$(function () {
      if (typeof (Sys) != 'undefined') {
       	Sys.WebForms.PageRequestManager.getInstance().add_endRequest(styleCmsOutput);
      }
      styleCmsOutput();
			});
	})(jQuery);