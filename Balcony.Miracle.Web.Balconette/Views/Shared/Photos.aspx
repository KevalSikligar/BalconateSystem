<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IndexModel<GalleryImage>>" %>

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
    #results.photos img {
        height: 200px;
    }
</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="wide-main">
    <div class="cmsblock left">
        <%=Model.Body %>
    </div>        
    <div style="<%=Model.HideFilterBar ? "display: none;" : ""%>">
        <div id="photos-menu" class="display-none">		
		    <div id="b1">
		        <h3>Show Only:</h3>  
                <img id="prog1" src="/images/prog1.gif" alt="progress" />  
		    </div>			
            <%using (Ajax.BeginForm("GetPhotos", null, null, new AjaxOptions { HttpMethod = "POST", OnSuccess = "onsuccess", OnComplete = "oncomplete" }, new { id = "frmLocate" })) { %>	
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
    </div>
    <div id="results" class="photos">
        <% if (Model.Results != null && Model.Results.Any()) { %>
        <% foreach (var photo in Model.Results) { %>		
        <div id="<%=photo.ID%>" class="photo">
            <a class="fancybox" rel="maingal" href="//www.balconette.co.uk<%=photo.ZoomUrl %>" title="<%=photo.Name %>">
                <img src="//www.balconette.co.uk<%=photo.ThumbUrl %>" alt="<%=photo.Description %>"/>
            </a>
            <% if (this.IsAdmin()) { %>
            <a class="delete" href="#">
                X
            </a>
            <% } %>
        </div>
        <% } %>
        <% } else { %>
        <span class="noitems"><%:IndexModel<GalleryImage>.NO_ITEMS_TEXT %></span>
        <% } %>
    </div>
	<p style="text-align: center;margin-top: 50px;"><a href="https://www.balconette.co.uk/glass-balustrade/homepage" title="glass balustrades">Glass Balustrades</a>&nbsp;&nbsp;| &nbsp;<a href="https://www.balconette.co.uk/juliet-balcony/homepage" title="Juliet Balconies">Juliet Balconies</a>&nbsp;&nbsp;| &nbsp;<a href="https://www.balconette.co.uk/curved-doors/homepage" title="Curved Glass">Curved Glass</a>&nbsp; | <a href="https://www.balconette.co.uk/composite-decking/homepage">Composite Decking</a> | &nbsp;<a href="https://www.balconette.co.uk/general/gallery" title="Balcony systems">Photo Galleries</a></p>
</div>
</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="FooterStart" runat="server">
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
<script type="text/javascript">
    var isadmin = parseInt(<%=this.IsAdmin() ? 1 : 0%>);
    <% if (this.IsAdmin()) { %>
    function delImage() {
        if (!confirm("Are you sure?"))
            return false;

        var me = $(this);
        me.hide();
        var fdata = {};
        fdata["[0].ID"] = me.parents(".photo").attr("id");
        fdata["[0].ShouldDelete"] = true;
        $.ajax({
            dataType: "json",
            type: 'POST',
            url: '<%=Url.Action("bulkedit", "images", new { area="admin" })%>',
            data: fdata,
            cache: false,
            complete: function (jqXHR, textStatus) {
                me.show();
            },
            success: function (data, textStatus, xhr) {
                me.parents(".photo").remove();
            }
        });
        return false;
    }
    <% } %>


    $(document).ready(function () {
        if (isadmin) {
            $("#results .photo a.delete").click(delImage);
        }
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
        $("#results > .photo").hide();
        for (var i = 0; i < data.length; i++) {
            var photo = data[i];
            var id = photo.ID;
            var div = $("#" + id);
            if (div.length == 0) {
                var img = $("<img />")
                    .attr("src", photo.ThumbUrl)
                    .attr("alt", photo.Description);

                var href = photo.ZoomUrl;

                div = $("<div />")
                    .attr("id", id)
                    .addClass("photo")
                    .append($("<a />")
                        .attr("href", href)
                        .attr("title", photo.Name)
                        .attr("rel", "maingal")
                        .addClass("fancybox")
                        .append(img))
                    .appendTo($("#results"));

                if (isadmin) {
                    div.append($('<a class="delete">X</a>').click(delImage));
                }
            }
            div.show();
        }
        if (data.length == 0) {
            $("<span />")
                .addClass("noitems")
                .text("<%=IndexModel<GalleryImage>.NO_ITEMS_TEXT %>")
                .appendTo($("#results"));
        }
    }

</script>
</asp:Content>
