<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<RequestBrochureModel>" %>
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
        width: 570px;
    }
    .col-right {
        float: left;
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
		<li class="last"><%=ViewBag.Name %></li>
	</ul>
    <%=ViewBag.Body %>
    <% using(Ajax.BeginForm(null, null, new AjaxOptions{ HttpMethod = "POST"}, new { id="frm" } )) {%>
    <div class="form">
        <div class="col-left">
	        <%: Html.EditorForModel() %>
        </div>
        <div class="col-right">
            <div>
                <div>Select products:</div>
                <div id="products"></div>
            </div>
            <div style="margin-top: 5px;">
                <div>Notes:</div>
                <%:Html.TextAreaFor(m => m.Notes, new { @class="k-textbox clear", style="width: 300px; height: 70px;" }) %>
            </div>
            <div style="margin-top: 10px;">
                <a href="http://www.balconyviews.co.uk/" target="_blank"><img src="/images/bv-humb.png" alt="Balcony Views Thumbnail"/></a>
                <div style="margin-top: 10px;">                    
                    <%:Html.CheckBoxFor(m => m.Subscription, new { @class="labeledCheckbox" }) %>
                    <label class="checkboxLabel" for="Subscription" style="width: 260px;">Free subscription to <a href="http://www.balconyviews.co.uk/" target="_blank">Balcony Views magazine</a></label>
                </div>
            </div>
            <div style="margin-top: 10px;">
                <input class="k-button bold" type="submit" value="Send" />
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
      
        var ds = new kendo.data.HierarchicalDataSource({
            transport: {
                read: {
                    url: "<%=Url.Action("GetProducts")%>",
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

        <% if (Model.SelectedProduct != null) { %>
        var selectedProduct = parseInt("<%=(int)Model.SelectedProduct.ID%>");
        <% } %>
        
        var treeview = $("#products").kendoTreeView({
            checkboxes: {
                checkChildren: true,
                template: function (context) {
                    var chk = "";
                    if (selectedProduct && context.item.ID == selectedProduct) {
                        chk = 'checked="checked"';
                    }
                    return '<input type="checkbox" class="product" value="' + context.item.ID + '" ' + chk + '/>';
                }
            },
            loadOnDemand: false,
            dataSource: ds,
            dataTextField: "Name"
        });
        treeview.data("kendoTreeView").bind("dataBound", function (e) {
            $('#products .k-in').click(function () {
                var p = $(this).parents(".k-item");
                var chb = p.find(':checkbox');
                var old = chb.prop('checked');
                chb.prop('checked', old ? false : true);
            });
        });
       
        $("#frm").submit(function () {
            $("input.product").each(function (i) {
                $(this).attr("name", "");
            });
            $("input.product:checked").each(function (i) {
                $(this).attr("name", "Products[" + i + "]");
            });
        });
    });
</script>
</asp:Content>
