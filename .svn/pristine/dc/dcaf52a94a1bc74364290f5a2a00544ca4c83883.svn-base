<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<StandardJulietteModel>" %>
<link href="../../Content/slider/css/lightslider.min.css" type="text/css" rel="stylesheet" />
<style>
    ul.lSPager.lSGallery img {
        height: 150px;
        max-height: 150px;
        min-height: 150px;
        width:100%;
    }

     #middle_wrap {
        display:block !important;
        margin: 0 auto;
        height: auto;
        clear: both;
    }

    #section_cell {
        vertical-align: bottom;
        text-align: center;
        padding-right: 5px;
        display: block !important;
        font-weight: bold;
        float: left;
        width: 15% !important
    }
   
    #thumbnailImgs {
        position: relative;
        min-width: 70% !important;
        display: block !important;
        float: left;
        padding: 0;
        vertical-align: top;
    }

    #next_cell {
        position: relative;
        float: left;
        vertical-align: top;
        padding-left: 20px;
        font-weight: bold;
        width: 5% !important;
        text-align: center;
    }

    @media(min-width:992px){
         #standard-juliet-model #sectionImage {
            margin-left: -60px !important;
        }
    }

    @media(min-width:768px) and (max-width:1199px){
         #thumbnailImgs {
            width: 55% !important;
            padding-top:19px;
         }
         #standard-juliet-model #sectionImage {
            width: initial;
            height: 402px;
        }
        #section_cell {
            width: 19% !important;
            padding-left: 15px;
        }
        ul.lSPager.lSGallery img {
            height: 130px;
            max-height: 130px;
            min-height: 115px;
            width: 100%;
        }
    }

    @media(max-width: 767px){
         #section_cell,#next_cell,#thumbnailImgs {
            float: none ;
            width: 100% !important;
        }
        .lSSlideOuter .lSGallery li, .lSSlideOuter .lightSlider>* {
            float: left;
            margin: 0;
        }
        ul.lSPager.lSGallery img {
            height: 80px;
            max-height: 80px;
            min-height: 80px;
            width:100%;
        }
        #thumbnailImgs img{
            margin: 0 !important
        }
    }

    li.clone.right, li.clone.left {
        float: left !important;
        margin-left: 0 !important;
    }
    .lSAction>a {
        width: 31px;
        height: 30px;
         opacity: 1 !important;
        -webkit-transition: opacity .35s linear 0s;
        transition: opacity .35s linear 0s;
        background-color: rgba(0,0,0,0.3);
        border-radius:50%;
    }
    .lSAction>.lSPrev {
        background-position: 1px -1px;
        left: 10px;
    }
    .lSAction>.lSNext {
        background-position: -34.4px -1px;
        right: 10px;
    }
</style>

<h1><%:Model.H1 %></h1>
<p class="toplinksp"><a href="/juliet-balcony/homepage" style="color:#666;">Juliet Balconies</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/juliet-balcony/technical-details" style="color:#666;">Tech Specs</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/juliet-balcony/how-to-install-juliet-glass-balconies" style="color:#666;">Installation</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/juliet-balcony/photos" style="color:#666;">Gallery</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/juliet-balcony/case-studies" style="color:#666;">Projects</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/juliet-balcony/articles" style="color:#666;">Articles</a></p>
<h2>Suitable for an opening width of up to <%=Model.OpenWidth %>mm</h2>
<!--<p style="margin: 20px 0 40px;">(Need a different size juliet? <a href="https://www.balconette.co.uk/juliet-balcony/standard-models">Click here</a>)</p>-->

