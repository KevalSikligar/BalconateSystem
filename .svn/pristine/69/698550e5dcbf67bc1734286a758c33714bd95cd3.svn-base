<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<Area>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
    <link rel="stylesheet" type="text/css" href="/content/nivoslider/nivo-slider.css" />
    <link rel="stylesheet" type="text/css" href="/content/nivoslider/default.css" />
    <link rel="stylesheet" type="text/css" href="/content/nivoslider/sidebar.css" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
	<div class="main">		
		<h1 id="f_h1" contenteditable="<%:this.IsAdmin() %>">BALCONANO GLASS COATING</h1>
		<div id="two-icons">
			<h3 id="online-shop"><a href="<%=Url.Action("shop") %>">Online Shop &raquo;</a></h3>
			<h3 id="products"><a href="<%=Url.Action("products") %>">BalcoNano Products &raquo;</a></h3>
		</div>
		<div id="balconano-video">
			<iframe width="533" height="300" src="//www.youtube.com/embed/mL57SY201CY?rel=0" frameborder="0" allowfullscreen></iframe>
		
		</div>
        <% foreach (var image in Model.LargeImages.Where(img => !String.IsNullOrWhiteSpace(img.Description))) { %>
        <div id="<%=image.ID %>" class="nivo-html-caption">
		    <%=image.Description %>
		</div>
        <% } %>
        
        
        <div id="icons">
			<h3><a href="<%=Url.Action("glass-coating-how-it-works") %>" id="how-it-works">How it Works</a></h3>
			<h3><a href="<%=Url.Action("application-instructions") %>" id="application-instructions" class="double-line">Application<br />Instructions</a></h3>
			<h3><a href="<%=Url.Action("trade-and-distributors") %>" id="trade-and-distributors" class="double-line">Trade and<br />Distributors</a></h3>
			<h3><a href="<%=Url.Action("frequently-asked-questions") %>" id="faq" class="double-line last">Frequently<br />asked Questions</a></h3>
			<div id="money-back">
				<img src="/images/balconano-money-back-guarantee.jpg" alt="Money back guarantee - Balconano" />
				<p>Web Purchase Money Back Guarantee</p>
				<p><a href="<%=Url.Action("money-back-guarantee", "pages") %>">Learn more...</a></p>			
			</div>
		</div>	
		<ul id="cookie-menu">
			<li><a href="/">HOME</a></li>
			<li class="last">BALCONANO GLASS COATING</li>
		</ul>		
		<div class="left">
			<div class="left-content cmsblock" id="f_body" contenteditable="<%:this.IsAdmin() %>">
			    <%=Model.HomepageBody %>
			</div>
			<div id="shop">
				<img src="/images/balconano-shop-badges.jpg" alt="Self Cleaning Glass Sachets" class="badges" />
				<div id="content-block">
					<h2>Buy BalcoNano Sachets Online</h2>
					<table>
						<tr>
							<th class="product"><p>Product</p></th>
							<th class="price"><p>Price</p></th>
							<th class="add-to-cart"><p>&nbsp;</p></th>
						</tr>
                        
                        <% foreach (AccessoryTypeLocal product in ViewBag.Products) { %>
						<tr>
							<td><p class="title area_color"><%:product.Name_En %></p></td>
							<td>
							    <% if(product.OnlineOldPricePercent > 0) { %>
							    <p class="old-price">&pound;<%:product.OnlineOldPrice.ToString("0.00") %> + VAT</p>
                                <% } %>
                                <p class="current-price">&pound;<%:product.SellingPrice.ToString("0.00") %> + VAT</p>
							    <% if (product.OnlineOldPricePercent > 0) { %>
                                <p class="sale">You save: &pound;<%:(product.OnlineOldPrice - product.SellingPrice).ToString("0.00") %></p>
                                <% } %>
							</td>
							<td>
							    <% using (Html.BeginForm("add-to-cart", null, FormMethod.Post)) { %>
                                    <%=Html.Hidden("id",  product.ID) %>
                                    <input type="submit" value="Add to cart" class="btnAddToCart k-button bold prog1"/>
                                <% } %>
							</td>
						</tr>
                        <% } %>
					</table>
					<div id="goto-shop">
						<p>For more options, visit our shop</p>
						<a class="k-button bold" href="<%:Url.Action("shop") %>">Visit our shop</a>
					</div>
				</div>
				<div id="shop-bg"></div>
			</div>
		</div>
		<div class="right">
		    
			<% Html.RenderPartial("leftsidebar"); %>
			

			
            
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
	</div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/jquery.nivo.slider.pack.js" type="text/javascript"></script>
    
<% if (this.IsAdmin()) { %>
<% Html.RenderPartial("CKEditor"); %>

<script type="text/javascript">
    var f_body = CKEDITOR.inline('f_body');
    var f_links = CKEDITOR.inline('balconano-apps');
    $(document).ready(function () {

        $("#adminsave").click(function () {
            var btn = $(this);
            btn.hide();
            $.ajax({
                dataType: "json",
                type: 'POST',
                url: '<%=Url.Action("Save", "Areas", new { area="Admin" })%>',
                data: {
                    id: "<%=Model.ID %>",
                    f_h1: $("#f_h1").html(),
                    f_title: $("#f_title").val(),
                    f_desc: $("#f_desc").val(),
                    f_keywords: $("#f_keywords").val(),
                    f_body: f_body.getData(),
                    f_links: f_links.getData()
                },
                cache: false,
                complete: function (jqXHR, textStatus) {
                    btn.show();
                },
                success: function (data, textStatus, xhr) {

                }
            });
        });
    });
</script>

<div id="adminpanel">
    <div class="top">
        <h2>Admin Panel</h2>
    </div>
    <div class="cont">
        <div style="height: 30px;">
            <button id="adminsave" style="float: right;">Save</button>    
        </div>                
        <table class="ftable">
            <tr>
                <th>Title</th>
                <td><input id="f_title" value="<%=Model.HomepageTitle %>" type="text" class="k-textbox" style="width: 70%;" /></td>
            </tr>
            <tr>
                <th>Description</th>
                <td><input id="f_desc" value="<%=Model.HomepageDescription %>" type="text" class="k-textbox" style="width: 70%;" /></td>
            </tr>
            <tr>
                <th>Keywords</th>
                <td><input id="f_keywords" value="<%=Model.HomepageKeywords %>" type="text" class="k-textbox" style="width: 70%;" /></td>
            </tr>
        </table>
    </div>
</div>

<% } %>
    
    
    

</asp:Content>
