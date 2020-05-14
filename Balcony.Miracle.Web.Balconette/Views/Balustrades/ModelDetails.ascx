<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<BalustradeQuoteModel>" %>
<link href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
    @media only screen and (max-width: 659px) {
        #model-details-content .need-a-different-model {
            display: none;
        }

        #model-details-content #middle_wrap {
            margin-top: 15px;
        }

        #model-details-content #section_cell {
            display: none !important;
        }

        #model-details-content #section_cell_mobile {
            display: block !important;
        }

        #sectionImage {
            margin-top: 0 !important;
            margin-bottom: 0 !important;
        }

        .width-auto {
            width: auto !important;
        }

        .mt-25 {
            margin-top: 25px !important;
        }

        #p-num5 {
            display: block;
            width: 100%;
            margin-top: 0;
        }

        #num5 {
            float: left;
            margin-right: 15px;
            margin-top: 10px;
        }

        #p-num5 input[type=submit] {
            font-size: 14px;
        }

        #technical-details {
            font-size: 14px;
            font-weight: normal !important;
        }
    }
    .owl-carousel .owl-item img {
    width: auto !important;
    }
    .fancybox-wrap {
    width: auto !important;
    }
    .fancybox-inner {
    width: auto !important;
    }
</style>

<div id="model-details-content">

    <h1><%:Model.H1 %></h1>
    <p class="toplinksp"><a href="/glass-balustrade/homepage" style="color: #666;">Glass Balustrades</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/glass-balustrade/technical-details" style="color: #666;">Tech Specs</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/glass-balustrade/how-to-install-glass-balustrades" style="color: #666;">Installation</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/glass-balustrade/photos" style="color: #666;">Gallery</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/glass-balustrade/case-studies" style="color: #666;">Projects</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/glass-balustrade/articles" style="color: #666;">Articles</a></p>
    <%--
<p class="back-to-quote">
    <a href="<%=Url.Action("quote", new{ id = (string)null }) %>">Back to choose shape</a>
