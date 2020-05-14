<%@ Page Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="ViewPage<Tag>" %>

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
            <label>ID</label>
            <%:Model.ID %>
        </p>
        <p>
            <label>Name</label>
            <%: Html.TextBoxFor(m => m.Name, new { @class = "k-textbox", style = "width: 400px;" })%>
            <%: Html.ValidationMessageFor(m => m.Name)%>
        </p>
        <p>
            <label>Tag Category</label>
            <%: Html.TextBox("fcategory", Model.TagCategory != null ? Model.TagCategory.ID.ToString() : "", new { @class = "k-textbox" })%>
        </p>
        <p>
            <label>Index</label>
            <%: Html.TextBoxFor(m => m.Inx)%>
            <%: Html.ValidationMessageFor(m => m.Inx)%>
        </p>
        <p>
            <%:Html.CheckBoxFor(m => m.ShowDesc, new { @class="labeledCheckbox" }) %>
            <label class="checkboxLabel" for="ShowDesc">Show Description</label>
        </p>
    </div>
    <div id="htmleditcont">        
        <label>Description:</label>
        <%:Html.TextAreaFor(m => m.DescHtml, new { id="htmledit" }) %>
    </div>                      
    <% } %>
    </div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/kendo.dropdownlist.min.js"></script>
<script src="/scripts/kendo.numerictextbox.min.js"></script>
<% Html.RenderPartial("CKEditor"); %>
<script type="text/javascript">
    $(document).ready(function () {
        $("#fcategory").kendoDropDownList({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: [<%=((IList<TagCategory>)ViewBag.Categories).Select(cmb => String.Format(@"{{ text: ""{0}"", value: ""{1}"" }}", cmb.Name, cmb.ID)).Aggregate("", (s1, s2)=> s1 + ( String.IsNullOrEmpty(s1) ? "" : ", ") + s2)%>],
        index: 0
        });
            
        $("#Inx").kendoNumericTextBox({ format: "n0" });
        
        CKEDITOR.replace('htmledit', {
            height: 700,
            filebrowserUploadUrl: '<%=Url.Action("upload", "files") %>'
        });


    });
</script>
</asp:Content>