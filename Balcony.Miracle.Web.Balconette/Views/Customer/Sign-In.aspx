<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<SignInModel>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<style type="text/css">
    label {
        width: 70px;
        display: inline-block;
        text-align: right;
        margin-right: 10px;
    }
    h1 { margin-bottom: 20px;}
    #forgot_pass { cursor: pointer;font-weight: bold; }
</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="main">
	<ul id="cookie-menu">
		<li><a href="/">Home</a></li>
        <% if (ViewBag.Area != AreaKind.General) { %>
        <li><a href="<%=ViewBag.AreaUrl %>"><%:ViewBag.AreaName %></a></li>
		<% } %>
		<li class="last">Sign In</li>
	</ul>
    <h1>Sign In to Balcony Systems</h1>
    <p>
        Please fill in your details. <%:ViewBag.Area %>
    </p>
    <% using(Html.BeginForm(null, null, FormMethod.Post, new { id="frm" } )) {%>
    <div>
        <%:Html.HiddenFor(m => m.Redirect) %>
        <input type="hidden" name="areas" value="<%:ViewBag.Area %>"/>

        <%:Html.Partial("SignIn", Model) %>


        <%:Html.ValidationSummary(true) %>
        <p>
            <input type="submit" class="area_color k-button  bold" value="Sign In ..." />
        </p>
    </div>
    <% } %>
    <div>
        <p>
            Forgot your password? <a id="forgot_pass">Click here</a>
        </p>
    </div>
</div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
<script type="text/javascript">
    $(document).ready(function () {
        $("#forgot_pass").click(function() {
            var btn = $(this);
            btn.hide();
            $.ajax({
                dataType: "json",
                type: 'POST',
                url: '<%=Url.Action("forgot-password")%>',
                data: {
                    email: $("#Email").val()
                },
                cache: false,
                complete: function (jqXHR, textStatus) {
                    btn.show();
                }
            });
        });
    });
</script>
</asp:Content>
