<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<QuoteAuthModel>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<style type="text/css">
    label {
        width: 100px;
        display: inline-block;
        text-align: right;
        margin-right: 10px;
    }
    h1 { margin-bottom: 20px;}
    #get_quote_btn {
        font-weight: bold;
        font-size: 18px;
    }
    #quote_auth {
        width: 580px;
        float: left;
    }
    #btn_cont {
        float: left;
        padding-top: 30px;
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
		<li class="last">Enter details</li>
	</ul>
    <h1>Please fill in your details</h1>
    <p style="font-weight: bold; font-size: 1.2em;">
        We will email you a copy of the quote to the contact details below.
    </p>
    <% using(Ajax.BeginForm(null, null, new AjaxOptions{ HttpMethod = "POST"}, new { id="frm" } )) {%>
    <div id="quote_auth">
        <p>
            <label>First name:</label>
            <%:Html.TextBoxFor(m => m.FirstName, new { @class="k-textbox", style="width: 150px" }) %>
            <%:Html.ValidationMessageFor(m => m.FirstName) %>
        </p>
        <p>
            <label>Last name:</label>
            <%:Html.TextBoxFor(m => m.LastName, new { @class="k-textbox", style="width: 150px" }) %>
            <%:Html.ValidationMessageFor(m => m.LastName) %>
        </p>
        <p>
            <label>Email:</label>
            <%:Html.TextBoxFor(m => m.Email, new { @class="k-textbox", style="width: 250px" }) %>
            <%:Html.ValidationMessageFor(m => m.Email) %>
        </p>
        <p>
            <label>Phone:</label>
            <%:Html.TextBoxFor(m => m.Phone, new { @class="k-textbox only-numbers", style="width: 150px" }) %>
            optional
        </p>
        <p style="margin-top: 20px;">
            We respect your privacy and will never pass or sell your details to a third party.
        </p>
    </div>
    <div id="btn_cont">
        <input type="submit" id="get_quote_btn" class="k-button area_color prog1" value="Get Quote ..." />
    </div>

    <% } %>
	<div class="quotetestimonials" style="display: block;clear: both;padding-top: 50px;">
		<h2>See what some of our respected customers think about us</h2>
		<p style="margin-bottom: 40px;">
		Great balcony. Very happy with the product. Easy to deal with and very helpful. Everything from design, through to order and delivery went nice and smoothly and according to plan. Quote received was a lot less expensive than the others I acquired.
		<br><br><span style="font-weight: bold;">Simon Craze</span></p>
		<p style="margin-bottom: 40px;">
		We had prices from your competitors, but found the frameless system was unmatched by any other manufacturer.
		<br><br><span style="font-weight: bold;">Hilary Cutmore</span></p>
		<p style="margin-bottom: 40px;">
		Very high standard manufacturer’s finish. Sleek smooth handrails. Customer satisfaction. Highly recommendable company.
		<br><br><span style="font-weight: bold;">David Troup</span></p>
		<p style="margin-bottom: 40px;">
		It seemed extravagant to have glass balustrades in the bedroom but we have such a lovely view we wanted to maximise the opportunity to our advantage. It was a decision we have never regretted. It has brought us more pleasure than we anticipated; to be able to see the full view of our garden and extending golf course in all its glory has been worth every penny.
		<br><br><span style="font-weight: bold;">Kevin Roberts</span></p>
		<p style="margin-bottom: 40px;">
		The minimalist design and Aerofoil handrail ooze class and feel substantial without additional vertical supports, allowing fantastic views. In the 18 months since installation we have had no problems whatsoever with the system and Balconette will be first choice for our next build. From first contact to delivery, they were a pleasure to deal with.
		<br><br><span style="font-weight: bold;">Allan Hawkins</span></p>
	</div>

</div>



</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
    
<script type="text/javascript">

    $(document).ready(function () {
        $("#frm").submit(function () {
           

        });
    });
</script>
</asp:Content>
