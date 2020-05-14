<%@ Page Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="ViewPage<IList<CustomerReview>>" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadStart" runat="server">
    <title>Customer Reviews Index</title>
</asp:Content>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <h1>Customer Reviews Index</h1>
    <%:Html.ActionLink("Create Customer Review", "edit") %>
    <hr/>
    <table class="indextable">
        <thead>
            <tr>
                <th>Area</th>
                <th>Name</th>
                <th>Url</th>
                <th>Title</th>     
                <th>Date Created</th>
                <th>Visible</th>
            </tr>
        </thead>
        <tbody>
            <% var i = 0; %>
            <% foreach (var reviewGroup in Model.GroupBy(p => p.Area)) { %>
            <% var first = true; %>
            <% foreach (var review in reviewGroup) { %>
            <tr class="<%:i % 2 != 0 ? "alt" : "" %>">
                <% if (first) { %>
                <td rowspan="<%:reviewGroup.Count() %>" style="background-color: #fff;"><%:review.Area.Name %></td>
                <% } %>
                <td><%:Html.ActionLink(review.Name, "Edit", new { id = review.ID }) %></td>
                <td><a target="_blank" href="<%=Url.Action("customer-reviews", review.Area.ID.ToString(), new { id=review.ID, area = "" }) %>"><%:Url.Action("customer-reviews", review.Area.ID.ToString(), new { id=review.ID, area = "" }) %></a></td>
                <td><%:review.Title %></td>
                <td><%:review.DateCreated %></td>
                <td><%:(review.Visible ? "Yes" : "No") %></td>
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