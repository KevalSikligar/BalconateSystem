<%@ Page Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="ViewPage<IList<TagCategory>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadStart" runat="server">
    <title>Tag Categories Index</title>
</asp:Content>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <h1>Tag Categories Index</h1>
    <%:Html.ActionLink("Create Tag Category", "edit") %>
    <hr/>
    <table class="indextable">
        <thead>
            <tr>
                <th>Name</th>
                <th>Inx</th>
            </tr>
        </thead>
        <tbody>
            <% var i = 0; %>
            <% foreach (var tagCategory in Model) { %>
            <tr class="<%:i % 2 != 0 ? "alt" : "" %>">
                <td><%:Html.ActionLink(tagCategory.Name, "edit", new { id = tagCategory.ID }) %></td>
                <td><%:tagCategory.Inx %></td>
            </tr>
            <% i++; %>
            <% } %>
        </tbody>
        <tfoot></tfoot>
    </table>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FooterEnd" runat="server">
    
</asp:Content>