<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SignInModel>" %>

<p>
    <label>Email:</label>
    <%:Html.TextBoxFor(m => m.Email, new { @class="k-textbox", style="width: 250px" }) %>
    <%:Html.ValidationMessageFor(m => m.Email) %>
</p>
<p>
    <label>Password:</label>
    <%:Html.PasswordFor(m => m.Password, new { @class="k-textbox", style="width: 250px" }) %>
    <%:Html.ValidationMessageFor(m => m.Password) %>
</p>
<p style="padding-left: 115px;">
    <%:Html.CheckBoxFor(m => m.StaySignedIn, new { @class="labeledCheckbox" }) %>
    <%:Html.LabelFor(m => m.StaySignedIn, "Stay Signed In", new { @class="checkboxLabel", style="width: auto;" }) %>
</p>
