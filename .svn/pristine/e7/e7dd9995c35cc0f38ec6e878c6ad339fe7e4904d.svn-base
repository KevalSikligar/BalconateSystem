<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<IList<BalustradeModel>>" %>

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
<div class="wide-main balustardesquote">
    <ul id="cookie-menu">
		<li><a href="/">Home</a></li>
        <% if (ViewBag.Area != AreaKind.General) { %>
        <li><a href="<%=ViewBag.AreaUrl %>"><%:ViewBag.AreaName %></a></li>
		<% } %>
		<li class="last">Choose Shape</li>
	</ul>
    <%=ViewBag.Body %>
    <div id="models">
        <% foreach (var model in Model) {
                          if (model.Name != "testing-two-sections-copy")
                          {%>
        <div class="model">
            <h2><%:model.Name %></h2>
            <a title="<%=model.Name %> Glass Balustrade" href="<%:Url.Action("Quote", new { id = model.Url }) %>" class="fancybox" rel="sidegal">
                <img src="/images/balustrades/thumb/B2/<%=model.Image%>/1.png" alt="Glass Balustrade with <%:model.Name %>" />
            </a>
            <p>&nbsp;</p>
            <a class="btnSelect k-button" href="<%:Url.Action("Quote", new { id = model.Url }) %>">Select</a>
        </div>
        <% }
           }%>
    </div>
	<div style="max-width: 1500px; margin: 0 auto;">
	<h2>Online Balustrades Shop</h2>

	<p style="direction: ltr; ">Search our typical model types to find the closest model that reflects your requirement, it is not essential for the purposes of the quotation that the model exactly matches your configuration. The quotation will be based on the amount of sections and overall length. The quotation is for horizontal runs only and cannot include raked or sloped runs.</p>

	<p style="direction: ltr; ">If you cannot find a model that suits, please select to "create model" whereby you will give the number of sections your configuration has. </p>

	<p style="direction: ltr; ">Please note that if you have more than one balustrade you will need to enter and obtain a quote for each balustrade seperately.</p>
</div>
</div>
</asp:Content>
