jQuery.validator.addMethod('sameas', function (value, element, params) {
    var otherprop = $(element).attr('data-val-sameas-otherprop');
    var otherval = $(element).parents('form').find('input[name$="' + otherprop + '"]').val();
    var res = value == otherval;
    return res;
}, '');
jQuery.validator.addMethod('musttick', function (value, element, params) {
    return element.checked;
}, '');
jQuery.validator.addMethod('specrange', function (value, element, params) {
    var minprop = $(element).attr('data-val-specrange-minprop');
    var maxprop = $(element).attr('data-val-specrange-maxprop');
    var minval = parseFloat($(element).parents('form').find('input[name$="' + minprop + '"]').val());
    var maxval = parseFloat($(element).parents('form').find('input[name$="' + maxprop + '"]').val());
    var val = parseFloat(value);
    var res = minval <= val && val <= maxval;
    return res;
}, '');

jQuery.validator.unobtrusive.adapters.add('sameas', {}, function (options) {
    options.rules['sameas'] = true;
    options.messages['sameas'] = options.message;
});
jQuery.validator.unobtrusive.adapters.add('musttick', {}, function (options) {
    options.rules['musttick'] = true;
    options.messages['musttick'] = options.message;
});
jQuery.validator.unobtrusive.adapters.add('specrange', ["minprop", "maxprop"], function (options) {
    options.rules['specrange'] = true;
    options.messages['specrange'] = function (p, element) {
        element = $(element);
        var minprop = element.attr('data-val-specrange-minprop');
        var maxprop = element.attr('data-val-specrange-maxprop');
        var minval = parseFloat(element.parents('form').find('input[name$="' + minprop + '"]').val());
        var maxval = parseFloat(element.parents('form').find('input[name$="' + maxprop + '"]').val());
        return $.format(options.message, minval, maxval);
    };
});


String.prototype.trim = function() {
    return this.replace(/^\s+|\s+$/g, "");
};
String.prototype.ltrim = function() {
    return this.replace(/^\s+/, "");
};
String.prototype.rtrim = function() {
    return this.replace(/\s+$/, "");
};
String.prototype.fromJsonDate = function () {
    return new Date(parseInt(this.replace("/Date(", "").replace(")/", ""), 10));
};

function dialog(body, closeable) {
    var dialog = $("#fancyDialog");
    var bodyDiv = dialog.find(".body");
    bodyDiv.html(body);
    closeable = closeable != undefined ? closeable : true;
    $.fancybox(dialog, {
        modal: !closeable,
        closeBtn: closeable,
        maxWidth: 800,
        maxHeight: 600,
        fitToView: true,
        width: '70%',
        height: '70%',
        autoSize: true,
        closeClick: false,
        openEffect: 'none',
        closeEffect: 'none'
    });
}

function dialogRedirect(body, closeable,r_url) {
    var dialog = $("#fancyDialog");
    var bodyDiv = dialog.find(".body");
    bodyDiv.html(body);
    closeable = closeable != undefined ? closeable : true;
    $.fancybox(dialog, {
        modal: !closeable,
        closeBtn: closeable,
        maxWidth: 800,
        maxHeight: 600,
        fitToView: true,
        width: '70%',
        height: '70%',
        autoSize: true,
        closeClick: false,
        openEffect: 'none',
        closeEffect: 'none',
		afterClose: function() {
        window.location = r_url;
      }
    });
}

function onlyNumbers(selector) {
    $(selector).on("keypress", function (e) {
        var charCode = (e.keyCode ? e.keyCode : e.which);
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            e.preventDefault();
            return false;
        }
        return true;
    });
}

