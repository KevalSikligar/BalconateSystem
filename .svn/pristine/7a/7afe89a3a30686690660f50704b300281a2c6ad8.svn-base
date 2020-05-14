$(document).ready(function(){

    $('#menu').slicknav();

    var navHtml =
        '<a href="/" style="margin: 3px 5px 0 1px; float: left; display: inline-block;"><img src="/images/logo-transparent.png" alt="Glass Balustrades, Juliette Balconies &amp; Railings - Balcony Systems" id="logo-nav" /></a>' +
        '<div style="display: inline-block; position: absolute; right: 60px;">' +
            '<div style="display: inline-block; float: left; line-height: 38px; color: white; font-size: 16px;">' +
                '<span>' +
                    '<a href="/customer/sign-in?areas=general" style="text-decoration: underline; display: inline-block;">Sign In</a>' +
                '</span>' +
                '<span style="margin: 0 10px;">&#8226;</span>' +
                '<span style="margin-right: 10px">' +
                    '<a href="tel://01342410411">Call</a>' +
                '</span>' +
            '</div>' +
            '<a href="tel://01342410411" style="display: inline-block; margin: 2px 10px 0 0;">' +
                '<img src="/images/call.png" />' +
            '</a>' +
        '</div>';

    $('.slicknav_menu').prepend(navHtml);

    $('.slicknav_menu > ul.slicknav_nav').wrap('<div class="slicknav_nav_container" style="clear: both; width: 100%; display: none; overflow: auto; max-height: 550px;"></div>');

    var mobileMenuHtml =
        '<div class="slicknav_nav_right" style="width: 50%; display: inline-block; color: white; font-size: 16px;">' +
            '<a href="/customer/cart" style="display: table; margin: 30px auto 0 auto; text-align: center;">' +
                '<p id="slicknav_nav_username" style="margin-top: 0; text-align: center;"></p>' +
                '<img src="/images/cart-transparent.png" style="width: 44px;" />' +
                '<p style="margin-top: 8px; text-align: center;">View Cart</p>' +
            '</a>' +
            '<a href="/juliet-balcony/standard-models" style="margin-top: 40px; display: block; text-align: center;">Juliet Shop&nbsp;&nbsp;<span style="font-size: 11px;">►</span></a>' +
            '<a href="/glass-balustrade/quote" style="margin-top: 15px; display: block; text-align: center;">Balustrades Quote&nbsp;&nbsp;<span style="font-size: 11px;">►</span></a>' +
            '<a href="/customer/request-brochure?areas=juliet" style="margin-top: 40px; display: block; text-align: center;">' +
                '<div style="margin: 0 auto; display: inline-block; width: 140px;">' +
                    '<img src="/images/brochure-0414.png" style="width: 44px; display: inline-block; float: left;" />' +
                    '<span style="margin: 5px 10px;">Brochure</span>' +
                '</div>' +
            '</a>' +
            '<a href="/customer/call-me-back?areas=general" class="fancybox-spc-sz fancybox.iframe" data-fancybox-width="340" style="margin-top: 40px; display: block; text-align: center;">' +
                '<div style="margin: 0 auto; display: inline-block; width: 140px;">' +
                    '<img src="/images/talk_to_specialist_white.png" style="width: 44px; height: 44px !important; display: inline-block; float: left;" />' +
                    '<span style="margin: 5px 10px;">Talk to a &nbsp; specialist</span>' +
                '</div>' +
            '</a>' +
        '</div>';
    $('.slicknav_nav_container').append(mobileMenuHtml);

    var brandsHtml =
        '<div class="slicknav_nav_brands_container" style="min-height: 44px; height: auto; width: 100%; margin-top: 30px; margin-bottom: 15px; text-align: center;">' +
            '<div class="slicknav_nav_brands_container_inner" style="width: auto; min-width:346px; height: auto; display: inline-block;">' +
                '<img src="/images/money_back_guarantee.png" style="height: 44px; max-height: 44px; width: auto; display: inline-block; float: left; margin: 0 15px;" />' +
                '<img src="/images/mastercard.png" style="height: 37px; max-height: 37px; width: auto; display: inline-block; float: left; margin: 0 15px; padding-top: 15px;" />' +
                '<img src="/images/visa.png" style="height: 37px; max-height: 37px; width: auto; display: inline-block; float: left; margin: 0 15px; padding-top: 15px;" />' +
                '<img src="/images/paypal.png" style="height: 37px; max-height: 37px; width: auto; display: inline-block; float: left; margin: 0 15px; padding-top: 15px;" />' +
            '</div>' +
        '</div>';
    $('.slicknav_nav_container').append('<div style="clear: both;"></div>');
    $('.slicknav_nav_container').append(brandsHtml);

    $('.slicknav_btn').on('click', function(){
        if($(this).hasClass('slicknav_open')){
            $('.slicknav_nav_container').show();
            $('.slicknav_nav_container').css('display', 'inline-block');
        } else {
            $('.slicknav_nav_container').hide();
        }
    });

    var username = $('.cartleftsb ul.leftcartandlogin li.leftsignedin').text() || '';
    $('#slicknav_nav_username').text(username);

});
