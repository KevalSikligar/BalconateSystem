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

    h1 {
        margin-bottom: 20px;
    }

    .k-listview div:hover {
        background: #DDDDDD;
    }

    #address-lookup-tooltip {
        display: none;
    }

    @media only screen and (max-width: 659px) {
        label {
            text-align: left;
            float: left;
        }

        .k-dropdown {
            display: inline-block;
            margin-top: -5px;
        }

        input[value='Address lookup'] {
            display: block;
            margin-left: 109px;
            margin-top: 15px;
            padding-top: 3px !important;
            padding-bottom: 3px !important;
        }

        .col-right {
            margin-top: 20px;
        }

        img[src="/images/bv-humb.png"] {
            margin-left: 0 !important;
        }

        .checkboxLabel {
            margin-bottom: 15px;
        }

        #req-brochure-notes {
            margin-top: 20px !important;
        }

        #address-lookup-tooltip {
            display: inline-block;
            position: absolute;
            margin-left: 330px;
            margin-top: -40px;
        }

    }

</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="main">
	<ul id="cookie-menu">
		<li><a href="/">Home</a></li>
        <% if (ViewBag.Area != AreaKind.General) { %>
        <li><a href="<%=ViewBag.AreaUrl %>"><%:ViewBag.AreaName %></a></li>
		<% } %>
		<li class="last">Request Brochure</li>
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
            <div style="margin-top: 5px;" id="req-brochure-notes">
                <div>Notes:</div>
                <%:Html.TextAreaFor(m => m.Notes, new { @class="k-textbox clear", style="width: 300px; height: 70px;" }) %>
            </div>
            <div style="margin-top: 10px;">
                <a href="/balcony-views/homepage" target="_blank"><img src="/images/bv-humb.png" alt="Balcony Views Thumbnail"/></a>
                <div style="margin-top: 10px;">                    
                    <%:Html.CheckBoxFor(m => m.Subscription, new { @class="labeledCheckbox" }) %>
                    <label class="checkboxLabel" for="Subscription" style="width: 260px;">Free subscription to <a href="/balcony-views/homepage" target="_blank">Balcony Views magazine</a></label>
                </div>
            </div>
            <div style="margin-top: 10px;">
                <input class="k-button bold" type="submit" value="Send Request" onClick="ga('send', 'event', { eventCategory: 'requestbrochure', eventAction: 'send'});" />
            </div>
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
        var selectedProduct = -1;
        <% if (Model.SelectedProduct != null) { %>
        selectedProduct = parseInt("<%=(int)Model.SelectedProduct.ID%>");
        <% } %>
        
        var treeview = $("#products").kendoTreeView({
            checkboxes: {
                checkChildren: true,
                template: function (context) {
                    var chk = "";
                    if (selectedProduct >= 0 && context.item.ID == selectedProduct) {
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
            cache: false,
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

<script>
    $(document).ready(function(){
        var tooltipHTML = '<abbr id="address-lookup-tooltip" title="Put in your postcode and press \'Address lookup\' - this will automatically fill in the address of the desired postcode." rel="tooltip">'+
                          '   <img class="qmarkinfo comtinueabbr" src="/images/qmark1311.png" alt="Continue shopping.">\n'+
                          '</abbr>';
        $('input[value="Address lookup"]').closest('p').append(tooltipHTML);
    });
</script>
<script src="/Scripts/tooltip.js"></script>
</asp:Content>