//DOCUMENT READY
$(document).ready(function () {

    $(".fancybox").fancybox({
        autosize: true,
        fitToView: true,
        closeClick: false,
        openEffect: 'none',
        closeEffect: 'none',
        helpers: {
            overlay: {
                locked: false
            }
        }
    });

    $(".fancybox-spc-sz").fancybox({
        maxWidth: 800,
        maxHeight: 600,
        fitToView: false,
        width: '70%',
        height: '70%',
        autoSize: false,
        closeClick: false,
        openEffect: 'none',
        closeEffect: 'none',
        beforeLoad: function () {
            this.width = parseInt(this.element.data('fancybox-width'));
            this.height = parseInt(this.element.data('fancybox-height'));
        },
        beforeShow: function () {

        },
        helpers: {
            overlay: {
                locked: false
            }
        }
    });

	/* Styling the file upload button in the forms */
	var wrapper = $('<div/>').css({height:0,width:0,'overflow':'hidden'});
	var fileInput = $(':file').wrap(wrapper);

    fileInput.change(function() {
        $this = $(this);
        $('#file').text("File attached");
    });

	$('#file').click(function(){
		fileInput.click();
	}).show();


    /* COOKIE PANEL */
    $("#cookie-panel a.close").click(function () {
        $("#cookie-panel").hide();
        $.ajax({
            type: 'POST',
            url: '/account/allow-cookies',
            cache: false
        });
    });

    $("#cookie-panel a.moreinfo").fancybox({
        maxWidth: 800,
        maxHeight: 600,
        fitToView: false,
        width: '70%',
        height: '70%',
        autoSize: false,
        closeClick: false,
        openEffect: 'none',
        closeEffect: 'none'
    });

    var sf = $('.sf-menu');
    if (sf.length > 0) {
        sf.superfish({
            pathLevels: 3,
            autoArrows: false,
            speed: 1, /* Or 'slow' for a fade - check with Isaac */
            speedOut: 1, /* Or 'slow' for a fade - check with Isaac */
            delay: 750,
        });
    }

    $('.noclipboard').on("cut copy paste", function (e) {
        e.preventDefault();
        return false;
    });

    $(".only-numbers").each(function () {
        onlyNumbers(this);
    });

    $("form").submit(function () {
        preventShowingButtons = false;
        var t = $(this);
        var valid = t.valid();
        if (valid) {
            var btn = t.find('input[type|="submit"], .submit');
            btn.hide();

            var progbtn = t.find('.prog1');
            if (progbtn.length > 0) {
                $("<div/>")
                    .addClass("prog prog1")
                    .prop("title", "Please wait ...")
                    .insertAfter(progbtn);
            }
        }
        return valid;
    });

    var preventShowingButtons = false;
    $(document).ajaxComplete(function (event, xhr, ajaxOptions) {
        if (preventShowingButtons) return;
        var frm = jQuery.data(xhr, "frm");
        if (frm) {
            $(frm).find('input[type|="submit"], .submit').show();
            $(frm).find('div.prog.prog1').remove();
        }
    });

    var oldJsonConverter = jQuery.ajaxSettings.converters['text json'];

    jQuery.ajaxSettings.converters['text json'] = function (data) {
        var res = oldJsonConverter(data);
        if (res.__kind__) {
            if (res.__kind__ == 1) { //dialog
                dialog(res.body, res.closeable);
			} else if (res.__kind__ == 1302) { //dialog and redirect
                dialogRedirect(res.body, res.closeable, res.location);


            } else if (res.__kind__ == 302) { //redirect
                window.location = res.location;
                preventShowingButtons = true;
            }
        }
        return res;
    };

    $(document).ajaxError(function (event, xhr, ajaxSettings, thrownError) {
        var txt = xhr.responseText;
        if (txt && txt != '') {
            dialog(xhr.responseText);
        }
    });

    $(".customer-reviews-scroller").marquee({ yScroll: "bottom", showSpeed: 850, scrollSpeed: 10, pauseSpeed: 8000 });
    $(".news-scroller").marquee({ yScroll: "bottom", showSpeed: 850, scrollSpeed: 10, pauseSpeed: 8000 });

    // --------------------------------------------------------------------------------------------------------

    var screenWidth = $(window).width();
    if (screenWidth < 660) {
        $('.pdfs p').each(function(){
            if (!$(this).text().trim()) $(this).remove();
        });
    }


});



//WINDOW LOAD
$(window).on('load', function () {
	if ($.fn.nivoSlider) {
		/* Main slider */
		$('#slider').nivoSlider({
		    effect: 'fade',
			controlNav: false,
			manualAdvance: false,
			pauseTime: 5000
		});
		/* Side slider */
		$('#slider-sidebar').nivoSlider({
			effect: 'fade',
			directionNav: true,
			manualAdvance: true,
			controlNav: false,
		});

		var btn = $(".theme-default .nivoSlider  a.nivo-nextNav");
	    $(".theme-default .nivoSlider").on("click", function () {
	        btn.click();
	    });
	}
});




