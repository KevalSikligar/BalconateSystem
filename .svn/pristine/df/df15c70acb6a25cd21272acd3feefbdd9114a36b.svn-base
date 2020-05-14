<%@ Page Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="ViewPage<StandardPage>" %>

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

        #htmleditcont {
            clear: both;
            margin-top: 10px;
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
            <%: Html.TextBoxFor(m => m.Url, new { @class = "k-textbox", placeholder = "/[name-with-dashes]", style = "width: 400px;" })%>
            <%: Html.ValidationMessageFor(m => m.Url)%>
        </p>
        <p>
            <label>Name</label>
            <%: Html.TextBoxFor(m => m.Name, new { @class = "k-textbox", style = "width: 400px;" })%>
            <%: Html.ValidationMessageFor(m => m.Name)%>
        </p>
        <p>
            <label>Area</label>
            <%: Html.TextBox("farea", Model.Area != null ? Model.Area.ID.ToString() : "", new { @class = "k-textbox" })%>
        </p>
        <p>
            <label>Footer</label>
            <%: Html.TextBox("footerid", Model.FooterLinksID, new { @class = "k-textbox", style="width: 300px;" })%>
        </p>
        <p>
            <%: Html.CheckBoxFor(m => m.UseTemplate, new{ @class="labeledCheckbox" })%>
            <%: Html.LabelFor(m => m.UseTemplate, "Use Template", new { @class="checkboxLabel" }) %>
        </p>
        <p>
            <label>Index Type</label>
            <%: Html.TextBoxFor(m => m.IndexType)%>
        </p>
        <p>
            <%: Html.CheckBox("disableInline", MvcApplication.DisableInlineEditing, new{ @class="labeledCheckbox" })%>
            <label for="disableInline" class="checkboxLabel">Disable inline editing</label>            
        </p>
        <p>
            <label>Title</label>
            <%: Html.TextBoxFor(m => m.Title, new { @class = "k-textbox", style = "width: 400px;" })%>
            <%: Html.ValidationMessageFor(m => m.Title)%>
        </p>

        <p>
            <label>Description</label>
            <%: Html.TextBoxFor(m => m.Description, new { @class = "k-textbox", style = "width: 700px;" })%>
            <%: Html.ValidationMessageFor(m => m.Description)%>
        </p>
        <p>
            <label>Keywords</label>
            <%: Html.TextBoxFor(m => m.Keywords, new { @class = "k-textbox", style = "width: 700px;" })%>
            <%: Html.ValidationMessageFor(m => m.Keywords)%>
        </p>
    </div>
    <div class="rightcol">
        <label>Tags:</label>
        <div id="tags"></div>
    </div>
    <div style="clear: both;">
        <label style="clear: both;">Head:</label>
        <%: Html.TextAreaFor(m => m.Head, new { @class = "k-textbox", style = "width: 700px; height: 70px;" })%>
    </div>
    <div style="clear: both;">
        <label style="clear: both;">Footer:</label>
        <%: Html.TextAreaFor(m => m.Footer, new { @class = "k-textbox", style = "width: 700px; height: 70px;" })%>
    </div>

    <div id="htmleditcont">
        <%:Html.TextAreaFor(m => m.Body, new { id="htmledit" }) %>
    </div>    
    <div>
        <%:Html.ValidationSummary() %>
    </div>
        
                          
    <% } %>
</div>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/kendo.dropdownlist.min.js" type="text/javascript"></script>
<script src="/scripts/kendo.treeview.min.js" type="text/javascript"></script>
<% Html.RenderPartial("CKEditor"); %>
<script type="text/javascript">

    $(document).ready(function () {

        $("#frm").submit(function () {
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

        $("#IndexType").kendoDropDownList({
            dataSource: [<%= String.Join(", ", Enum.GetValues(typeof(IndexType)).Cast<IndexType>().Select(it => "\"" + it + "\"")) %>],
            index: 0
        });


        $("#footerid").kendoDropDownList({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: [{ text: "None", value: "" }<%=((IList<CmsBlock>)ViewBag.Blocks).Select(cmb => String.Format(@"{{ text: ""{0}"", value: ""{1}"" }}", cmb.Name, cmb.ID)).Aggregate("", (s1, s2)=> s1 +  ", " + s2)%>],
            index: 0
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

        CKEDITOR.replace('htmledit', {
            height: 700,
            filebrowserUploadUrl: '<%=Url.Action("upload", "files") %>'
        });

    });
</script>
</asp:Content>