</p>
    --%>
    <p style="margin: 20px 0 40px;" class="need-a-different-model">(Need a different model? <a href="<%=Url.Action("quote", new{ id = (string)null }) %>">Click here</a>)</p>
    <div id="type-and-color">
        <script type="text/javascript">
            $(function () {
                var targets = $('[rel~=tooltip]'),
                    target = false,
                    tooltip = false,
                    title = false;

                targets.bind('mouseenter, click', function () {
                    target = $(this);
                    tip = target.attr('title');
                    tooltip = $('<div id="tooltip"></div>');

                    if (!tip || tip == '')
                        return false;

                    target.removeAttr('title');
                    tooltip.css('opacity', 0)
                        .html(tip)
                        .appendTo('body');

                    var init_tooltip = function () {
                        if ($(window).width() < tooltip.outerWidth() * 1.5)
                            tooltip.css('max-width', $(window).width() / 2);
                        else
                            tooltip.css('max-width', 340);

                        var pos_left = target.offset().left + (target.outerWidth() / 2) - (tooltip.outerWidth() / 2),
                            pos_top = target.offset().top - tooltip.outerHeight() - 20;

                        if (pos_left < 0) {
                            pos_left = target.offset().left + target.outerWidth() / 2 - 20;
                            tooltip.addClass('left');
                        }
                        else
                            tooltip.removeClass('left');

                        if (pos_left + tooltip.outerWidth() > $(window).width()) {
                            pos_left = target.offset().left - tooltip.outerWidth() + target.outerWidth() / 2 + 20;
                            tooltip.addClass('right');
                        }
                        else
                            tooltip.removeClass('right');

                        if (pos_top < 0) {
                            var pos_top = target.offset().top + target.outerHeight();
                            tooltip.addClass('top');
                        }
                        else
                            tooltip.removeClass('top');

                        tooltip.css({ left: pos_left, top: pos_top })
                            .animate({ top: '+=10', opacity: 1 }, 50);
                    };

                    init_tooltip();
                    $(window).resize(init_tooltip);

                    var remove_tooltip = function () {
                        tooltip.animate({ top: '-=10', opacity: 0 }, 50, function () {
                            $(this).remove();
                        });

                        target.attr('title', tip);
                    };

                    target.bind('mouseleave', remove_tooltip);
                    tooltip.bind('click', remove_tooltip);
                });
            });


        </script>
        <p>
            <label>
                <span class="num">1.</span>
                Balustrade System: 
                <abbr title="Choose from the different balustrade systems available. You can see the section and 3D model change in the image below as you choose different options." rel="tooltip">
                    <img class="qmarkinfo" src="/images/qmark1311.png" alt="Choose the balustrade system."></abbr>
            </label>
            <%:Html.TextBoxFor(m => m.TypeId, new { style="width: 150px" }) %>
        </p>
        <p>
            <label>
                <span class="num">2.</span>
                Balustrade Colour: 
                <abbr title="Pick from a list of available colours for the metalwork. Watch as the balustrade image below changes to the colour you choose." rel="tooltip">
                    <img class="qmarkinfo" src="/images/qmark1311.png" alt="Choose the balustrade colour."></abbr>
            </label>
            <%:Html.TextBoxFor(m => m.ColorId, new { style="width: 163px", disabled="disabled" }) %>
        </p>
        <p>
            <label>
                <span class="num">3.</span>
                Glass Type: 
                <abbr title="Pick the glass type for your Balustrade from a list of available glass options." rel="tooltip">
                    <img class="qmarkinfo" src="/images/qmark1311.png" alt="Choose the balustrade glass type."></abbr>
            </label>
            <%:Html.TextBoxFor(m => m.GlassId, new { style="width: 500px", disabled="disabled" }) %>
        </p>
        <p class="float-none clear">
            <label>
                <span class="num">4.</span>
                Balustrade dimensions: 
                <abbr title="Fill in the dimensions of your balcony requirement in the relevant boxes and click next. Please note that the sizes are in millimetres." rel="tooltip">
                    <img class="qmarkinfo" src="/images/qmark1311.png" alt="Choose the balustrade dimensions."></abbr>
            </label>
        </p>
    </div>
    <div id="middle_wrap">
        <div id="section_cell">
            <img id="sectionImage" src="/images/balustrades/sections/b<%=Model.TypeId%>.png" alt="<%:Model.H1 %> Section" />
        </div>
        <div id="model_cell">
            <img id="modelImage" src="/images/balustrades/arrows/b<%=Model.TypeId%>/<%=Model.ModelImage%>/<%=Model.ColorId%>.png" alt="<%:Model.H1 %>" />
            <% var i = 0; %>
            <% foreach (var section in Model.Dims)
                { %>
            <%:Html.HiddenFor(m => m.Dims[i].Curved) %>
            <div class="mes" style="left: <%:section.X%>px; top: <%:section.Y%>px;">
                <div style="margin-bottom: 5px;">
                    <% if (section.Curved)
                        { %>
                    <span class="label">Curved Length
                    </span>
                    <% } %>
                    <%:Html.TextBoxFor(m => m.Dims[i].Length, new { @class="k-textbox only-numbers bal-dim bal-dim-length", style="width: 50px", autocomplete = "off" }) %>
                    <span>mm</span>
                    <%:Html.ValidationMessageFor(m => m.Dims[i].Length) %>
                </div>
                <%--
            <% if(section.Curved) { %>
            <div>
                <span class="label">Depth</span>
                <%:Html.TextBoxFor(m => m.Dims[i].Depth, new { @class="k-textbox only-numbers", style="width: 50px", autocomplete = "off" }) %>
                <span>mm</span>
                <%:Html.ValidationMessageFor(m => m.Dims[i].Depth) %>
            </div>
            <% } %>
                --%>
            </div>
            <% i++; %>
            <% } %>
        </div>
        <div id="next_cell" class="rightbnc width-auto">
            <% if (Model.Price > 0)
                { %>
            <div style="margin-bottom: 10px;">
                <div><%=Model.P == 1 ? "Price excluding VAT:" : "Price including VAT:" %></div>
                <div style="font-size: 1.4em;">
                    &pound;<%:Model.Price.ToString("N02") %>
                    <button class="k-button btnRefresh" style="display: none; font-size: 14px; padding: 0 8px !important;">Refresh</button>
                </div>
            </div>
            <p id="p-num5">
                <label>
                    <span class="num" id="num5">5.</span>
                    <input type="submit" class="k-button prog1 area_color" name="Action" value="<%=BalustradeQuoteModel.AddToCartText %>" />
                </label>
            </p>
            <p><span class="num">or</span></p>
            <p>
                <label>
                    <span class="num">6.</span>
                    <input type="submit" class="k-button prog1 area_color" name="Action" value="<%=BalustradeQuoteModel.GetQuoteText %>" />
                </label>
            </p>
            <% }
                else
                { %>
            <p id="p-num5">
                <label>
                    <span class="num" id="num5">5.</span>
                    <input type="submit" class="k-button prog1 area_color" name="Action" value="<%=BalustradeQuoteModel.GetQuoteText %>" />
                </label>
            </p>
            <% } %>
        </div>
    </div>
    <div class="balmodname" style="text-align: center">
        Balustrade System: <%=Model.Body %>
    </div>

    <div class="carousel-wrap">
        <div class="owl-carousel">
            <%
                if (Model.thumbnailimages != null && Model.thumbnailimages.Count != 0)
                {
                    foreach (var model in Model.thumbnailimages)
                    { %>
            <div class="item">
                        <a title="" class="fancybox displayblock" rel="sidegal" data-fancybox="images">
                            <img id="modelImage" class="thumbnailImages" src="<%:model%>" alt="<%:Model.H1 %>" style="/*max-width: 100%;*/ height: 200px" />
                        </a>
            </div>
            <% }
                }%>
        </div>
        <%
            if (Model.thumbnailimages != null && Model.thumbnailimages.Count != 0)
            {%>
        <div class="balmodname" style="text-align: center">
            Some pictures using this System
        </div>
        <%} %>
    </div>


    <div id="section_cell_mobile" style="display: none;">
        <img id="sectionImage" src="/images/balustrades/sections/b<%=Model.TypeId%>.png" alt="<%:Model.H1 %> Section" />
    </div>
    <div id="next_cell" class="width-auto mt-25">
        <% if (Model.Price > 0)
            { %>
        <div style="margin-bottom: 10px;">
            <div><%=Model.P == 1 ? "Price excluding VAT:" : "Price including VAT:" %></div>
            <div style="font-size: 1.4em;">
                &pound;<%:Model.Price.ToString("N02") %>
                <button class="k-button btnRefresh" style="display: none; font-size: 14px; padding: 0 8px !important;">Refresh</button>
            </div>
        </div>
        <p id="p-num5">
            <label>
                <span class="num" id="num5">5.</span>
                <input type="submit" class="k-button prog1 area_color" name="Action" value="<%=BalustradeQuoteModel.AddToCartText %>" />
            </label>
        </p>
        <p><span class="num">or</span></p>
        <p>
            <label>
                <span class="num">6.</span>
                <input type="submit" class="k-button prog1 area_color" name="Action" value="<%=BalustradeQuoteModel.GetQuoteText %>" />
            </label>
        </p>
        <% }
            else
            { %>
        <p id="p-num5">
            <label>
                <span class="num" id="num5">5.</span>
                <input type="submit" class="k-button prog1 area_color" name="Action" value="<%=BalustradeQuoteModel.GetQuoteText %>" />
            </label>
        </p>
        <% } %>

        <p>&nbsp;</p>
        <p class="ta-left" id="technical-details">
            <a href="/pdfs/balustrades/technical-details/b<%=Model.TypeId%>.pdf" target="_blank" style="white-space: nowrap">
                <img src="/images/pdf.png" alt="pdf" />Technical Details
            </a>
        </p>
    </div>

