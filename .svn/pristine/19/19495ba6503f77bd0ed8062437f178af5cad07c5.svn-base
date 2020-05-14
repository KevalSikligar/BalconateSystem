<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<ContactUsModel>" %>

<%@ Import Namespace="Newtonsoft.Json" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
    <style type="text/css">
        label {
            width: 100px;
            display: inline-block;
            text-align: right;
            margin-right: 10px;
        }

        h1 {
            margin-bottom: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
    <div class="main contactuspage">
        <ul id="cookie-menu">
            <li><a href="/">Home</a></li>
            <% if (ViewBag.Area != AreaKind.General)
               { %>
            <li><a href="<%=ViewBag.AreaUrl %>"><%:ViewBag.AreaName %></a></li>
            <% } %>
            <li class="last">Contact Us</li>
        </ul>
        <div id="f_body" class="cmsblock left" contenteditable="<%:this.IsAdmin().ToString().ToLower() %>">
            <h1>Contact Us</h1>
			<p style="margin-bottom: 30px;">Please fill in your details here and tell us how we can help. We shall endeavour to reply to you as soon as possible.</p>
			<div class="contactusformdiv" style="margin-bottom: 100px;">
                <% using (Ajax.BeginForm(null, null, new AjaxOptions { HttpMethod = "POST" }, new { id = "frm" })) { %>
                <div class="form">
                    <%: Html.EditorForModel() %>
                    <p>
                        <label>Notes:</label>
                        <%:Html.TextAreaFor(m => m.Notes, new { @class="k-textbox clear", style="width: 300px; height: 70px;" }) %>
                    </p>
                    <div style="margin-top: 10px;">
                        <input class="k-button bold" type="submit" value="Send" onClick="ga('send', 'event', { eventCategory: 'contactus', eventAction: 'send'});" />
                    </div>
                </div>
                <% } %>
            </div>
			<%=ViewBag.Body %>
        </div>
        <div class="right">
            <% Html.RenderPartial("leftsidebar"); %>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
    <script src="/scripts/kendo.dropdownlist.min.js" type="text/javascript"></script>
    <script src="/scripts/kendo.treeview.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            var titlesDataSource = [{ text: "Select", value: "" }];
            Array.prototype.push.apply(titlesDataSource, eval(<%=JsonConvert.SerializeObject(CustomerContact.Titles.Select(t => new { text=t, value = t }))%>));

        $(".customer_title").kendoDropDownList({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: titlesDataSource,
            index: 0
        });

        $("#CatalogId").kendoDropDownList({
            optionLabel: "Select ...",
            dataTextField: "Name",
            dataValueField: "ID",
            dataSource: {
                type: "odata",
                serverFiltering: true,
                transport: {
                    read: "<%=Url.Action("GetCatalogs", "Customer")%>"
                }
            }
        });

    });
    </script>
</asp:Content>
