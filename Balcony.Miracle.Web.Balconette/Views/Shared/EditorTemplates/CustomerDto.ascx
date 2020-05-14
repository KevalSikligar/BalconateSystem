<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<CustomerDto>" %>

<p>
    <label>Title:</label>
    <%:Html.TextBoxFor(m => m.Title, new { @class = "k-textbox customer_title" })%>
</p>
<p>
    <label>First name:</label>
    <%:Html.TextBoxFor(m => m.FirstName, new { @class = "k-textbox", style = "width: 150px;" })%>
    <%:Html.ValidationMessageFor(m => m.FirstName) %>
</p>
<p>
    <label>Last name:</label>
    <%:Html.TextBoxFor(m => m.LastName, new { @class = "k-textbox", style = "width: 150px;" })%>
    <%:Html.ValidationMessageFor(m => m.LastName) %>
</p>
<p>
    <label>Email:</label>
    <%:Html.TextBoxFor(m => m.Email1, new { @class = "k-textbox", style = "width: 250px;" })%>
    <%:Html.ValidationMessageFor(m => m.Email1) %>
</p>

<% if (!Model.SingleEmail) { %>
<p>
    <label>Retype email:</label>
    <%:Html.TextBoxFor(m => m.Email2, new { @class = "k-textbox noclipboard", style = "width: 250px;" })%>
    <%:Html.ValidationMessageFor(m => m.Email2) %>
</p>
<% } %>

<p>
    <label>Company name:</label>
    <%:Html.TextBoxFor(m => m.CompanyName, new { @class = "k-textbox", style = "width: 250px;" })%>
</p>

<p>
    <label>Category:</label>
    <%:Html.TextBoxFor(m => m.CatalogId, new { })%>
    <%:Html.ValidationMessageFor(m => m.CatalogId) %>
</p>
 
<% if (!Model.HideAddress) { %>
<p>
    <label>Postcode:</label>
    <%:Html.TextBoxFor(m => m.PostCode, new { @class = "k-textbox", style = "width: 150px;" })%>
   <input type="button" value="Address lookup" onclick="getaddresses()" class="k-button bold"/><div id="postcode_not_found" style="color:#CC0000;margin-left:115px;display:none;font-size:smaller;">Postcode not recognized</div>
    <div id ="listView" class="k-input" style="display:none;width:auto;margin-top:-10px;margin-left:115px;padding:4px;"></div>
    <%:Html.ValidationMessageFor(m => m.PostCode,"",new { id="span_postcode_err"}) %>
</p>

<p>
    <label>House:</label>
    <%:Html.TextBoxFor(m => m.House, new { @class = "k-textbox", style = "width: 250px;" })%>
    <%:Html.ValidationMessageFor(m => m.House) %>
</p>
<p>
    <label>Street:</label>
    <%:Html.TextBoxFor(m => m.Street, new { @class = "k-textbox", style = "width: 250px;" })%>
    <%:Html.ValidationMessageFor(m => m.Street) %>
</p>
<p>
    <label>Town:</label>
    <%:Html.TextBoxFor(m => m.Town, new { @class = "k-textbox", style = "width: 250px;" })%>
</p>

<p>
    <label>Country:</label>
    <%:Html.TextBoxFor(m => m.CountryId, "", new { })%>
    <%:Html.ValidationMessageFor(m => m.CountryId) %>
</p>
<p>
    <label>Region:</label>
    <%:Html.TextBoxFor(m => m.RegionId, "", new { disabled="disabled" })%>
    <%:Html.ValidationMessageFor(m => m.RegionId) %>
</p>
<p>
    <label>Sub region:</label>
    <%:Html.TextBoxFor(m => m.SubRegionId, new { disabled="disabled" })%>
    <%:Html.ValidationMessageFor(m => m.SubRegionId) %>
</p>
<% } %>
<p>
    <label>Phone:</label>
    <%:Html.TextBoxFor(m => m.Phone, new { @class = "k-textbox only-numbers", style = "width: 150px;" })%>
</p>

<% if (!Model.MobileHidden) { %>
<p>
    <label>Mobile:</label>
    <%:Html.TextBoxFor(m => m.Mobile, new { @class = "k-textbox only-numbers", style = "width: 150px;" })%>
</p>
<% } %>

<% if (!Model.FaxHidden) { %>
<p>
    <label>Fax:</label>
    <%:Html.TextBoxFor(m => m.Fax, new { @class = "k-textbox only-numbers", style = "width: 150px;" })%>
</p>
<% } %>












