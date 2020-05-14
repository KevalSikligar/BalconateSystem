<%@ Page Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="ViewPage<IList<CaseStudy>>" %>



<asp:Content ID="Content1" ContentPlaceHolderID="HeadStart" runat="server">
    <title>Case Studies Index</title>
</asp:Content>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <h1>Case Studies Index</h1>
    <%:Html.ActionLink("Create Case Study", "edit") %>
    <hr/>
    <table class="indextable">
        <thead>
            <tr>
                <th>Inx</th>
                <th>Name</th>
                <th>Url</th>                
                <th>Title</th>
                <th>Area</th>
                <th>Keywords</th>
                <th>Description</th>
                <th>Tags</th>
            </tr>
        </thead>
        <tbody>
            <% var i = 0; %>
            <% foreach (var page in Model) { %>
            <% var url = Url.Action("case-studies", page.Area.ID.ToString(), new { area="", id = page.Url }); %>
            <tr class="<%:i % 2 != 0 ? "alt" : "" %>">
                <td><%:page.Inx %></td>
                <td><%:Html.ActionLink(page.Name, "Edit", new { id = page.ID }) %></td>
                <td><a target="_blank" href="<%=url %>"><%:url %></a></td>
                <td><%:page.Title %></td>
                <td><%:page.Area.Name %></td>
                <td><%:page.Keywords %></td>
                <td><%:page.Description %></td>
                <td>
                    <% foreach(var tag in page.Tags) { %> 
                    <span style="white-space: nowrap"><%:tag.Name %></span><br/>
                    <% } %>
                </td>
            </tr>
            <% i++; %>
            <% } %>
        </tbody>
        <tfoot></tfoot>
    </table>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FooterEnd" runat="server">
    
</asp:Content>