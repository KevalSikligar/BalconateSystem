<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Balcony.Miracle.Web.Models.ChangePasswordModel>" %>



<asp:Content ID="changePasswordContent" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h1>Change Password.</h1>        
        <h2>Use this form to change your password.</h2>
    </hgroup>

    <p class="message-info">
        Passwords must be at least <%: Membership.MinRequiredPasswordLength %> characters long.
    </p>

    <% using (Html.BeginForm()) { %>
        <%: Html.ValidationSummary() %>

        <fieldset>
            <legend>Change Password Form</legend>
            <ol>
                <li>
                    <%: Html.LabelFor(m => m.OldPassword) %>
                    <%: Html.PasswordFor(m => m.OldPassword) %>        
                </li>
                <li>
                    <%: Html.LabelFor(m => m.NewPassword) %>
                    <%: Html.PasswordFor(m => m.NewPassword) %>                    
                </li>
                <li>
                    <%: Html.LabelFor(m => m.ConfirmPassword) %>
                    <%: Html.PasswordFor(m => m.ConfirmPassword) %>                    
                </li>
            </ol>
            <input type="submit" value="Change password" />
        </fieldset>
    <% } %>
</asp:Content>

<asp:Content ID="scriptsContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
</asp:Content>
