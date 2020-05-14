<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<div id="sidebar-wrapper">

<div class="cartleftsb">
			<ul class="leftcartandlogin">
			    <% var cus = Context.GetCachedCustomer(); %>
			    
                <% var cartCount = Context.CartCount(); %>
			    <li class="leftviewcart"><a href="<%=Url.Action("Cart", "Customer") %>">View Cart<%=cartCount > 0 ? ": <strong style=\"color: #CC0000;\">" + cartCount + "</strong>" : "" %></a></li>
<% if (cus != null) { %>
                <li class="leftsignedin">Hello, <%:cus.DefaultContact.FirstName %></li>
                <% } else { %>
                <li class="leftnotsignedin"><a href="<%:Url.Action("sign-in", "customer", new { areas=ViewBag.Area, redirect=Request.Url }) %>">Sign In</a></li>
                <% } %>
			    <% if (cus != null) { %>
			    <li class="leftsignout"><a href="<%:Url.Action("sign-out", "Customer", new { redirect=Request.Url }) %>">Sign Out</a></li>
                <% } %>
                <%/* 
			    <li class="leftblog"><a href="https://www.balconette.co.uk/blog/">Blog</a></li>
                 */%>
		    </ul>
			<div align="left" style="text-align:center;margin: 0 auto;">
    <table border="0">
        <tbody><tr><td>
            <a rel="nofollow" title="Verified by Visa - Learn more" href="javascript:void(0);" onclick="open('/images/vbv_learn_more_text.jpg','view','height=450,width=550');"><img src="/images/vbv_learn_more.gif" style="border-width:0px;border: 0; width: 60px; height: 48px;"></a>
        </td><td>
            <img src="/images/mcsc_learn_more.gif" style="border-width:0px;border: 0; width: 60px; height: 48px;">
            </td><td>
            <a title="100% Money Back Guarantee - Learn more" href="/general/money-back-guarantee"><img src="/images/money-back-guarantee-22414.png" style="border: 0; width: 64px; height: 48px;"></a>
            </td></tr>
    </tbody></table>
