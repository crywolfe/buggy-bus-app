


    /****** Accordian ******/

jQuery(document).ready(function (jQuery) {
    //jQuery('.accordion .accord_body').hide();
    jQuery('.contact_options .accord_body').hide();
    jQuery('.accordion .accord_head, .contact_options .accord_head').click(function (e) {
        e.preventDefault();
        if (jQuery(this).hasClass('selected')) {
            jQuery(this).removeClass('selected');
            jQuery(this).next().slideUp();
        } else {
            jQuery('.accordion .accord_head').removeClass('selected');
            jQuery(this).addClass('selected');
            jQuery('.accordion .accord_body').slideUp();
            jQuery(this).next().slideDown();
        }
    });

});

jQuery(function () {
    var input = jQuery('.top_login input[type=text], .question_box textarea, .yellow_curvy_box textarea');

    input.focus(function () {
        jQuery(this).val('');
    }).blur(function () {
        var el = jQuery(this);
        if (el.val() == '')
            el.val(el.attr('title'));
    });
});

    


    /****** Accordian ENDS ******/
