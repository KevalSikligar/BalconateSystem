<%@ Page Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="ViewPage<Article>" %>

<asp:Content ContentPlaceHolderID="HeadEnd" runat="server">
    <link rel="stylesheet" type="text/css" href="/content/uploadify/uploadify.css" />
    <style>
        label {
            display: inline-block;
            width: 110px;
        }

        .leftcol {
            float: left;
            margin-right: 20px;
        }
        .rightcol {
            float: left;            
        }

        #htmleditcont, #htmledit {
            clear: both;
        }
    </style>

</asp:Content>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <h1>Edit - <%: Model.Name %></h1>
    <div>
    <% using (Html.BeginForm(null, null, FormMethod.Post, new { id = "frm" })) { %>
    <input type="hidden" name="ID" value="<%=Model.ID %>"/>

    <div class="leftcol">
        <p><%:Html.ActionLink("Back to index", "Index") %></p>
        <p><input type="submit" value="Save" class="k-button" /><%: ViewBag.Msg ?? ""%></p>
        <p>
            <label>Url</label>
            <%: Html.TextBoxFor(m => m.Url, new { @class = "k-textbox", placeholder = "/articles/[name-with-dashes]", style = "width: 400px;" })%>
            <%: Html.ValidationMessageFor(m => m.Url)%>
        </p>
        <p>
            <label>Name (H1)</label>
            <%: Html.TextBoxFor(m => m.Name, new { @class = "k-textbox", style = "width: 400px;" })%>
            <%: Html.ValidationMessageFor(m => m.Name)%>
        </p>
        <p>
            <label>Thumb Title</label>
            <%: Html.TextBoxFor(m => m.ThumbTitle, new { @class = "k-textbox", style = "width: 400px;" })%>
            <%: Html.ValidationMessageFor(m => m.ThumbTitle)%>
        </p>
        <p>
            <label>Date</label>
            <input type="text" id="DateCreated" name="DateCreated" value="<%=Model.DateCreated.ToString("dd/MM/yyyy HH:mm") %>" />
        </p>
        <p>
            <label>Area</label>
            <%: Html.TextBox("farea", Model.Area != null ? Model.Area.ID.ToString() : "", new { @class = "k-textbox" })%>
        </p>
        <p>
            <label>Index</label>
            <%: Html.TextBoxFor(m => m.Inx)%>
            <%: Html.ValidationMessageFor(m => m.Inx)%>
        </p>
        <p>
            <label>Links Block</label>
            <%: Html.TextBox("links", Model.SharedLinks != null ? Model.SharedLinks.ID.ToString() : "", new { @class = "k-textbox" })%>
        </p>
        <p>
            <label>Page Title</label>
            <%: Html.TextBoxFor(m => m.Title, new { @class = "k-textbox", style = "width: 400px;" })%>
            <%: Html.ValidationMessageFor(m => m.Title)%>
        </p>
        <p>
            <label>Description</label>
            <%: Html.TextBoxFor(m => m.Description, new { @class = "k-textbox", style = "width: 700px;" })%>
            <%: Html.ValidationMessageFor(m => m.Description)%>
        </p>
        <p>
            <label>Thumb Description</label>
            <%: Html.TextBoxFor(m => m.ThumbDescription, new { @class = "k-textbox", style = "width: 700px;" })%>
            <%: Html.ValidationMessageFor(m => m.ThumbDescription)%>
        </p>
        <p>
            <label>Keywords</label>
            <%: Html.TextBoxFor(m => m.Keywords, new { @class = "k-textbox", style = "width: 700px;" })%>
            <%: Html.ValidationMessageFor(m => m.Keywords)%>
        </p>
        <div>
            <label>Image:</label>
            <div>
                <input type="file" name="file_upload" id="file_upload" />    
            </div>
            <div id="imageCont">
                
            </div>
        </div>
    </div>
    <div class="rightcol">
        <label>Tags:</label>
        <div id="tags"></div>
    </div>

    <div id="htmleditcont">
        <%:Html.TextAreaFor(m => m.Body, new { id="htmledit" }) %>
    </div>                      
    <% } %>
    </div>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/kendo.dropdownlist.min.js" type="text/javascript"></script>