<div id="type-and-color">
    <p>
        <label>
            <span class="num">1.</span>
            Choose Width: <abbr title="Pick the Juliet size from the list. Please note this will be the handrail size and must be a minimum of 260mm (26cm) larger than the opening width. Watch as the image below changes to the size you have chosen." rel="tooltip"><img class="qmarkinfo" src="/images/qmark1311.png" alt="Set Juliet width"></abbr>
        </label>
        <%:Html.TextBoxFor(m => m.StandardId, new { style="width: 100px" }) %>
		
		
    </p>        
    <p>
        <label>
            <span class="num">2.</span>
            Choose System: <abbr title="Choose from the 4 different system options available. You can see the section and 3D model change in the image below as you choose different options." rel="tooltip"><img class="qmarkinfo" src="/images/qmark1311.png" alt="Choose handrail type"></abbr>
        </label>
        <%:Html.TextBoxFor(m => m.TypeId, new { style="width: 300px" }) %>
		
	
    </p>
    <p>
        <label>
            <span class="num">3.</span>
            Choose Colour: <abbr title="Pick from a list of available colours for the metalwork. Watch as the Juliet image below changes to the colour you choose." rel="tooltip"><img class="qmarkinfo" src="/images/qmark1311.png" alt="Choose the handrail and fixings colour."></abbr>
        </label>
        <%:Html.TextBoxFor(m => m.ColorId, new { style="width: 160px" }) %>
		
    </p>
    <p>
        <label>
            <span class="num">4.</span>
            Choose Glass: <abbr title="Pick the glass type for your Juliet balcony from a list of available glass options." rel="tooltip"><img class="qmarkinfo" src="/images/qmark1311.png" alt="Choose the glass type."></abbr>
        </label>
        <%:Html.TextBoxFor(m => m.GlassId, new { style="width: 550px" }) %>
		
    </p>
</div>
<div id="middle_wrap" style="height:auto !important">
    <div id="section_cell">
        <div>Section</div>
        <img id="sectionImage" src="/images/juliettes/sections/<%=Model.TypeId %>.jpg" alt=" Section" /> 
    </div>
<%--    <div id="model_cell">
        <img id="modelImage" src="/images/juliettes/standards/med/<%=Model.TypeId %>/<%=Model.ColorId %>/<%=Model.StandardId %>.jpg" alt="<%:Model.H1 %>" />
    </div>--%>
    <div id="thumbnailImgs">
       <div  style="display:block !important;max-width:700px;">
            <ul id="slider">
        <%
            string Imgsrc;
            for (int counter = 0; counter < 10; counter++)
            {
                Imgsrc = string.Empty;
                Imgsrc = "/images/juliettes/standards/med/";
                Imgsrc += Model.TypeId + "/";
                Imgsrc += Model.ColorId + "/";
                if (counter == 0)
                {
                    Imgsrc += Model.StandardId + ".jpg";
                }
                else
                {
                    Imgsrc += Model.StandardId + "_" + counter + ".jpg";
                }
                if (System.IO.File.Exists(Server.MapPath(Imgsrc)))
                {
                            %>
                    <li data-thumb="<%= Imgsrc %>">
                            <img src="<%= Imgsrc%>" style="max-width: 100%;height:auto"/>
                    </li>
                        <%
                }
            }
                            %>
            </ul>
       </div>
    </div>
    <div id="next_cell">
        <div class="prices" style="margin-top: 15px;">
            <% if (!Model.VATSum.HasValue) { %>
                <% if (Model.Price != Model.OldPrice) { %>
                <p style="margin-bottom: 15px;"><span class="oldPrice">&pound;<%= Model.OldPrice.ToString("0.00") %> + VAT</span></p>
                <% } %>
                <p style="margin-bottom: 15px;"><span class="newPrice area_color">NOW: &pound;<%=Model.Price.ToString("0.00") %> + VAT</span></p>
            <% } %>
            
            <% if (Model.VATSum.HasValue) { %>
            <p style="margin-bottom: 15px;"><span class="newPrice">Total: &pound;<%=Model.TotalPrice.ToString("0.00") %> (Inc VAT)</span></p>
            <% } %>

            <p>Quantity: <%:Html.TextBoxFor(m => m.Quantity, new { style="width: 50px; text-align: center;" }) %></p>
        </div>
        <p>
            <input type="submit" id="btnAddToCart" class="k-button prog1 area_color" value="Add to Cart" title="Click here to get a quote" />
        </p>
        <p>&nbsp;</p>
        <p>
            <a id="btnDelivery" href="<%=Url.Action("delivery-calculator", "customer", new { sid=Model.StandardId, tid = Model.TypeId, cid = Model.ColorId, gid = Model.GlassId, areas=ViewBag.Area }) %>" data-fancybox-width="380" data-fancybox-height="360" class="fancybox-spc-sz fancybox.iframe k-button area_color">Delivery Cost</a>

