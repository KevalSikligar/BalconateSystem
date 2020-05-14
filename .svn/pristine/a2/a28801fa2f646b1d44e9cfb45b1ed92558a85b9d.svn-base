<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IndexModel<UploadedFile>>" %>
<%@ Import Namespace="Balcony.Miracle.Web.Extensions" %>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadStart" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<style type="text/css">
    .tc strong { font-weight: bold; }
    .tc p { height: 16px; clear: both; margin: 5px 0 5px 0; }
    .tc label { cursor: pointer; }
    .tc .labeledCheckbox { cursor: pointer; }
    h1 { margin-bottom: 15px; }
    #results {
        clear: both;
    }
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
</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="main">
    <div class="cmsblock">
        <%=ViewBag.Body %>
    </div>
    <div id="photos-menu" class="display-none">		
		<div id="b1">
		    <h3>Show Only:</h3>  
            <img id="prog1" src="/images/prog1.gif" alt="progress" />  
		</div>			
        <%using (Ajax.BeginForm("GetDownloads", null, null, new AjaxOptions { HttpMethod = "POST", OnSuccess = "onsuccess", OnComplete = "oncomplete" }, new { id = "frmLocate" })) { %>	
        <%:Html.Hidden("area", Model.AreaKind) %>
        <% foreach (var tc in Model.TagCategories) { %>                
        <div class="col tc">
            <strong><%:tc.Key.Name %> <% if (tc.Key.ShowDesc) { %> <a class="fancybox fancybox.iframe" data-fancybox-width="450" href="<%=Url.Action("tag-category-description", "tags", new { id=tc.Key.ID, area="" }) %>">(?)</a> <% } %></strong>
            <% foreach (var tag in tc) { %>
			<p class="tc">
				<input type="checkbox" class="labeledCheckbox" name="<%="chb_" + tag.ID%>" id="<%="chb_" + tag.ID%>" value="<%=tag.ID.ToString() %>" <%=Model.Tags.Contains(tag) ? "checked=\"checked\"" : "" %>/>
				<label style="float: left;" for="<%="chb_" + tag.ID%>"><%:tag.Name %>&nbsp;</label>
                <% if (tag.ShowDesc) { %> <a style="float: left;" class="fancybox fancybox.iframe" data-fancybox-width="450" href="<%=Url.Action("tag-description", "tags", new { id=tag.ID, area="" }) %>">(?)</a> <% } %>
			</p>
            <% } %>
        </div>
        <% } %>
        <% } %>
	</div>
    <div class="grip">
        <a class="show">Show Filter</a><span class="k-icon k-i-arrow-s"></span>
    </div>
    <div id="results" class="downloads">
        <% if (Model.Results != null && Model.Results.Any()) { %>
        
        <table>
            <% foreach (var download in Model.Results) { %>		
            <tr id="<%=download.ID%>" class="download">
                <td class="img">
                    <a href="<%=download.Url %>" target="_blank">
                        <img src="/images/file-types/48/<%=download.Extension %>.png" alt="Click to Download File"/>
                    </a>
                </td>
                <td class="name">
                    <a href="<%=download.Url %>" target="_blank">
                        <%=download.Name %>
                    </a>
                </td>
                <td>
                    <%=download.Description %>
                </td>
                <td class="ta-right"><%=download.Size.ToFileSize() %></td>
            </tr>
            <% } %>
        </table>

        <% } else { %>
        <span class="noitems"><%:IndexModel<UploadedFile>.NO_ITEMS_TEXT %></span>
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
                $("#photos-menu").slideDown();
            } else {
                $(this).html("Show Filter");
                $(".grip span").removeClass("k-i-arrow-n").addClass("k-i-arrow-s");
                $(this).addClass("show");
                $("#photos-menu").slideUp();
            }
        });

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
        $("#results tr.download").hide();
        var resultsContainer = $("#results");
        var table = resultsContainer.find("table");

        for (var i = 0; i < data.length; i++) {
            var download = data[i];
            var id = download.ID;
            var tr = $("#" + id);
            if (tr.length == 0) {

                tr = $("<tr />")
                    .attr("id", id)
                    .addClass("download")
                    .append($("<td />")
                        .append($('<a target="_blank" />').attr("href", download.Url)
                            .append($("<img />").attr("src", "/images/file-types/48/" + download.Extension + ".png"))))

                    .append($("<td />").append($('<a target="_blank" />').text(download.Name).attr("href", href)))

                    .append($("<td />").text(download.Description))

                    .append($("<td />").text(new Number(download.Size / (1024 * 1024)).toFixed(2)))

                    .appendTo(table);

            }
            tr.show();
        }
        if (data.length == 0) {
            $("<span />")
                .addClass("noitems")
                .text("<%=IndexModel<UploadedFile>.NO_ITEMS_TEXT %>")
                .appendTo(resultsContainer);
        }
    }

</script>
</asp:Content>