</div>
			</div>
			<div style="margin: 40px 0;text-align: left;">
	<a class="btn612" href="/customer/request-brochure?areas=juliet">Request Brochure&nbsp;&gt;</a>
	</div>
			
			<script type="text/javascript">
        $(document).ready(function() {
            $('#nav li a img').click(function(e) {
            var _this = $(this);
            var countContainer = $(this).parent().parent().find('.count');
            $('#nav li a img').each(function(index) {
            if (!countContainer.is(':visible')) {
            $(this).parent().parent().find('.count').slideUp(800);
            }
            })

            $('#nav li a img').attr('src','/navelements/insert.png');

            if($(this).attr('src') == '/navelements/insert.png') {
            e.preventDefault();
            if (!countContainer.is(':visible')) {

            _this.attr('src','/navelements/remove.jpg');
            $(this).parent().parent().find('.count').slideDown(800).show();
            } else {
                $(this).parent().parent().find('.count').slideUp(800);
            }
            }
        });
        });
        </script>
		
                        
							   
   <div style="display: block;" align="center">
    <div class="leftnav"> 
    <ul id="nav">
        <li><a id="im1" href="/glass-balustrade/homepage"><img src="/navelements/insert.png" alt="Glass Balustrade" id="1" align="left">Glass Balustrade</a>
            <ul class="count" style="display: none;">
                <li><a href="/glass-balustrade/balcony1-balustrade">Circular Handrail Systems</a></li>
                <li><a href="/glass-balustrade/balcony2-balustrade">Aerofoil Handrail Systems</a></li>				
				<li><a href="/glass-balustrade/SG10-frameless-balustrade">Frameless Balustrades</a></li>
				<li><a href="/glass-balustrade/sg10-semi-frameless-balustrade">Semi Frameless</a></li>
				<li><a href="/glass-balustrade/privacy-screens">Privacy Screens</a></li>
		        <li><a href="/glass-balustrade/glass-balustrades-for-stairs">Stair Glass Balustrades</a></li>
		        <li><a href="/glass-balustrade/glass-gates">Glass Gates</a></li>
				<li><a href="/glass-balustrade/quote">Online Quote</a></li>
				<li><a href="/glass-balustrade/how-to-install-glass-balustrades">Installation guides</a></li>
				<li><a href="/glass-balustrade/technical-details">Tech Specs</a></li>
                <li><a href="/glass-balustrade/photos">Picture Gallery</a></li>
                <li><a href="/glass-balustrade/case-studies">Project Library</a></li>
				<li><a href="/glass-balustrade/articles">Articles</a></li>
				<li><a href="/glass-balustrade/faqs">Balustrades FAQs</a></li>
				<li><a href="/glass-balustrade/trade-customers">Trade & Professionals</a></li>
            </ul>
        </li>
        <li><a id="im2" href="/juliet-balcony/homepage"><img src="/navelements/insert.png" alt="Juliet Balcony" id="2" align="left">Juliet Balcony</a>
            <ul class="count" style="display: none;">
                <li><a href="/juliet-balcony/quote-custom">Custom Sized Juliets</a></li>
				<li><a href="/juliet-balcony/standard-model/1500?type=1&color=3&glass=1">Standard Sized Juliets</a></li>
				<li><a href="/juliet-balcony/types">Types of Juliette Balconies</a></li>
                <li><a href="/juliet-balcony/how-to-install-juliet-glass-balconies">Installation guides</a></li>
				<li><a href="/juliet-balcony/technical-details">Tech Specs</a></li>
                <li><a href="/juliet-balcony/photos">Picture Gallery</a></li>
                <li><a href="/juliet-balcony/case-studies">Project Library</a></li>
				<li><a href="/juliet-balcony/articles">Articles</a></li>
				<li><a href="/juliet-balcony/faqs">Juliet FAQs</a></li>
				<li><a href="/juliet-balcony/trade-and-professional-customers">Trade & Professionals</a></li>
            </ul>
        </li>
        <li><a id="im3" href="/curved-doors/homepage"><img src="/navelements/insert.png" alt="Curved Glass Doors" id="3" align="left">Curved Patio Doors</a>
            <ul class="count" style="display: none;">
                <li><a href="/curved-doors/technical-details">Tech Specs</a></li>
				<li><a href="/curved-doors/door-arrangement-options">Configuration Options</a></li>
				<li><a href="/curved-doors/how-to-install-curved-doors">Installation guides</a></li>
                <li><a href="/curved-doors/quote">Online price calculator</a></li>
                <li><a href="/curved-doors/photos">Picture Gallery</a></li>
                <li><a href="/curved-doors/case-studies">Project Library</a></li>				
				<li><a href="/curved-doors/articles">Articles</a></li>
				<li><a href="/curved-doors/faqs">Curved Doors FAQs</a></li>
				<li><a href="/curved-doors/trade-customers">Trade & Professionals</a></li>
            </ul>
        </li>
		<li><a id="im4" href="/self-cleaning-glass/homepage"><img src="/navelements/insert.png" alt="Self Cleaning Glass" id="4" align="left">Self Cleaning Glass</a>
            <ul class="count" style="display: none;">
                <li><a href="/self-cleaning-glass/shop">Buy Online</a></li>
				<li><a href="/self-cleaning-glass/products">BalcoNano Products</a></li>
				<li><a href="/self-cleaning-glass/applications">Balconano Applications</a></li>
                <li><a href="/self-cleaning-glass/glass-coating-how-it-works">How It Works</a></li>
                <li><a href="/self-cleaning-glass/application-instructions">Application Instructions</a></li>
				<li><a href="/self-cleaning-glass/frequently-asked-questions">Balconano FAQs</a></li>
                <li><a href="/self-cleaning-glass/trade-and-distributors">Trade and Distributors</a></li>                
            </ul>
        </li>
		<li><a id="im5" href="/composite-decking/homepage"><img src="/navelements/insert.png" alt="Composite Decking" id="5" align="left">Composite Decking</a>
            <ul class="count" style="display: none;">
				<li><a href="/composite-decking/shop">Buy Online</a></li>
                <li><a href="/composite-decking/what-we-offer">Get a Quote</a></li>
				<li><a href="/composite-decking/technical-details">Tech Specs</a></li>
				<li><a href="/composite-decking/textures-and-finishes">Textures and Finishes</a></li>
				<li><a href="/composite-decking/composite-decking-accessories">Decking Accessories</a></li>
                <li><a href="/composite-decking/applications">Decking Applications</a></li>
                <li><a href="/composite-decking/photos">Picture Gallery</a></li>				
            </ul>
        </li>
		<li><a id="im7" href="/customer/request-brochure?areas=juliet"><img src="/navelements/insert.png" alt="Request Brochure" id="7" align="left">Request Brochure</a></li>
		<li><a id="im8" href="/general/contact-us"><img src="/navelements/insert.png" alt="Contact Us" id="8" align="left">Contact Us</a></li>
  </ul>
    </div>
    </div>

			<%/* Grand Design Live Banner */%>
			<div id="gdliveleftbanner" class="sidebar-item">
			<p style="padding: 40px 0;clear: both;"><a href="/customer/request-tickets"><img alt="Grand Designs Live" class="img-shadow" src="/images/GDL_NEC_2016_composite_print-1.jpg" style="width: 190px; height: auto;"></a></p>			
            </div>
			<%/* */%>

		<div class="sidebar-items-wrapper">

			<%/* Open House Event Banner 
			<div class="sidebar-item">
			<h3 style="font-weight:bold;margin-bottom:20px;"><a style="color:#960000;text-decoration: none;font-size: 18px;" href="/general/rsvp">Open House Event</a></h3>
			<a href="/general/rsvp" style="text-decoration: none !important;" title="RSVP - Balconette's Open House Event">
                                    <img alt="RSVP - Balconette's Open House Event" src="/images/openhouse082018.jpg" style="max-width: 220px;"><br>
                                </a>
			</div>
			*/%>

			<div id="photo-gallery" class="sidebar-item">
                <h3 style="font-weight:bold;margin-bottom:20px;">
                    <a style="color:#960000;text-decoration: none;font-size: 18px;" href="https://www.balconette.co.uk/general/gallery">Photo Gallery</a>
                </h3>
                <a href="https://www.balconette.co.uk/general/gallery" style="text-decoration: none !important;" title="Visit Photo Gallery">
                    <img alt="Balconette Photo Gallery" src="/images/photo-galleries-2.2020.png" style="max-width: 220px;"><br>
                </a>
            </div>

            <div id="geo-coverage-banner-sidebar" class="sidebar-item">
                <a href="/general/geo-coverage">
                    <img src="/content/uploads/be4c6f34-561b-48cd-8d14-f9a3f76eccf3/glass-balustrades-in-UK.jpg" alt="Glass Balustrades in UK" title="Glass Balustrades in UK" style="width: 100%; height: auto; max-width: 220px;">
                </a>
            </div>
			
			<div id="visit-installation" class="sidebar-item">
			    <h3 style="font-weight:bold;margin-bottom:20px;"><a style="color:#960000;text-decoration: none;font-size: 18px;" href="/general/ambassadors-on-the-website">Visit an installation</a></h3>
			    <a href="/general/ambassadors-on-the-website" style="text-decoration: none !important;" title="Visit a Balcony installation">
                    <img alt="Balcony Systems brochure" src="/images/ambassadors1117.png" style="max-width: 220px;"><br>
                </a>
			</div>

			<div id="requestbrochure" class="sidebar-item">
                <h3 style="font-weight:bold;margin-bottom:20px;"><a style="color:#960000;text-decoration: none;font-size: 18px;" href="/customer/request-brochure?areas=balustrades">Request Brochure</a></h3>
                <a href="/customer/request-brochure?areas=balustrades" style="text-decoration: none !important;" title="Request brochure">
                    <img alt="Balcony Systems brochure" src="/images/brochure-0414.png"><br>
                </a>
            </div>

			<!--<div id="sidebar-reviews" class="sidebar-item">
                <h3 style="font-weight:bold;"><a style="color:#960000;text-decoration: none;font-size: 18px;" href="/general/reviews">Reviews</a></h3>
                <% Html.RenderPartial("CustomerReviews", new ViewDataDictionary { { "Area", ViewBag.Area } }); %>
            </div>-->

            <div id="sidebar-reviews" class="sidebar-item" style="padding-bottom: 0 !important;">
                <a href="/general/reviews" style="text-decoration: none;"><h3 style="color:#960000;margin: 0;font-size: 18px;">Reviews</h3></a>
                <div id="feefo-service-review-carousel-widgetId" class="feefo-review-carousel-widget-service"></div>
            </div>

            <div id="sidebar-news" class="sidebar-item">
                <h3 style="font-weight:bold;margin-bottom:20px;"><a style="color:#960000;text-decoration: none;font-size: 18px;" href="https://blog.balconette.co.uk">News</a></h3>
                <% Html.RenderPartial("News"); %>
			</div>

			<div id="sidebar-projects" class="sidebar-item">
                                <h3 style="font-weight:bold;margin-bottom:20px;color:#960000;text-decoration: none;font-size: 18px;"><a style="color:#960000;text-decoration: none;font-size: 18px;" href="/general/balcony-projects">Projects</a></h3>
                                
                                    <a href="/juliet-balcony/case-studies/juliet-loft-balcony" style="text-decoration: none !important;color:#404040 !important;" title="Loft Juliet Balcony in London">
									<h4 style="font-weight:normal;margin-bottom:14px;text-decoration: none;font-size: 16px;color:#404040;">Loft Juliet Balcony in London</h4>
                                    <img alt="Loft Juliet Balcony in London" src="/content/uploads/f691b809-0898-4c22-a46e-5ecf9afdea31/436_juliet-balcony.jpg" width="200"><br>
									<p style="text-align:justify;margin-top:15px;">
									Balcony Systems Solutions Ltd supplied a clear glass Juliet balcony for a South London family whose major home extension project was featured on Channel 4's Double Your House for Half the Money with Sarah Beeny. &gt;&gt;
									</p>
									</a>
									
								    <a href="/glass-balustrade/case-studies/clear-glass-keeps-the-garden-as-open-as-possible" style="text-decoration: none !important;color:#404040 !important;" title="Frameless Glass Balustrades">
									<h4 style="font-weight:normal;margin-bottom:14px;margin-top:30px;text-decoration: none;font-size: 16px;color:#404040;">Frameless Glass Balustrade</h4>
                                    <img alt="Frameless Glass Balustrade" src="/content/uploads/9a8b5dd3-2c68-457d-b102-16a3b6ca88d3/4.jpg" width="200"><br>
									<p style="text-align:justify;margin-top:15px;">
									This low-maintenance frameless glass balustrade system uses nearly eight metres of SG12 21.5mm toughened laminated glass. The need for cleaning is reduced further with the application of BalcoNano self-cleaning glass coating – an ideal choice for an outdoor balustrade. &gt;&gt;
									</p>
                                </a>
								
								<a href="/curved-doors/case-studies/tate-st-ives-curved-doors" style="text-decoration: none !important;color:#404040 !important;" title="Curved Glass Doors">
									<h4 style="font-weight:normal;margin-bottom:14px;margin-top:30px;text-decoration: none;font-size: 16px;color:#404040;">So Much More Than a Curved Glass Door</h4>
                                    <img alt="Curved Glass Door" src="/content/uploads/fec070b3-bd26-4c19-ba35-4be02a24ce73/tate_st_ives_clore_sky_out_(c)_tate.-photo_grahamgaunt_01.jpg" width="200"><br>
									<p style="text-align:justify;margin-top:15px;">
									Visitors to a new cliff-face extension at the Tate St Ives art gallery in Cornwall are brought closer to the Atlantic Ocean through an impressive curved sliding glass door. &gt;&gt;
									</p>
                                </a>
                                                            
                   </div>

        </div>

        <!---->
        <!---->
        <!---->
        <!---->

            <%/* should be feched from blog see old website homepage
			<div id="news">
				<h2>News</h2>
				<div class="news-item">
					<h3>Juliette Balcony</h3>
					<p class="date">16 September 2012</p>
					<p>Really secure from perspective of children running about and being glazed gives feel of there being no obstruction - we have lovely countryside...</p>
					<p><a href="#">READ MORE</a></p>
				</div>
				<div class="news-item">
					<h3>Juliette Balcony</h3>
					<p class="date">30 September 2012</p>
					<p>Stunning product, good quality, great price. I put plenty of research into my juliette balcony purchase and chose Balcony Systems as they came...</p>
					<p><a href="#">READ MORE</a></p>
				</div>
			</div>
            */%>

</div>

<script>
    $(document).ready(function(){
        var sidebarItemsWrapper = $('.sidebar-items-wrapper').clone(true, true);

        $('#footerContainer').prepend(sidebarItemsWrapper);

        function defineSidebarVisibility() {
            var screenW = $(window).width();
            if (screenW < 660) {
                $('#footerContainer .sidebar-items-wrapper').show();
            } else {
                $('#footerContainer .sidebar-items-wrapper').hide();
            }
        }

        function toggleReviewsWidget() {
            var screenW = $(window).width();
            $('#sidebar-wrapper #feefo-service-review-carousel-widgetId').remove();
            $('#footerContainer #feefo-service-review-carousel-widgetId').remove();
            if (screenW < 660) {
                $('#footerContainer #sidebar-reviews').append('<div id="feefo-service-review-carousel-widgetId" class="feefo-review-carousel-widget-service"></div>');
            } else {
                $('#sidebar-wrapper #sidebar-reviews').append('<div id="feefo-service-review-carousel-widgetId" class="feefo-review-carousel-widget-service"></div>');
            }
        }

        defineSidebarVisibility();
        toggleReviewsWidget();

        $(window).resize(function() {
            defineSidebarVisibility();
        });

    });
</script>
