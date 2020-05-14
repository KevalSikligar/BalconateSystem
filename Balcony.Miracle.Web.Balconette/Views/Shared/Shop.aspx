<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<IList<AccessoryTypeLocal>>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<style type="text/css">
   h1 {
       margin-bottom: 15px;
   }
   #models {
       padding-left: 2px;
       text-align: center;
   }
   .model {
       display: inline-block;
       width: 370px;
       margin: 0 5px 10px 5px;
       border: 1px solid #a99f9a;
       border-radius: 5px;
       -webkit-border-radius: 5px;
       -moz-border-radius: 5px;
       text-align: center;
       padding: 10px 0 10px 0;
       overflow: hidden;
   }
   .model h2 {
        margin: 0;
        font-size: 16px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        padding: 0 10px;
   }
   .model p.subtitle {
        margin: 0;   
   }

   .btnSelect {
       font-weight: bold;
       font-size: 14px;
       font-size: 14px;
       height: 26px;
       padding: 0 10px !important;
   }
   .model p.oldPrice {
       margin: 0 0 5px 0 ;
       text-align: center;
       color: #606060;
       text-decoration: line-through;
   }
   .model p.newPrice {
       margin: 0 0 5px 0 ;
       text-align: center;
       font-weight: bold;
       font-size: 14px;
   }


   .model img {
       height: 120px;
        border: 8px #ffffff solid;
        margin-bottom: 15px;
        
   }
</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="wide-main">
    <ul id="cookie-menu">
		<li><a href="/">Home</a></li>
        <% if (ViewBag.Area != AreaKind.General) { %>
        <li><a href="<%=ViewBag.AreaUrl %>"><%:ViewBag.AreaName %></a></li>
		<% } %>
		<li class="last">Choose size</li>
	</ul>    
    <%=ViewBag.Body %>
    <div id="models">
        <% foreach(var accessoryType in Model){ %>

        <div class="model">
            <% using (Html.BeginForm("add-to-cart", null, FormMethod.Post)) { %>
                <h2><a class="fancybox" href="#fbx_<%=accessoryType.ID %>" title="<%:accessoryType.Name_En %>"><%:accessoryType.Name_En %></a></h2>
                <p class="subtitle">&nbsp;</p>

                <% if (accessoryType.ImageFile != null) { %>
                    <% var imageUrl = Url.Action("image", "general", new {id = accessoryType.ImageFile.ID}); %>
                    <a class="fancybox fancybox.image" rel="maingal" href="<%=imageUrl %>" title="<%:accessoryType.Name_En %>">
                        <img src="<%=imageUrl %>" alt="<%:accessoryType.Name_En %>" />
                    </a>
                <% } else { %>
                    <img src="/images/default.jpg" alt="<%:accessoryType.Name_En %>" />
                <% } %>

                <p class="oldPrice">
                <% if (accessoryType.OnlineOldPricePercent != 0) { %>
                    &pound;<%= accessoryType.OnlineOldPrice.ToString("0.00") %> + VAT
                <% } %>
                    &nbsp;
                </p>
                <p class="newPrice area_color">&pound;<%=accessoryType.SellingPrice.ToString("0.00") %> + VAT</p>
                <p>
                    <input type="hidden" value="<%=accessoryType.ID %>" name="id"/>
                    <input type="text" value="1" name="quantity" class="quantity ta-center only-numbers" style="width: 60px;" />                    
                    <input type="submit" class="btnSelect k-button area_color" value="Add to Cart"/>
                </p>
                <div id="fbx_<%=accessoryType.ID %>" style="display: none;">
                    <%=accessoryType.OnlineDescription %>                    <table>
                    </table>                                                                
                </div>
            <% } %>
        </div>
        <% } %>
    </div>
</div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
    <script type="text/javascript">
        $(document).ready(function() {
            $(".quantity").kendoNumericTextBox({
                format: "n0",
                min: 1,
                max: parseInt("<%=AppSettings.MAX_QUANTITY%>"),
                step: 1,
            });
        });
    </script>
</asp:Content>
