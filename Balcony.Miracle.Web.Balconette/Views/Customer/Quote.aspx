<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<Quote>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
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
        margin-bottom: 30px;
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
        margin-bottom: 20px
    }
</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="main">
	<ul id="cookie-menu">
		<li><a href="/">Home</a></li>
        <% if (ViewBag.Area != AreaKind.General) { %>
        <li><a href="<%=ViewBag.AreaUrl %>"><%:ViewBag.AreaName %></a></li>
		<% } %>
		<li class="last">Quote</li>
	</ul>
    <div id="online_quote_body">
        <%=ViewBag.Body %>
    </div>
    
    <div id="quote_actions">
        <div class="actions">
            <div id="addToCartWrap">
            <% using (Html.BeginForm("add-quote-to-cart", "customer", new { id=Model.ID }, FormMethod.Post)) { %>
                <input type="submit" id="btnAddToCart" class="k-button area_color prog1" value="Add to Cart" title="Add this item to the shopping cart" />
            <% } %>
            </div>
            <a id="btnDelivery" href="<%=Url.Action("delivery-calculator", new { id=Model.ID, areas=ViewBag.Area }) %>" data-fancybox-width="380" data-fancybox-height="360" class="fancybox-spc-sz fancybox.iframe k-button area_color">Delivery Cost</a>  <abbr title="Calculate the delivery cost here. This will show the delivery cost for the items included in the quotation, to the chosen location. Delivery cost will be added during the checkout process and after filling in your invoice and billing details. It is also possible to pick up the goods from our factory at no extra cost." rel="tooltip"><img class="qmarkinfo" src="/images/qmark1311.png" alt="Choose the glass type."></abbr>
            <a id="btnAmendQuote" href="<%=Url.Action("amend-quote", ViewBag.Area.ToString(), new { id=Model.ID }) %>" class="k-button area_color" title="Amend your quote">Amend Quote</a>  <abbr title="Click here to amend any detail of the quote and get an updated price." rel="tooltip"><img class="qmarkinfo" src="/images/qmark1311.png" alt="Choose the glass type."></abbr>
            <a id="btnStartOver" href="<%=Url.Action("quote", ViewBag.Area.ToString(), new {id = ""}) %>" class="k-button area_color" title="Create a new quote">Start Over</a>
        </div>
        <div>Link to your quote:</div>
        <input id="quoteLink" type="text" class="k-textbox" readonly="readonly" value="<%=Request.Url %>"/>
    </div>
</div>

<script src="/Scripts/tooltip.js"></script>
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
</asp:Content>
