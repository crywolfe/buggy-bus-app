(function ($) {
    $(function () {
        $('a.popuplink').click(function () {
            var url = this.href;
            var content = jQuery('<div style="display:hidden" title="' + this.title + '"></div>').appendTo('body');
            // load remote content
            content.load(
        url,
        { 'nostyle': 'true' },
        function () {
        	content.dialog({ width: 500, modal: true, resizable: false });
        }
    );
            return false;
        });
    });
          //close when background is clicked
		$('document').on('click', '.ui-widget-overlay', function () { $('.ui-dialog-content').dialog('close'); });
})(jQuery);