<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<ArrangeVisitModel>" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadStart" runat="server">
    <title>Arrange a Visit</title>
</asp:Content>
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
    .k-listview div:hover { background: #DDDDDD; }

</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="main">
	<ul id="cookie-menu">
		<li><a href="/">Home</a></li>
        <% if (ViewBag.Area != AreaKind.General) { %>
        <li><a href="<%=ViewBag.AreaUrl %>"><%:ViewBag.AreaName %></a></li>
		<% } %>
		<li class="last">Arrange a Visit</li>
	</ul>
    <%=ViewBag.Body %>
    
    <% using(Ajax.BeginForm(null, null, new AjaxOptions{ HttpMethod = "POST"}, new { id="frm" } )) {%>
    <div class="form">
        
	        <%: Html.EditorForModel() %>
        
            <div style="margin-top: 5px;">
                    <div>Please let us know which Ambassador and/or location you would like to visit and any other relevant information.:</div><br />
                    <%:Html.TextAreaFor(m => m.Notes, new { @class="k-textbox clear", style="width: 750px; height: 70px;" }) %>
            </div>
            
            <div style="margin-top: 10px;">
                    <input class="k-button bold" type="submit" value="Submit" onClick="ga('send', 'event', { eventCategory: 'arrange-a-visit', eventAction: 'send'});" />
            </div>
       
    </div>
    <% } %>
</div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/kendo.dropdownlist.min.js" type="text/javascript"></script>
    <script src="/scripts/kendo.listview.min.js" type="text/javascript"></script>
<script src="/scripts/kendo.treeview.min.js" type="text/javascript"></script>
<script type="text/javascript">
    var default_country = "United Kingdom";
    var default_region = '';
    var default_sub_region = '';
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
            },
            dataBound: function (e) {
                if (default_country!=''){
                    this.search(default_country);
                    this.trigger("cascade");
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
            },
            dataBound: function (e) {
                if (default_region != '') {
                    this.search(default_region);
                    this.trigger("cascade");
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
            },
            dataBound: function (e) {
                if (default_sub_region != '') {
                    this.search(default_sub_region.replace("County ",""));
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
      
       
    });
</script>
    <script type="text/javascript">
        function getaddresses() {
            $.ajax({
                url: '/customer/getaddr',
                data: {
                    't': $.now(),
                    'sc': $("#PostCode").val()
                },
                contentType: "application/json; charset=utf-8",
                dataType: 'json',
                cache:false,
                type: 'GET',
                success: function (response) {
                    if (response == "-1") {
                        $("#listView").empty(); $("#listView").hide();
                        $("#postcode_not_found").show();
                        $("#postcode_not_found").delay(2000).fadeOut(600);
                        return -1;
                    }
                    a_data = response.result;
                    
                    $("#listView").show();
                    $("#listView").kendoListView({
                        dataSource: {
                            data: a_data
                        },
                        template: "<div>#:line_1 + ', ' + line_2#</div>",
                        selectable: true,
                        change: function () {
                           
                            res = $.map(this.select(), function (item) {
                                sel = a_data[$(item).index()];
                                default_country = "United Kingdom";
                                default_region = sel.country;
                                default_sub_region = sel.county;
                                var dd = $("#CountryId").data("kendoDropDownList");
                                dd.search(default_country);
                                dd.trigger("cascade");
                                $("#Street").val(sel.thoroughfare);
                                $("#Town").val(sel.post_town);
                                // $("#PostCode").val(sel.postcode);
                                if (sel.building_number != '') {
                                    $("#House").val(sel.building_number);
                                } else {
                                    if (sel.sub_building_name != '') {
                                        $("#House").val(sel.sub_building_name + ', ' + sel.building_name);
                                    } else {
                                        $("#House").val(sel.building_name);
                                    }
                                }
                                var listView = $("#listView").data("kendoListView");
                                listView.destroy();

                                $("#listView").empty(); $("#listView").hide();
                                return 1;
                            });
                        }
                    })
                }
            });  
        }
       
</script>
</asp:Content>
