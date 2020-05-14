<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<CustomerReview>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
	<div class="main">
		<div class="left">
		<ul id="cookie-menu">
			<li><a href="/">Home</a></li>
            <% if (Model.Area.ID != AreaKind.General) { %>
            <li><a href="<%=ViewBag.AreaUrl %>"><%: Model.Area.Name %></a></li>
			<% } %>
            <li><a href="/general/reviews">Customer Reviews</a></li>
            <li class="last"><%:Model.Name %></li>
		</ul>
        <h1 id="f_name" contenteditable="<%:this.IsAdmin() %>">
            <%: Model.Name %>
        </h1>
		<p class="toplinksp"><a href="/glass-balustrade/homepage" title="Glass Balustrades">Glass Balustrades</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/juliet-balcony/homepage" title="Juliet Balconies">Juliet Balconies</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/curved-doors/homepage" title="Curved Glass Doors">Curved Glass Doors</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/composite-decking/homepage" title="Decking">Decking</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/general/balcony-projects" title="Balcony Systems Projects">Projects</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/general/gallery" title="Balcony Systems Photos">Galleries</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/general/encyclopaedia" title="Balcony Systems Articles">Articles</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/general/reviews" title="Balcony Systems Reviews">Reviews</a></p>
		<div class="left">		
			<div id="f_body" class="cmsblock articlesingle left" contenteditable="<%:this.IsAdmin() %>">
				<%= Model.Body %>    
			</div>                				
            <div>
                <a href="/general/reviews" class="k-button area_color bold">Back to Customer Reviews</a>
            </div>
		</div>
		</div>
		<div class="right">
		
		<% Html.RenderPartial("leftsidebar"); %>            
		</div>
	</div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
<% if (this.IsAdmin() && !MvcApplication.DisableInlineEditing) { %>
<% Html.RenderPartial("CKEditor"); %>

<script type="text/javascript">
    var hasLinks = $("#f_links").length > 0;
    var hasAreaLinks = $("#f_area_links").length > 0;
    var f_body = CKEDITOR.inline('f_body');
    var f_links = hasLinks ? CKEDITOR.inline('f_links') : null;
    var f_area_links = hasAreaLinks ? CKEDITOR.inline('f_area_links') : null;

    $(document).ready(function () {

        $("#adminsave").click(function () {
            var btn = $(this);
            btn.hide();
            $.ajax({
                dataType: "json",
                type: 'POST',
                url: '<%=Url.Action("Save", "Articles", new { area="Admin" })%>',
                data: {
                    id: "<%=Model.ID %>",
                    name: $("#f_name").html(),
                    body: f_body.getData(),
                    title: $("#f_title").val(),
                    desc: $("#f_desc").val(),
                    keywords: $("#f_keywords").val(),
                    links: hasLinks ? f_links.getData() : "",
                    areaLinks: f_area_links ? f_area_links.getData() : ""
                },
                cache: false,
                complete: function(jqXHR, textStatus) {
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
                <td><input id="f_title" value="<%=Model.Title %>" type="text" class="k-textbox" style="width: 70%;" /></td>
            </tr>
            <tr>
                <th>Description</th>
                <td><input id="f_desc" value="<%=Model.Description %>" type="text" class="k-textbox" style="width: 70%;" /></td>
            </tr>
            <tr>
                <th>Keywords</th>
                <td><input id="f_keywords" value="<%=Model.Keywords %>" type="text" class="k-textbox" style="width: 70%;" /></td>
            </tr>
        </table>
    </div>
</div>

<% } %>
</asp:Content>
