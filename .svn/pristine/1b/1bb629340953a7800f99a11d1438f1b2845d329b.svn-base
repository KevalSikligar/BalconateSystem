<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<StandardPageModel>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<%= Model.Page.Head %> 
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<% if (Model.Page.UseTemplate) { %>
	<div class="main">
        <ul id="cookie-menu">
			<li><a href="/">HOME</a></li>
            <% if (Model.Page.Area.ID != AreaKind.General) { %>
            <li><a href="<%=Url.Action("", Model.Page.Area.ID.ToString().ToLower()) %>"><%: Model.Page.Area.Name.ToUpper() %></a></li>
			<% } %>
            <li class="last"><%:Model.Page.Name.ToUpper() %></li>
		</ul>
        <div id="f_body" class="cmsblock left" contenteditable="<%:this.IsAdmin().ToString().ToLower() %>">
        <%= Model.Body %> 
        </div>
		<div class="right">
			<% Html.RenderPartial("leftsidebar"); %>
		</div>
	</div>
<% } else { %>
    <div id="f_body" class="cmsblock" contenteditable="<%:this.IsAdmin().ToString().ToLower() %>">        
    <%= Model.Body %> 
    </div>
<% } %>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
<% if (this.IsAdmin() && !MvcApplication.DisableInlineEditing) { %>
<% Html.RenderPartial("CKEditor"); %>

<script type="text/javascript">
    var f_body = CKEDITOR.inline('f_body');
    $(document).ready(function () {

        $("#adminsave").click(function () {
            var btn = $(this);
            btn.hide();
            $.ajax({
                dataType: "json",
                type: 'POST',
                url: '<%=Url.Action("Save", "Pages", new { area="Admin" })%>',
                data: {
                    id: "<%=Model.Page.ID %>",
                    f_name: $("#f_name").val(),
                    f_body: f_body.getData(),
                    f_title: $("#f_title").val(),
                    f_desc: $("#f_desc").val(),
                    f_keywords: $("#f_keywords").val(),
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
                <th>Name</th>
                <td><input id="f_name" value="<%=Model.Page.Name %>" type="text" class="k-textbox" style="width: 70%;" /></td>
            </tr>
            <tr>
                <th>Title</th>
                <td><input id="f_title" value="<%=Model.Page.Title %>" type="text" class="k-textbox" style="width: 70%;" /></td>
            </tr>
            <tr>
                <th>Description</th>
                <td><input id="f_desc" value="<%=Model.Page.Description %>" type="text" class="k-textbox" style="width: 70%;" /></td>
            </tr>
            <tr>
                <th>Keywords</th>
                <td><input id="f_keywords" value="<%=Model.Page.Keywords %>" type="text" class="k-textbox" style="width: 70%;" /></td>
            </tr>
        </table>
    </div>
</div>

<% } %>
<%=Model.Page.Footer %> 
</asp:Content>
