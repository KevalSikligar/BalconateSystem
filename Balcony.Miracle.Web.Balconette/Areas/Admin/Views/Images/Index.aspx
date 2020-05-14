<%@ Page Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="ViewPage<dynamic>" %>

<asp:Content ContentPlaceHolderID="HeadStart" runat="server">
    <title>Images Index</title>
</asp:Content>

<asp:Content ContentPlaceHolderID="HeadEnd" runat="server">
    <link rel="stylesheet" type="text/css" href="/content/uploadify/uploadify.css" />
    <style type="text/css">
        .tc { 
            float: left;
            margin-right: 15px;
        }
        .tc strong { font-weight: bold; }
        .tc div { height: 16px; clear: both; margin: 5px 0 5px 0; }
        #results {
            clear: both;
            margin-top: 10px;
            border-top: 1px solid black;
        }
        .galimg {

            
            border: 1px solid rgb(219, 219, 219);
            float: left;
            margin: 10px 10px 0 0;

        }
        .galimg img {
            border: 5px solid white;
        }
        #prog1 {
            display: none;
        }
    </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <h1>Images Index</h1>
    <div id="boxes">
        <%using (Ajax.BeginForm("GetPhotos", "Images", null, new AjaxOptions { HttpMethod = "POST", OnSuccess = "onsuccess", OnComplete = "oncomplete" }, new { id = "frmLocate" })) { %>	
        <%foreach (TagCategory tc in ViewBag.TagCategories) { %>
        <div class="tc">
            <strong><%:tc.Name %></strong>            
            <% foreach (var tag in tc.Tags) { %>
            <div>
                <input type="checkbox" class="labeledCheckbox" name="<%="chb_" + tag.ID %>" id="<%="chb_" + tag.ID %>" value="<%=tag.ID.ToString() %>" />    
                <label style="float: left; cursor: pointer;" for="<%="chb_" + tag.ID %>"><%:tag.Name %></label>
            </div>
            <% } %>
        </div>
        <% } %>
        <% } %>
        <div>
            <button class="k-button" id="btn-find">Find</button>
            <br/><br/>
            <button class="k-button" id="save">Save</button>
            <div>
                <img id="prog1" src="/images/prog1.gif" alt="progress" />    
            </div>            
        </div>
    </div>
    <div id="results">
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FooterEnd" runat="server">
    <script src="/scripts/jquery.uploadify.min.js" type="text/javascript"></script>
    <script src="/scripts/kendo.treeview.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#save').click(function () {
                $("#prog1").show();
                saveEditableImages("<%=Url.Action("bulkedit")%>", function() {
                    $("#prog1").hide();
                    alert("save ok");
                });
            });

            $('#btn-find').click(function() {
                $("#prog1").show();
                $("#frmLocate").submit();
            });
        });
        
        function oncomplete(data, textStatus, xhr) {
            $("#prog1").hide();
        }

        function onsuccess(data, textStatus, xhr) {
            var hash = {}, id;
            for (var i = 0; i < data.length; i++) {
                var image = data[i];
                id = "img_" + image.ID;
                hash[id] = true;
                var div = $("#" + id);
                if (div.length == 0) {
                    div = createEditableImage("<%=Url.Action("gettags", "tags", new { area = "" })%>", image)
                        .attr("id", id)
                        .appendTo($("#results"));
                }
            }
            $("#results div.galimg").each(function () {
                id = $(this).attr("id");
                if (hash[id] == undefined) {
                    $(this).remove();
                }
            });
        }
    </script>
</asp:Content>