<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IndexModel<CustomerReview>>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadStart" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<style type="text/css">
    .tc strong { font-weight: bold; }
    .tc p { height: 16px; clear: both; margin: 5px 0 5px 0; }
    .tc label { cursor: pointer; }
    .tc .labeledCheckbox { cursor: pointer; }
    h1 { margin-bottom: 15px; }
    .grip {
        margin-bottom: 15px;
    }
    .grip a {
        cursor: pointer;
    }
    .grip span {
        display: inline-block;
        width: 16px;
        height: 16px;
    }
    #results span.noitems {
        font-weight: bold;
    }
    #results {
        clear: both;
        text-align: center;
    }
</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="wide-main">
    <div class="cmsblock">
        <%=ViewBag.Body %>
    </div>
    <div id="articles-menu" class="display-none">
        <%using (Ajax.BeginForm("GetCustomerReviews", null, null, new AjaxOptions { HttpMethod = "POST", OnSuccess = "onsuccess", OnComplete = "oncomplete" }, new { id = "frmLocate" })) { %>	
        <%:Html.Hidden("area", Model.AreaKind) %>
		<div id="b1">
		    <h3>Show Only:</h3>  
            <img id="prog1" src="/images/prog1.gif" alt="progress" />  
		</div>			
        <% foreach (var tc in Model.TagCategories) { %>                
        <div class="col tc">
            <strong><%:tc.Key.Name %> <% if (tc.Key.ShowDesc) { %> <a class="fancybox fancybox.iframe" data-fancybox-width="450" href="<%=Url.Action("tag-category-description", "tags", new { id=tc.Key.ID, area="" }) %>">(?)</a> <% } %></strong>
            <% foreach (var tag in tc) { %>
			<p class="tc">
				<input type="checkbox" class="labeledCheckbox" name="<%="chb_" + tag.ID %>" id="chb_<%=tag.ID.ToString() %>" value="<%=tag.ID.ToString() %>" <%=Model.Tags.Contains(tag) ? "checked=\"checked\"" : "" %>/>
				<label style="float: left;" for="chb_<%=tag.ID.ToString() %>"><%:tag.Name %>&nbsp;</label>
                <% if (tag.ShowDesc) { %>  <a style="float: left;" class="fancybox fancybox.iframe" data-fancybox-width="450" href="<%=Url.Action("tag-description", "tags", new { id=tag.ID, area="" }) %>">(?)</a> <% } %>
			</p>
            <% } %>
        </div>
        <% } %>
        <% } %>
	</div>
    <div class="grip">
        <a class="show">Show Filter</a><span class="k-icon k-i-arrow-s"></span>
    </div>
    <div id="results">
        <% if (Model.Results != null && Model.Results.Any()) { %>
        <% foreach (var article in Model.Results) { %>
        <% var url = Url.Action("customer-reviews", article.Area.ID.ToString(), new { id = article.Url }); %>
		<div id="<%=article.ID %>" class="article">
		    <a href="<%=url %>" class="title"><%:article.ThumbTitleDisplay %></a>
            <a href="<%=url %>" class="img">
                <img class="<%=article.Image == null? "nothumb" : ""%>" src="<%=article.Image == null ? "/images/article-no-thumb.jpg" : article.Image.ThumbUrl %>" alt="<%=article.Description %>" />
                <span>Read Article</span>
            </a>
            <div class="desc">
                <%:article.ThumbDescriptionDisplay %>
            </div>
		</div>
        <% } %>
        <% } else { %>
        <span class="noitems"><%:IndexModel<CustomerReview>.NO_ITEMS_TEXT %></span>
        <% } %>
    </div>
</div>
</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="FooterStart" runat="server">
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
    
<script type="text/javascript">
    $(document).ready(function () {

        $(".grip a").click(function() {
            if ($(this).hasClass("show")) {
                $(this).html("Hide Filter");
                $(".grip span").removeClass("k-i-arrow-s").addClass("k-i-arrow-n");
                $(this).removeClass("show");
                $("#articles-menu").slideDown();
            } else {
                $(this).html("Show Filter");
                $(".grip span").removeClass("k-i-arrow-n").addClass("k-i-arrow-s");
                $(this).addClass("show");
                $("#articles-menu").slideUp();
            }
        });

        //$("#results .article").ellipsis();

        $(".labeledCheckbox").change(function () {
            $("#prog1").show();
            $("#frmLocate").submit();
        });
    });
    
    function oncomplete() {
        $("#prog1").hide();
    }

    function onsuccess(data, textStatus, xhr) {
        $("#results span.noitems").remove();
        $("#results div.article").hide();
        for (var i = 0; i < data.length; i++) {
            var article = data[i];
            var id = article.ID;
            var div = $("#" + id);
            if (div.length == 0) {
                var img = $("<img />")
                    .attr("src", article.Image ? article.Image.ThumbUrl : "/images/article-no-thumb.jpg")
                    .addClass(article.Image ? null : "nothumb")
                    .attr("alt", article.Description);

                var href = article.Url;
                //kendo.toString(article.DateCreated.fromJsonDate(), "d MMMM yyyy")

                div = $("<div />")
                    .attr("id", id)
                    .addClass("article")
                    .append($('<a class="title"/>')
                        .attr("href", href)
                        .text(article.ThumbTitleDisplay))

                    .append($('<a class="img" />')
                            .attr("href", href)
                            .append(img)
                            .append($("<span>Read Article</span>")))
                        

                    .append($('<div class="desc" />').text(article.ThumbDescriptionDisplay))

                    .appendTo($("#results"));
                    //.ellipsis();
            }
            div.show();
        }
        if ($("#results div.article").length == 0) {
            $("<span />")
                .addClass("noitems")
                .text("<%=IndexModel<CustomerReview>.NO_ITEMS_TEXT %>")
                .appendTo($("#results"));
        }
    }
</script>

</asp:Content>
