<%@ Page Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="ViewPage<BalustradeModel>" %>

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

        #sections {
            clear: both;
        }
        #sections th {
            font-weight: bold;
        }
        #sections td, 
        #sections th {
            padding: 5px;
        }

        #sections .del, 
        #sections .add {
            cursor: pointer;
        }

        #sections .f_x, 
        #sections .f_y {
            text-align: right;
            width: 80px;
        }
        #sections tfoot {
            background-color: #d9d9d9;
        }
    </style>

</asp:Content>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <h1>Edit - <%: Model.Name %></h1>
    <div>
    <% using (Html.BeginForm(null, null, FormMethod.Post, new { id = "frm" })) { %>
    <div class="leftcol">
        <input type="hidden" name="ID" value="<%=Model.ID %>"/>
        <p><%:Html.ActionLink("Back to index", "Index") %></p>
        <p><input type="submit" value="Save" class="k-button" /><%: ViewBag.Msg ?? ""%></p>
        <p>
            <label>Url</label>
            <%: Html.TextBoxFor(m => m.Url, new { @class = "k-textbox", placeholder = "[name-with-dashes]", style = "width: 400px;" })%>
            <%: Html.ValidationMessageFor(m => m.Url)%>
        </p>
        <p>
            <label>Name</label>
            <%: Html.TextBoxFor(m => m.Name, new { @class = "k-textbox", style = "width: 400px;" })%>
            <%: Html.ValidationMessageFor(m => m.Name)%>
        </p>
        <p>
            <label>H1</label>
            <%: Html.TextBoxFor(m => m.H1, new { @class = "k-textbox", style = "width: 400px;" })%>
            <%: Html.ValidationMessageFor(m => m.H1)%>
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
        <p>
            <label>Image</label>
            <%: Html.TextBoxFor(m => m.Image, new { @class = "k-textbox", style = "width: 700px;" })%>
            <%: Html.ValidationMessageFor(m => m.Image)%>
        </p>
        <p>
            <label>Index</label>
            <%: Html.TextBoxFor(m => m.Inx)%>
            <%: Html.ValidationMessageFor(m => m.Inx)%>
        </p>
    </div>
        
    <div style="clear: both;">
    <strong>Sections:</strong>
    <table id="sections">
        <tr>
            <th></th>
            <th>X</th>
            <th>Y</th>
            <th>Curved</th>
        </tr>
        <tbody class="tbody">
        <% foreach (var section in Model.Sections) { %>
        <tr>
            <td><a class="del">X</a></td>
            <td><input type="text" value="<%:section.X %>" class="f_x k-textbox only-numbers" /></td>
            <td><input type="text" value="<%:section.Y %>" class="f_y k-textbox only-numbers" /></td>
            <td style="text-align: center;"><input type="checkbox" class="f_curved" value="<%=section.Curved ? "true" : "false"%>" <%=section.Curved ? "checked=\"checked\"" : "" %> /></td>
        </tr>
        <% } %>
        </tbody>
        <tfoot>
        <tr>
            <td><a class="add">+</a></td>
            <td><input type="text" value="0" class="f_x k-textbox only-numbers"/></td>
            <td><input type="text" value="0" class="f_y k-textbox only-numbers"/></td>
            <td style="text-align: center;"><input type="checkbox" class="f_curved" /></td>
        </tr>
        </tfoot>
    </table>
    </div>
    <div id="htmleditcont">
        <%:Html.TextAreaFor(m => m.Body, new { id="htmledit" }) %>
    </div>    
    <% } %>
    </div>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/kendo.dropdownlist.min.js" type="text/javascript"></script>
<script src="/scripts/kendo.numerictextbox.min.js"></script>
<% Html.RenderPartial("CKEditor"); %>
<script type="text/javascript">

    $(document).ready(function () {
        $("#Inx").kendoNumericTextBox({ format: "n0" });
        $("#frm").submit(function () {
            $("#sections tbody.tbody tr").each(function (i) {
                var tr = $(this);
                tr.find(".f_x").attr("name", "Sections[" + i + "].X");
                tr.find(".f_y").attr("name", "Sections[" + i + "].Y");
                var chb = tr.find(".f_curved");
                chb.attr("name", "Sections[" + i + "].Curved");                
                chb.val(chb.is(':checked') ? "true" : "false");
            });
        });

        function del() {
            $(this).parents("tr").remove();
            return false;
        }

        $("#sections .del").click(del);
        
        $("#sections .add").on("click", function () {
            var tr = $(this).parents("tr");
            var copy = tr.clone(true);
            var btn = copy.find("a.add");
            btn.removeClass("add").addClass("del").html("X").unbind("click").bind("click", del);
            copy.appendTo('#sections tbody.tbody');
            tr.find(".f_x, .f_y").val(0);
            return false;
        });

        CKEDITOR.replace('htmledit', {
            height: 700
        });
    });
</script>
</asp:Content>