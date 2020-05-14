<%@ Page Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="ViewPage<IList<Tag>>" %>



<asp:Content ID="Content1" ContentPlaceHolderID="HeadStart" runat="server">
    <title>Tags Index</title>
</asp:Content>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <h1>Tags Index</h1>
    <%:Html.ActionLink("Create Tag", "edit") %>
    <hr/>
    <table class="indextable">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Categoty</th>
                <th>Inx</th>
            </tr>
        </thead>
        <tbody>
            <% var i = 0; %>
            <% foreach (var tag in Model) { %>
            <tr class="<%:i % 2 != 0 ? "alt" : "" %>">
                <td><%:tag.ID %></td>
                <td><%:Html.ActionLink(tag.Name, "Edit", new { id = tag.ID }) %></td>
                <td><%:Html.ActionLink(tag.TagCategory.Name, "Edit", "TagCategories", new { id = tag.TagCategory.ID }, null) %></td>
                <td><%:tag.Inx %></td>
            </tr>
            <% i++; %>
            <% } %>
        </tbody>
        <tfoot></tfoot>
    </table>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FooterEnd" runat="server">
    
</asp:Content>