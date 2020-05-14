<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<IList<AccessoryTypeLocal>>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<style type="text/css">
   h1 {
       margin-bottom: 15px;
   }
</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="main selfcleaningshop">
    <ul id="cookie-menu">
		<li><a href="/">Home</a></li>
        <% if (ViewBag.Area != AreaKind.General) { %>
        <li><a href="<%=ViewBag.AreaUrl %>"><%:ViewBag.AreaName %></a></li>
		<% } %>
		<li class="last">Shop</li>
	</ul>
    <%=ViewBag.Body %>
       
    <table id="online-shop">
	    <tbody>
		    <tr class="header">
			    <td class="product-image-header">
			    <p>Product</p>
			    </td>
			    <td class="product-name-header">
			    <p>&nbsp;</p>
			    </td>
			    <td class="price-header">
			    <p>Price</p>
			    </td>
			    <td class="add-to-cart-header">
			    <p>&nbsp;</p>
			    </td>
		    </tr>
            
            <% foreach (var product in Model) { %>
		    <tr>
			    <td class="product-image-cell">
			        <a class="fancybox" href="#fbx_<%=product.ID %>">
                        <img style="width: 130px;" alt="<%=product.Name_En %>" src="/images/balconano/<%=product.ID %>.jpg" />
			        </a>
			    </td>
                <td class="product-name-cell">
			        <div class="product-name">
                        <p class="name">
                            <a class="fancybox" href="#fbx_<%=product.ID %>"><%:product.Name_En %></a>
                        </p>
						<% if(product.OnlineOldPricePercent > 0) { %>
			            <p class="sale">ON SALE</p>
                        <% } %>
			        </div>
                    <div id="fbx_<%=product.ID %>" style="display: none;">
                        <table>
                            <tr>
                                <td style="vertical-align: top"><img style="width: 130px;" src="/images/balconano/<%=product.ID %>.jpg" alt="<%=product.Name_En %>" /></td>
                                <td style="vertical-align: top; padding-left: 20px;"><%=product.OnlineDescription %></td>
                            </tr>
                        </table>                                                                
                    </div>
                </td>
			    <td class="price-cell">
					<% if (product.OnlineOldPricePercent > 0) { %>
                    <p class="old-price">&pound;<%:product.OnlineOldPrice.ToString("0.00") %> + VAT</p>
                    <% } %>
                    <p class="new-price">&pound;<%:product.SellingPrice.ToString("0.00") %> + VAT</p>
					<% if (product.OnlineOldPricePercent > 0) { %>
			        <p class="you-save">You save: &pound;<%:(product.OnlineOldPrice - product.SellingPrice).ToString("0.00") %></p>
                    <% } %>
			    </td>
			    <td class="add-to-cart-cell">
			        <a class="btnAddToCart k-button bold" href="<%:Url.Action("add-to-cart", new { id = product.ID }) %>">Add to cart</a>
			    </td>
		    </tr>
            <% } %>
	    </tbody>
    </table>

    <p class="ta-right" style="padding-top: 10px;">
        <a class="k-button bold" href="<%:Url.Action("cart", "customer") %>">Shopping cart</a>
    </p>

</div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/kendo.dropdownlist.min.js" type="text/javascript"></script>
    
    

<script type="text/javascript">

</script>
</asp:Content>
