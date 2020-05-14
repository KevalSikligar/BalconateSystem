<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<IList<CurvedDoorModelLocal>>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<style type="text/css">
   h1 {
       margin-bottom: 15px;
   }
   #models {
       text-align: center;
   }
   .model {
       display: inline-block;
       width: 360px;
       margin: 0 10px 10px 0;
       border: 1px solid #a99f9a;
       border-radius: 5px;
       -webkit-border-radius: 5px;
       -moz-border-radius: 5px;
       text-align: center;
       padding: 10px 0 10px 0;
   }
   .model h2 {
       margin: 0 0 10px 0;
       font-size: 16px;
   }
   a.btnSelect {
       font-weight: bold;
       color: #7314A5;
   }
   .model p {
       padding: 10px 10px 0 10px;
   }
   .model img {
       width: 80%;
   }
</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="wide-main curveddoorsquote">
    <ul id="cookie-menu">
		<li><a href="/">Home</a></li>
        <% if (ViewBag.Area != AreaKind.General) { %>
        <li><a href="<%=ViewBag.AreaUrl %>"><%:ViewBag.AreaName %></a></li>
		<% } %>
		<li class="last"><%=ViewBag.Name%></li>
	</ul>
    <%=ViewBag.Body %>
    <div id="models">
        <% foreach(var model in Model){ %>
        <div class="model">
            <h2><%:model.Name_En %></h2>
            <a title="<%=model.H1 %> Curved Glass Doors" href="<%:Url.Action("Quote", new { id = model.ShortName_En }) %>" class="fancybox" rel="sidegal">
                <img src="/images/curved-doors/thumb/<%=model.ShortName_En %>.jpg" alt="Curved Glass Doors - <%:model.Name_En %>" />
            </a>
            <p>&nbsp;</p>
            <a class="btnSelect k-button" href="<%:Url.Action("Quote", new { id = model.ShortName_En }) %>">Select</a>
        </div>
        <% } %>
    </div>
	<div style="max-width: 1500px; margin: 0 auto;">
	<p>To get a price follow these three easy steps.</p>

	<p>First Pick the System you would like.</p>

	<p>Then search our Curved Patio Door options for the suitable product type/model type that reflects your requirement. </p>

	<p>Click on the product that you choose and enter the data required. Then click calculate. </p>

	<p>To save the quote add it to you basket and this will give you a saved quote number. You can save this or then go on to purchase if you like. </p>
</div>
</div>
</asp:Content>