<script type="text/javascript">

$(function() {
    var targets = $( '[rel~=tooltip]' ),
        target  = false,
        tooltip = false,
        title   = false;
 
    targets.bind( 'mouseenter, click', function()
    {
        target  = $( this );
        tip     = target.attr( 'title' );
        tooltip = $( '<div id="tooltip"></div>' );
 
        if( !tip || tip == '' )
            return false;
 
        target.removeAttr( 'title' );
        tooltip.css( 'opacity', 0 )
               .html( tip )
               .appendTo( 'body' );
 
        var init_tooltip = function()
        {
            if( $( window ).width() < tooltip.outerWidth() * 1.5 )
                tooltip.css( 'max-width', $( window ).width() / 2 );
            else
                tooltip.css( 'max-width', 340 );
 
            var pos_left = target.offset().left + ( target.outerWidth() / 2 ) - ( tooltip.outerWidth() / 2 ),
                pos_top  = target.offset().top - tooltip.outerHeight() - 20;
 
            if( pos_left < 0 )
            {
                pos_left = target.offset().left + target.outerWidth() / 2 - 20;
                tooltip.addClass( 'left' );
            }
            else
                tooltip.removeClass( 'left' );
 
            if( pos_left + tooltip.outerWidth() > $( window ).width() )
            {
                pos_left = target.offset().left - tooltip.outerWidth() + target.outerWidth() / 2 + 20;
                tooltip.addClass( 'right' );
            }
            else
                tooltip.removeClass( 'right' );
 
            if( pos_top < 0 )
            {
                var pos_top  = target.offset().top + target.outerHeight();
                tooltip.addClass( 'top' );
            }
            else
                tooltip.removeClass( 'top' );
 
            tooltip.css( { left: pos_left, top: pos_top } )
                   .animate( { top: '+=10', opacity: 1 }, 50 );
        };
 
        init_tooltip();
        $( window ).resize( init_tooltip );
 
        var remove_tooltip = function()
        {
            tooltip.animate( { top: '-=10', opacity: 0 }, 50, function()
            {
                $( this ).remove();
            });
 
            target.attr( 'title', tip );
        };
 
        target.bind( 'mouseleave', remove_tooltip );
        tooltip.bind( 'click', remove_tooltip );
    });
});
			
			
</script>
			
		<abbr title="Calculate the delivery cost here. This will show the delivery cost per unit to the chosen location. Delivery cost will be added during the checkout process and after filling in your invoice and billing details. It is also possible to pick up the goods from our factory at no extra cost." rel="tooltip"><img class="qmarkinfo" src="/images/qmark1311.png" alt="See how much would the delivery cost."></abbr>
        </p>
        <p class="ta-left" style="font-weight: normal; margin-top: 15px;">
            <a href="/pdfs/juliet/elevations/<%=Model.TypeId%>/<%=Model.TypeCode.ToLower()%><%=Model.StandardId/10%>.pdf" target="_blank" style="white-space: nowrap">
                <img src="/images/pdf.png" alt="pdf" />Section & Elevation
            </a>
        </p>
        <p class="ta-left" style="font-weight: normal; margin-top: 15px;">
            <a href="/pdfs/juliet/installation-instructions/<%=Model.TypeCode.ToLower()%>.pdf" target="_blank" style="white-space: nowrap">
                <img src="/images/pdf.png" alt="pdf" />Installation Instructions
            </a>
        </p>
        <p>&nbsp;</p>
    </div>
    
    <div style="clear:both"></div>
</div>

    <div style="clear:both"></div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>
<script src="/Content/slider/js/lightslider.min.js" type="text/javascript"></script>
<script>

   var LigthSlider = $('#slider').lightSlider({
        gallery: true,
        item: 1,
        loop: true,
        slideMargin: 0,
        thumbItem: 5,
        responsive: [
            {
                breakpoint: 800,
                settings: {
                    item: 1,
                    thumbItem: 3
                }
            }
        ]
    });
</script>