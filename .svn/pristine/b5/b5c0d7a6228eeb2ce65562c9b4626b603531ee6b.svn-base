<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>

<%
    string msg = null;
    if (Cache["blog_items"] == null)
    {
        try
        {
            using (var dapt = new MySqlDataAdapter("SELECT p.`post_title`, p.`post_name`, p.`post_date`, m.`meta_value` " +
                                                   "FROM `wp_posts` p " +
                                                   "LEFT JOIN `wp_postmeta` m ON(p.`ID` = m.`post_id` AND m.`meta_key` ='_headspace_description') " +
                                                   "WHERE p.`post_status` = 'publish' AND m. `meta_value` IS NOT NULL " +
                                                   "ORDER BY p.`post_date` DESC LIMIT 10;",
                "server=blog.balconette.co.uk; user id=balconysystems; password=r2lRSqApjH3DUtNM!; database=balconysystems; Allow Zero Datetime=True"))
            {
                var dt = new DataTable();
                dapt.Fill(dt);
                Cache.Insert("blog_items", dt, null, DateTime.Now.AddMinutes(5), System.Web.Caching.Cache.NoSlidingExpiration);
            }
        }
        catch (Exception ex)
        {
            msg = ex.ToString();
        }
    }
    var blogItems = Cache["blog_items"] as DataTable;  
%>
<%:msg %>
<ul class="news-scroller marquee">
    <% if (blogItems != null) { %>
    <% foreach (DataRow row in blogItems.Rows) { %>
        <li>
            <span><a href="<%=String.Format("https://blog.balconette.co.uk/index.php/{0}/", row["post_name"])%>"> <%:row["post_title"] %></a></span>
            <label><%:String.Format("{0:d MMMM yyyy}", row["post_date"]) %></label>
            <p>
                <%:(row["meta_value"].ToString().Substring(0, Math.Min(row["meta_value"].ToString().Length, 140)) + "...") %>
            </p>
        </li>
    <% } %>
    <% } %>
</ul>

