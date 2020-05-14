<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<StandardPageModel>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<% string s_conversion_code;
if(ViewBag.Area.ToString()=="CurvedDoors") 
{s_conversion_code = "AkOOCIbo2HUQs-C0-gM";}
else if (ViewBag.Area.ToString()=="Balustrades")
{s_conversion_code = "LqUWCObFwHQQs-C0-gM";}
else 
{s_conversion_code = "JK86CIut3nUQs-C0-gM";}



%>
<style type="text/css">
    h1 { margin-bottom: 20px;}

    #online_quote_body {
        color: black; 
        line-height: 16px;
        width: 750px;
        float: left;
    }
    #online_quote_body p { margin-bottom: 10px; }
    #online_quote_body th {font-weight: bold; text-align: center; border: 1px solid #c5c5c5;padding: 5px;}
    #online_quote_body td { border: 1px solid #c5c5c5;line-height: 22px;padding: 5px;}
    #online_quote_body table {
        border-collapse: collapse;
    }
    #online_quote_body ul, ol {
        list-style: inherit;
    }
    #quote_actions {
        float: left;
        width: 190px;
        text-align: center;
        margin-left: 20px;
        padding: 10px;
        background-color: #f4f4f4;
        border-radius: 4px;
        -moz-border-radius: 4px;
        -webkit-border-radius: 4px;

    }
    #quote_actions a:hover {
        text-decoration: none;
    }
    #quote_actions a {
        cursor: pointer;
        margin-bottom: 10px;
        font-weight: bold;
    }
    #quote_actions .actions {
        margin-bottom: 15px;
    }
    #btnAddToCart {
        font-weight: bold;
        font-size: 18px;
        width: 180px;
        background-image: url("/images/cart.png");
        background-position: 10px 4px;
        background-repeat: no-repeat;
        text-align: right;
    }
   
    #btnAmendQuote {
        font-size: 14px;
        width: 147px;
        text-align: center;
    }
    #btnStartOver {
        font-size: 14px;
        width: 160px;
        text-align: center;
    }
    #quoteLink {
        width: 100%;
    }
    #addToCartWrap {
        margin-bottom: 20px;
    }

    @media only screen and (max-width: 659px) {
        #quote_actions {
            float: none;
            margin: 25px auto 10px auto;
            width: 250px;
            padding: 10px;
        }

        #quote_actions form {
            text-align: center;
        }

        #quote_actions .quote_actions_btn_group {
            display: block;
            margin: 5px auto;
        }

        #quote_actions .quote_actions_btn_group a {
            font-weight: normal !important;
        }

        #quote_actions .quote_actions_btn_group #btnDelivery,
        #quote_actions .quote_actions_btn_group #btnAmendQuote {
            margin-left: 37px;
        }

        .quote_actions_btn_group img.qmarkinfo {
            margin: 0 10px 5px 10px !important;
        }


    }
</style>
<!-- Google Code for Request A Quote - AdWords Con Conversion Page -->
<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 1062023219;
var google_conversion_language = "en";
var google_conversion_format = "3";
var google_conversion_color = "ffffff";
var google_conversion_label = "<%=s_conversion_code%>";
var google_remarketing_only = false;
/* ]]> */
</script>
<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="//www.googleadservices.com/pagead/conversion/1062023219/?label=<%=s_conversion_code%>&amp;guid=ON&amp;script=0"/>
</div>
</noscript>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<% if (Model.Page.UseTemplate) { %>
	<div class="main">
        <ul id="cookie-menu">
			<li><a href="/">HOME</a></li>
            <% if (Model.Page.Area.ID != AreaKind.General) { %>
            <li><a href="<%=Url.Action("", Model.Page.Area.ID.ToString().ToLower()) %>"><%: Model.Page.Area.Name.ToUpper() %></a></li>
			<% } %>
            <li class="last"><%:Model.Page.Name.ToUpper() %></li>
		</ul>
        <div id="online_quote_body">
        <%= Model.Body %> 
        </div>
		<div id="quote_actions">
            <div class="actions">
                <div id="addToCartWrap">
                <% using (Html.BeginForm("add-quote-to-cart", "customer", new { id=TempData["QuoteID"].ToString() }, FormMethod.Post)) { %>
                    <input type="submit" id="btnAddToCart" class="k-button area_color prog1" value="Add to Cart" title="Add this item to the shopping cart" />
                <% } %>
                </div>
                <div class="row" style="text-align: center">
                    <div class="quote_actions_btn_group">
                        <a id="btnDelivery" href="#" class="fancybox-spc-sz fancybox.iframe k-button area_color">Delivery Cost</a>
                        <abbr title="Calculate the delivery cost here. This will show the delivery cost for the items included in the quotation, to the chosen location. Delivery cost will be added during the checkout process and after filling in your invoice and billing details. It is also possible to pick up the goods from our factory at no extra cost." rel="tooltip">
                            <img class="qmarkinfo" src="/images/qmark1311.png" alt="Choose the glass type.">
                        </abbr>
                    </div>
                    <div class="quote_actions_btn_group">
                        <a id="btnAmendQuote" href="<%=Url.Action("amend-quote", ViewBag.Area.ToString(), new { id=TempData["QuoteID"].ToString() }) %>" class="k-button area_color" title="Amend your quote">Amend Quote</a>
                        <abbr title="Click here to amend any detail of the quote and get an updated price." rel="tooltip"><img class="qmarkinfo" src="/images/qmark1311.png" alt="Choose the glass type."></abbr>
                    </div>
                    <div class="quote_actions_btn_group">
                        <a id="btnStartOver" href="<%=Url.Action("quote", ViewBag.Area.ToString(), new {id = ""}) %>" class="k-button area_color" title="Create a new quote">Start Over</a>
                    </div>
                </div>
            </div>
            <div>Link to your quote:</div>
            <input id="quoteLink" type="text" class="k-textbox" readonly="readonly" value="<%=Request.Url %>"/>
        </div>
	</div>
<% } else { %>
    <div id="online_quote_body">        
    <%= Model.Body %> 
    </div>
<% } %>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
<script type="text/javascript">
    $(document).ready(function() {
        $("#quoteLink").click(function() {
            $(this).select();
        });

        <% if(Context.IsCustomerOrQuoteCustomer()) { %>
        ga('send', 'event', { eventCategory: 'requestquote', eventAction: 'send' });
        <% } %>
    });
</script>

<script>
$(document).ready(function() {
    // Move buttons under the table (mobile screens)
    var screenW = $('body').width();
    var quoteActionsBlock = $('#quote_actions');
    if (screenW <= 659) {
        $('#quote_actions').remove();
        quoteActionsBlock.insertAfter('#online_quote_body table:first');
    }
});
</script>

<script src="/Scripts/tooltip.js"></script>

<script type="text/javascript">

    $(document).ready(function () {
        $("#btnDelivery").click(function() {
            $.fancybox({
                fitToView: false,
                autoSize: false,
                width: 380,
                height: 360,
                href: '<%=Url.Action("delivery-calculator", "customer", new { id=TempData["QuoteID"].ToString(), areas=ViewBag.Area }) %>',
                type: 'iframe'
            });
        });
    });

</script>

<%=Model.Page.Footer %> 
</asp:Content>
