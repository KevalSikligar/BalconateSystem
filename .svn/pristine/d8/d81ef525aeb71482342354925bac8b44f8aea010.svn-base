<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<RequestTicketsModel>" %>
<%@ Import Namespace="Newtonsoft.Json" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<style type="text/css">
    label {
        width: 100px;
        display: inline-block;
        text-align: right;
        margin-right: 10px;
    }
    .col-left {
        float: left;
        width: 100%;
    }
    .col-right {
        margin: 0 auto;
		width: 100px;
    }
    #products .k-in {
        cursor: pointer;
    }
    #products .k-state-selected, #products .k-state-hover {
        background-image: none !important;
        background-color: transparent !important;
        border: 0 !important;
        color: #2e2e2e !important;
        padding: 2px 4px 2px 3px !important;
        margin: 1px 0 1px 2px !important;
    }
    h1 { margin-bottom: 20px;}
</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="main">
	<ul id="cookie-menu">
		<li><a href="/">Home</a></li>
        <% if (ViewBag.Area != AreaKind.General) { %>
        <li><a href="<%=ViewBag.AreaUrl %>"><%:ViewBag.AreaName %></a></li>
		<% } %>
		<li class="last">Request Tickets</li>
	</ul>
    <%=ViewBag.Body %>
    <% using(Ajax.BeginForm(null, null, new AjaxOptions{ HttpMethod = "POST"}, new { id="frm" } )) {%>
    <div class="form">
        <div class="col-left">
	        <%: Html.EditorForModel() %>
        </div>
        <div class="col-right">
            <div style="margin-top: 10px;">
                <input style="margin-top: 40px;" class="k-button bold" type="submit" value="Send" />
            </div>
        </div>
    </div>
    <% } %>
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

        $("#CountryId").kendoDropDownList({
            optionLabel: "Select ...",
            dataTextField: "Name",
            dataValueField: "ID",
            dataSource: {
                type: "odata",
                serverFiltering: true,
                transport: {
                    read: "<%=Url.Action("GetCountries", "Customer")%>"
                }
            }
        });

        $("#RegionId").kendoDropDownList({
            autoBind: false,
            cascadeFrom: "CountryId",
            optionLabel: "Select ...",
            dataTextField: "Name",
            dataValueField: "ID",
            dataSource: {
                type: "odata",
                serverFiltering: true,
                transport: {
                    read: "<%=Url.Action("GetRegions", "Customer")%>"
                }
            }
        });

        var ddl = $("#SubRegionId").kendoDropDownList({
            autoBind: false,
            cascadeFrom: "RegionId",
            optionLabel: "Select ...",
            dataTextField: "Name",
            dataValueField: "ID",
            dataSource: {
                type: "odata",
                serverFiltering: true,
                transport: {
                    read: "<%=Url.Action("GetSubRegions", "Customer")%>"
                }
            }
        });
        ddl.parents(".k-widget").find(".k-input").text("Select ...");
        
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
       
        $("#frm").submit(function () {

        });
    });
</script>
</asp:Content>
