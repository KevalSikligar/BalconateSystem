<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<Balcony.Miracle.Web.Areas.Admin.Models.SignInModel>" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content="width=device-width" />
    <title>SignIn</title>
    <link href="/content/reset.css" rel="stylesheet" />
    <link href="/content/admin.css" rel="stylesheet" />
    <link href="/content/kendo.common.min.css" rel="stylesheet" />
    <link href="/content/kendo.default.min.css" rel="stylesheet" />

    <style type="text/css">
        #box
        {
            width: 300px;            
            margin: 50px auto;
        }
    </style>
</head>
<body>
    <div id="box" class="k-block">
        <div class="k-header">Please Sign In:</div>
        <div class="pad10">
            <% using (Html.BeginForm(null, null, FormMethod.Post)) { %>
                <%:Html.HiddenFor(m => m.Redirect) %>
                <p><%:Html.TextBoxFor(m => m.Username, new { @class="k-textbox", placeholder="Username", autocomplete="off" }) %><%:Html.ValidationMessageFor(m => m.Username) %></p>
                <p><%:Html.PasswordFor(m => m.Password, new { @class="k-textbox", placeholder="Password", autocomplete="off" }) %><%:Html.ValidationMessageFor(m => m.Password) %></p>
                <%:Html.ValidationSummary(true) %>
                <p><input type="submit" value="Sign In..." class="k-button" /></p>
            <% } %>
        </div>
    </div>

    <script src="/scripts/jquery-1.9.1.min.js" type="text/javascript"></script>    
    <script src="/scripts/jquery.unobtrusive-ajax.js" type="text/javascript"></script>    
    <script src="/scripts/jquery.validate.js" type="text/javascript"></script>
    <script src="/scripts/jquery.validate.unobtrusive.js" type="text/javascript" ></script>
    
</body>
</html>
