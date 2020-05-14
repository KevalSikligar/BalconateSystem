<%@ Page Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="ViewPage<TagCategory>" %>

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
            <label>Name</label>
            <%: Html.TextBoxFor(m => m.Name, new { @class = "k-textbox", style = "width: 400px;" })%>
            <%: Html.ValidationMessageFor(m => m.Name)%>
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
    <div id="htmleditcont" class="labeledCheckbox">
        <label>Description:</label>
        <%:Html.TextAreaFor(m => m.DescHtml, new { id="htmledit" }) %>
    </div>                      
    <% } %>
    </div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/kendo.numerictextbox.min.js"></script>
<% Html.RenderPartial("CKEditor"); %><script type="text/javascript">
    $(document).ready(function () {

        $("#Inx").kendoNumericTextBox({ format: "n0" });
        
        CKEDITOR.replace('htmledit', {
            height: 700,
            filebrowserUploadUrl: '<%=Url.Action("upload", "files") %>'
        });

    });
</script>
</asp:Content>