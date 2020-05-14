<%@ Page Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="ViewPage<IList<BalustradeModel>>" %>



<asp:Content ID="Content1" ContentPlaceHolderID="HeadStart" runat="server">
    <title>Balustrade Models Index</title>
</asp:Content>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <h1>Balustrade Models Index</h1>
    <%:Html.ActionLink("Create Model", "Edit") %>
    <hr/>
    <table class="indextable">
        <thead>
            <tr>
                <th>Name</th>
            </tr>
        </thead>
        <tbody>
            <% var i = 0; %>
            <% foreach (var bm in Model) { %>
            <tr class="<%:i % 2 != 0 ? "alt" : "" %>">
                <td><%:Html.ActionLink(bm.Name, "Edit", new { id = bm.ID }) %></td>
            </tr>
            <% i++; %>
            <% } %>
        </tbody>
        <tfoot></tfoot>
    </table>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FooterEnd" runat="server">
    
</asp:Content>