<script src="/scripts/kendo.datetimepicker.min.js" type="text/javascript"></script>
<script src="/scripts/kendo.treeview.min.js" type="text/javascript"></script>
<script src="/scripts/jquery.uploadify.min.js" type="text/javascript"></script>
<% Html.RenderPartial("CKEditor"); %>
<script type="text/javascript">

    $(document).ready(function () {
        $("#Inx").kendoNumericTextBox({ format: "n0" });
        $("#frm").submit(function () {
            prepareImagesForSave(".galimg", "images");
            $("input.tags").each(function (i) {
                $(this).attr("name", "");
                $(this).next().attr("name", "");
            });
            $("input.tags:checked").each(function (i) {
                $(this).attr("name", "Tags[" + i + "].ID");
                $(this).next().attr("name", "Tags[" + i + "].Name");
            });
        });
    
        $("#farea").kendoDropDownList({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: [<%=((IList<Area>)ViewBag.Areas).Select(cmb => String.Format(@"{{ text: ""{0}"", value: ""{1}"" }}", cmb.Name, cmb.ID)).Aggregate("", (s1, s2)=> s1 + ( String.IsNullOrEmpty(s1) ? "" : ", ") + s2)%>],
            index: 0          
        });
        
        $("#links").kendoDropDownList({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: [{text: "None", value: ""}<%=((IList<CmsBlock>)ViewBag.CmsBlocks).Select(cmb => String.Format(@"{{ text: ""{0}"", value: ""{1}"" }}", cmb.Name, cmb.ID)).Aggregate("", (s1, s2)=> s1 +  ", " + s2)%>],
            index: 0
        });

        $("#DateCreated").kendoDateTimePicker({
            culture: "en-GB",
            format: "dd/MM/yyyy HH:mm"
        });
        var tags = [];
        <% foreach(var tag in Model.Tags) { %>
        tags.push("<%=tag.ID%>");
        <% } %>
        var ds = new kendo.data.HierarchicalDataSource({
            transport: {
                read: {
                    url: "<%=Url.Action("gettags", "tags", new { area = "" })%>",
                    dataType: "jsonp"
                }
            },
            schema: {
                model: {
                    id: "ID",
                    hasChildren: "HasTags",
                    children: "Tags"
                }
            }
        });

        var tagsTree = $("#tags").kendoTreeView({
            checkboxes: {
                checkChildren: true,
                template: function (context) {                    
                    if (context.item.HasTags) {
                        return '<input type="checkbox" />';
                    }
                    return '<input type="checkbox" class="tags" value="' + context.item.ID +'" /><input type="hidden" value="' + context.item.Name + '" />';
                }
            },
            loadOnDemand: false,
            dataSource: ds,
            dataTextField: "Name"
        });
        tagsTree.data("kendoTreeView").bind("dataBound", function (e) {
            for (var i = 0; i < tags.length; i++) {
                var c = $(e.node).find(':checkbox[value|="' + tags[i] + '"]');
                if (c.length > 0) {
                    tagsTree.data("kendoTreeView").expand(e.node);
                    c.click();
                }
            }
        });
        


        var getTagsUrl = "<%=Url.Action("gettags", "tags", new { area = "" })%>";

           

        // load thumbnail
        var imageId = "<%=Model.Image != null ? Model.Image.ID.ToString() : "" %>";
        if (imageId != "") {
            $.ajax({
                dataType: "json",
                type: 'POST',
                url: '<%=Url.Action("GetImage", "Images")%>',
                data: { id: imageId },
                cache: false,
                success: function (data, textStatus, xhr) {
                    createEditableImage(getTagsUrl, data, true)
                        .appendTo($("#imageCont"));
                }
            });
        }             


            


        CKEDITOR.replace('htmledit', {
            height: 700,
            filebrowserUploadUrl: '<%=Url.Action("upload", "files") %>'
        });
             


        $('#file_upload').uploadify({
            swf: '/content/uploadify/uploadify.swf',
            uploader: '<%=Url.Action("upload", "images")%>',
            formData: { tsize: "<%=Article.THUMB_HEIGHT %>", tisWidth: false },
            auto: true,
            multi: false,
            fileTypeDesc: 'Image Files',
            fileTypeExts: '*.gif; *.jpg; *.png',
            buttonClass: 'k-button',
            buttonText: 'Upload',
            onUploadError: function (file, errorCode, errorMsg, errorString) {
                alert('The file ' + file.name + ' could not be uploaded: ' + errorString);
            },
            onQueueComplete: function (queueData) {
                //alert(queueData.uploadsSuccessful + ' files were successfully uploaded.');
            },
            onUploadSuccess: function (file, data, response) {
                $('.galimg').each(function (imgIndex) {
                    $(this).addClass("del");
                    $('.delfield', this).val("true");
                    $(this).hide();
                });
                var obj = jQuery.parseJSON(data);
                var div = createEditableImage(getTagsUrl, obj, true);
                div.appendTo($("#imageCont"));
            }
        });

    });
</script>
</asp:Content>