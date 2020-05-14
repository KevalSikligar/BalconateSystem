<%@ Page Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="ViewPage<IList<StandardPage>>" %>
<%@ Import Namespace="NHibernate.Type" %>



<asp:Content ID="Content1" ContentPlaceHolderID="HeadStart" runat="server">
    <title>Pages Index</title>
</asp:Content>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <h1>Pages Index</h1>
    <%:Html.ActionLink("Create Page", "edit") %>
    <hr/>
    <table class="indextable">
        <thead>
            <tr>
                <th>Area</th>
                <th>Name</th>
                <th>Url</th>                
                <th>Title</th>
            </tr>
        </thead>
        <tbody>
            <% var i = 0; %>
            <% foreach (var pageGroup in Model.GroupBy(p => p.Area)) { %>
            <% var first = true; %>
            <% foreach (var page in pageGroup) { %>
            <tr class="<%:i % 2 != 0 ? "alt" : "" %>">
                <% if (first) { %>
                <td rowspan="<%:pageGroup.Count() %>" style="background-color: #fff;"><%:page.Area.Name %></td>
                <% } %>
                <td><%:Html.ActionLink(page.Name, "Edit", new { id = page.ID }) %></td>
                <td><a target="_blank" href="<%=Url.Action(page.Url, page.Area.ID.ToString(), new { area = "" }) %>"><%:Url.Action(page.Url, page.Area.ID.ToString(), new { area = "" }) %></a></td>
                <td><%:page.Title %></td>
            </tr>
            <% i++; %>
            <% first = false; %>
            <% } %>
            <% } %>
        </tbody>
        <tfoot></tfoot>
    </table>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FooterEnd" runat="server">
    
</asp:Content>