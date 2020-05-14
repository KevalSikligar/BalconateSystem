<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<UnsubscribeModel>" %>
<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<style type="text/css">
    label {
        width: 100px;
        display: inline-block;
        text-align: right;
        margin-right: 10px;
    }
</style>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script type="text/javascript">
    function ajaxComplete() {
        if (grecaptcha) {
            grecaptcha.reset();
        }
    }
</script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
    <div class="main">
        <h1>Unsubscribe</h1>
        <% using (Ajax.BeginForm(null, null, new AjaxOptions{HttpMethod = "POST", OnComplete = "ajaxComplete"}, new { id = "frm"})) { %>
            <div class="form">
                <p>
                    <label>Email Address:</label>
                    <%:Html.TextBoxFor(m => m.Email, new { @class = "k-textbox", style="width: 150px;" })%>
                    <%:Html.ValidationMessageFor(m => m.Email) %>
                </p>
                <%:Html.Partial("Captcha") %>
                <p style="margin-top: 10px;">
                    <input class="k-button bold" type="submit" value="Unsubscribe" />
                </p>
            </div>
        <% } %>
    </div>
</asp:Content>

