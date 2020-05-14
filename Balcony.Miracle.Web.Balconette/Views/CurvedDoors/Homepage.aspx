<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<Area>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
    <link rel="stylesheet" type="text/css" href="/content/nivoslider/nivo-slider.css" />
    <link rel="stylesheet" type="text/css" href="/content/nivoslider/default.css" />
    <link rel="stylesheet" type="text/css" href="/content/nivoslider/sidebar.css" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
	<div class="main curveddoorsmain">		
		<h1 id="f_h1" contenteditable="<%:this.IsAdmin() %>"><%=Model.HomepageH1 %></h1>
		<div id="two-icons">
			<h3 id="online-quote"><a href="<%:Url.Action("quote") %>">Get an online<br />quote &raquo;</a></h3>
			<h3 id="why-choose-us"><a href="<%:Url.Action("why-choose-us") %>">Why<br />choose<br />us?</a></h3>
		</div>
		<%--
		<div class="slider-wrapper theme-default">
			<div class="ribbon"></div>
            <div class="largeCont">
                <div id="slider" class="nivoSlider largeSlider">
                    <% foreach (var image in Model.LargeImages) { %>
				    <img src="<%=image.ThumbUrl %>" alt="<%:image.Name %>" />
                    <% } %>
                </div>
            </div>

		</div>
		--%>
		<div id="cdptopvideo">
			<iframe width="533" height="300" src="//www.youtube.com/embed/AhaWTBUIbVs?rel=0" frameborder="0" allowfullscreen></iframe>
		
		</div>
        <% foreach (var image in Model.LargeImages.Where(img => !String.IsNullOrWhiteSpace(img.Description))) { %>
        <div id="<%=image.ID %>" class="nivo-html-caption">
		    <%=image.Description %>
		</div>
        <% } %>
        
        
        					
		<div class="left topicons">
			<div class="icons">
				<h3><a href="<%=Url.Action("door-arrangement-options") %>" id="types-of-curved-doors">Curved Door Options</a></h3>
				<h3><a href="<%=Url.Action("technical-details") %>" id="technical-details-curved-doors">Technical details</a></h3>
				<h3><a href="<%=Url.Action("how-to-install-curved-doors") %>" id="how-to-install-curved-doors" class="double-line">How to install<br />Curved Doors</a></h3>
				<h3><a href="<%=Url.Action("trade-customers") %>" id="trade-customers-curved-doors" class="last">Trade Customers</a></h3>
				<div class="slider-wrapper theme-sidebar">
				<div class="ribbon"></div>
            <div id="slider-sidebar" class="nivoSlider">					
                    <% foreach (var image in Model.SmallImages) { %>
				    <a class="fancybox" rel="sidegal" href="<%=image.ZoomUrl %>" title="<%=image.Description %>">
                        <img src="<%=image.ThumbUrl %>" alt="<%=image.Name %>" />
				    </a>
                    <% } %>
				</div>
				<p id="gallery"><a href="<%:Url.Action("photos") %>">Go to photo gallery &raquo;</a></p>
			</div>
			</div>
		</div>	
		<ul id="cookie-menu">
			<li><a href="/">HOME</a></li>
			<li class="last">GLASS BALUSTRADES</li>
		</ul>
		<div class="left">	
			<div class="left-content cmsblock" id="f_body" contenteditable="<%:this.IsAdmin() %>">
			    <%=Model.HomepageBody %>
			</div>
		</div>
		<div class="right">
			
			
			
			<% Html.RenderPartial("leftsidebar"); %>

            <%/* should be feched from blog see old website homepage
			<div id="news">
				<h2>News</h2>
				<div class="news-item">
					<h3>Curved Doors</h3>
					<p class="date">16 September 2012</p>
					<p>Really secure from perspective of children running about and being glazed gives feel of there being no obstruction - we have lovely countryside...</p>
					<p><a href="#">READ MORE</a></p>
				</div>
				<div class="news-item">
					<h3>Curved Doors</h3>
					<p class="date">30 September 2012</p>
					<p>Stunning product, good quality, great price. I put plenty of research into my juliette balcony purchase and chose Balcony Systems as they came...</p>
					<p><a href="#">READ MORE</a></p>
				</div>
			</div>
            */%>

			<div id="f_links" class="links border-bottom"  contenteditable="<%: this.IsAdmin() %>" style="<%=(Model.Links == null ? "display: none;" : "")%>">
                <%= Model.Links != null ? Model.Links.Html : "" %>
			</div>

		</div>
	</div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/jquery.nivo.slider.pack.js" type="text/javascript"></script>
    
<% if (this.IsAdmin()) { %>
<% Html.RenderPartial("CKEditor"); %>

<script type="text/javascript">
    CKEDITOR.disableAutoInline = true;
    var config = {
        filebrowserUploadUrl: '<%=Url.Action("Upload", "Files", new { area="Admin" }) %>'
    };
    var f_body = CKEDITOR.inline('f_body', config);
    var f_links = CKEDITOR.inline('f_links', config);
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
