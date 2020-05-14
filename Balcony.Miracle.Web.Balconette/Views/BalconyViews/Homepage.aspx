<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<Area>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
    <link rel="stylesheet" type="text/css" href="/content/nivoslider/nivo-slider.css" />
    <link rel="stylesheet" type="text/css" href="/content/nivoslider/default.css" />
    <link rel="stylesheet" type="text/css" href="/content/nivoslider/sidebar.css" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
	<div class="main">
		<ul id="cookie-menu">
			<li><a href="/">HOME</a></li>
			<li class="last">BALCONY VIEWS MAGAZINE</li>
		</ul>
		<h1 id="f_h1" contenteditable="<%:this.IsAdmin() %>"><%=Model.HomepageH1 %></h1>
        <div class=""  id="f_body" contenteditable="<%:this.IsAdmin() %>">
		    <%=Model.HomepageBody %>
        </div>
	</div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/jquery.nivo.slider.pack.js" type="text/javascript"></script>
    
<% if (this.IsAdmin()) { %>
<% Html.RenderPartial("CKEditor"); %>

<script type="text/javascript">
    var f_body = CKEDITOR.inline('f_body');
    //var f_links = CKEDITOR.inline('f_links');
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
                    f_links: null
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