</div>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.js"></script>
<script>
    $(document).ready(function () {
        var screenW = $('body').width();
        if (screenW <= 659) {
            $('#p-num5 input[type=submit]').val('Quote');
        }
        $(".fancybox").fancybox({
            fitToView   : false,
            height      : 'auto',
            autoSize    : false,
            helpers: {
                overlay: {
                    locked: false
                }
            }
        });
    });

    $(document).ready(function () {
<% for (int counter = 0; counter < 100; counter++)
    { %>
        "<div class='item'><ul id='slider'>"
        <%
    string Imgsrc;

    Imgsrc = string.Empty;
    Imgsrc = "/images/balustrades/thumb/b";
    Imgsrc += Model.TypeId + "/";
    Imgsrc += Model.ModelImage + "/";
    if (counter == 0)
    {
        Imgsrc += Model.ColorId + ".jpg";
    }
    else
    {
        Imgsrc += Model.ColorId + "_" + counter + ".jpg";
    }
    if (System.IO.File.Exists(Server.MapPath(Imgsrc)))
    {
                            %>
        $('.owl-carousel').owlCarousel({
            loop: true,
            margin: 10,
            nav: true,
            navText: [
                "<i class='fa fa-caret-left' style='color: #C0C0C0;'></i>",
                "<i class='fa fa-caret-right' style='color: #C0C0C0;'></i>"
            ],
            autoplay: true,
            autoWidth: true,
            autoHeight: true,
            autoplayHoverPause: true,
            responsive: {
                0: {
                    items: 3
                },
                600: {
                    items: 4
                },
                1000: {
                    items: 4
                }
            }
        })
                        <%
    }
                            %>
        "</ul></div>"
            <% } %>

    });
</script>
