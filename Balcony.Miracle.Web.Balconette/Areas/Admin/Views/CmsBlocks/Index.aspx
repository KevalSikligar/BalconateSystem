<%@ Page Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="ViewPage<IList<CmsBlock>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadStart" runat="server">
    <title>CMS Blocks Index</title>
</asp:Content>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <h1>CMS Blocks Index</h1>
    <%:Html.ActionLink("Create Block", "edit") %>
    <hr/>
    <table class="indextable">
        <thead>
            <tr>
                <th>Name</th>
            </tr>
        </thead>
        <tbody>
            <% var i = 0; %>
            <% foreach (var block in Model) { %>
            <tr class="<%:i % 2 != 0 ? "alt" : "" %>">
                <td><%:Html.ActionLink(block.Name, "edit", new { id = block.ID }) %></td>
            </tr>
            <% i++; %>
            <% } %>
        </tbody>
        <tfoot></tfoot>
    </table>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FooterEnd" runat="server">
    
</asp:Content>