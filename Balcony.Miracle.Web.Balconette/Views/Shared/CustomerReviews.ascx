<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<%
    var reviews = Context.GetDbSession()
        .QueryOver<CustomerReview>()
        .Where(cr => cr.Visible);

    if (ViewData["Area"] != null && ((AreaKind)ViewData["Area"]) != AreaKind.General)
    {
        reviews = reviews.Where(cr => cr.Area.ID == (AreaKind) ViewData["Area"]);
    }
        
    var results = reviews.OrderBy(cr => cr.DateCreated).Desc
        .Take(10)
        .List();
%>

<ul class="customer-reviews-scroller marquee">
    <% foreach (var review in results)  { %>
    <% var body = review.Description ?? ""; %>
        <li>
            <span>
                <a href="<%=Url.Action("customer-reviews", review.Area.ID.ToString(), new { id = review.Url }) %>">
                    <%:review.Title %>
                </a>
            </span>
            <div>
                <% for (var i = 0; i < 5; i++) { %>
                    <img src="<%=String.Format("/images/{0}-star.png", i < review.Rating ? "filled" : "empty")%>"/>
                <% } %>
            </div>
            <label><%:review.DateCreated.ToString("d MMMM yyyy") %></label>
            <p>
                <%:(body.Substring(0, Math.Min(body.Length, 140)) + "...") %>
            </p>
        </li>
    <% } %>
</ul>

