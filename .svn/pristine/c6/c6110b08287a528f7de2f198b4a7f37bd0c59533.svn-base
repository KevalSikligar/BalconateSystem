<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<OrderDetailsModel>" %>
<%@ Import Namespace="Microsoft.Ajax.Utilities" %>
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
     .k-listview div:hover { background: #DDDDDD; }
    h1 { margin-bottom: 20px;}
    .btnProceed {
        font-weight: bold;
        font-size: 14px;
    }
    h2 {
        background-color: #CC0000 !important;
        color: #fff !important;
        padding: 4px;
    }
    #details_wrap {
        width: 700px;
    }
    .checkboxLabel {
        width: auto !important;
    }
    #forgot_pass { cursor: pointer;font-weight: bold; }
</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="main">
	<ul id="cookie-menu">
		<li><a href="/">Home</a></li>
        <li><a href="<%:Url.Action("Cart") %>">Shopping Cart</a></li>
		<li class="last">Fill Details</li>
	</ul>
    <h1>Update Details and Passwords Reset</h1>
    <div id="details_wrap">
        
        

        <div>
          
            <% var numofsections = Context.IsCustomer() ? 2 : 3;%>
            <% using(Ajax.BeginForm(null, null, new AjaxOptions{ HttpMethod = "POST"}, new { id="frm_signup" } )) {%>
	            <p>
	                 Please check and fill in any missing details, then at the bottom enter a new Password.
	            </p>
                <h3>1. Personal / Company details</h3>
                <%: Html.EditorForModel() %>
            <input type="hidden" name="regID" id="regID" value="<%:Html.DisplayFor(m=>m.RegionId) %>" />
            <input type="hidden" name="subregID" id="subregID" value="<%:Html.DisplayFor(m=>m.SubRegionId) %>" />
                <h3>2. Delivery options</h3>
                <p>
                    <%:Html.RadioButtonFor(m => m.DeliveryOption, OrderDetailsModel.DeliveryOptionType.SameAddress, new { id="DeliverySameAddress", @class="delivery_option labeledCheckbox" }) %>
                    <label for="DeliverySameAddress" class="checkboxLabel">
                        Deliver to the address entered above.
                    </label>
                </p>
                <p>
                    <%:Html.RadioButtonFor(m => m.DeliveryOption, OrderDetailsModel.DeliveryOptionType.DifferentAddress, new { id="DeliveryDifferentAddress",@class="delivery_option labeledCheckbox" }) %>
                    <label for="DeliveryDifferentAddress" class="checkboxLabel">
                        Deliver to a different address.
                    </label>
                </p>
                <p>
                    <%:Html.RadioButtonFor(m => m.DeliveryOption, OrderDetailsModel.DeliveryOptionType.NoDelivery, new { id="DeliveryNoDelivery",@class="delivery_option labeledCheckbox" }) %>
                    <label for="DeliveryNoDelivery" class="checkboxLabel">
                        Do not include delivery in the cost. I will arrange pick up.
                    </label>
                </p>
                <div id="delivery_address" class="<%=Model.DeliveryOption != OrderDetailsModel.DeliveryOptionType.DifferentAddress ? "display-none" : "" %>">
                    <p>
                        <label>Postcode:</label>
                        <%:Html.TextBoxFor(m => m.DeliveryPostCode, new { @class = "k-textbox" + (Model.DeliveryOption != OrderDetailsModel.DeliveryOptionType.DifferentAddress ? " ignore" : ""), style = "width: 150px;" })%>
                        <input type="button" value="Address lookup" onclick="getaddresses()" class="k-button bold"/><div id="postcode_not_found" style="color:#CC0000;margin-left:115px;display:none;font-size:smaller;">Postcode not recognized</div>
                        <div id ="listView" class="k-input"  style="display:none;width:auto;margin-top:-10px;margin-left:115px;padding:4px;"></div>
                        <%:Html.ValidationMessageFor(m => m.DeliveryPostCode) %>
                    </p>
                    <p>
                        <label>House:</label>
                        <%:Html.TextBoxFor(m => m.DeliveryHouse, new { @class = "k-textbox" + (Model.DeliveryOption != OrderDetailsModel.DeliveryOptionType.DifferentAddress ? " ignore" : ""), style = "width: 250px;" })%>
                        <%:Html.ValidationMessageFor(m => m.DeliveryHouse) %>
                    </p>
                    <p>
                        <label>Street:</label>
                        <%:Html.TextBoxFor(m => m.DeliveryStreet, new { @class = "k-textbox" + (Model.DeliveryOption != OrderDetailsModel.DeliveryOptionType.DifferentAddress ? " ignore" : ""), style = "width: 250px;" })%>
                        <%:Html.ValidationMessageFor(m => m.DeliveryStreet) %>
                    </p>
                    <p>
                        <label>Town:</label>
                        <%:Html.TextBoxFor(m => m.DeliveryTown, new { @class = "k-textbox" + (Model.DeliveryOption != OrderDetailsModel.DeliveryOptionType.DifferentAddress ? " ignore" : ""), style = "width: 250px;" })%>
                    </p>
                    <p>
                        <label>Country:</label>
                        <%:Html.TextBoxFor(m => m.DeliveryCountryId, "", new { @class= (Model.DeliveryOption != OrderDetailsModel.DeliveryOptionType.DifferentAddress ? " ignore" : "") })%>
                        <%:Html.ValidationMessageFor(m => m.DeliveryCountryId) %>
                    </p>
                    <p>
                        <label>Region:</label>
                        <%:Html.TextBoxFor(m => m.DeliveryRegionId, "", new { @class= (Model.DeliveryOption != OrderDetailsModel.DeliveryOptionType.DifferentAddress ? " ignore" : "") })%>
                        <%:Html.ValidationMessageFor(m => m.DeliveryRegionId) %>
                    </p>
                    <p>
                        <label>Sub region:</label>
                        <%:Html.TextBoxFor(m => m.DeliverySubRegionId, new { @class= (Model.DeliveryOption != OrderDetailsModel.DeliveryOptionType.DifferentAddress ? " ignore" : "") })%>
                        <%:Html.ValidationMessageFor(m => m.DeliverySubRegionId) %>
                    </p>
                </div>
            
                
                <h3>3. Enter Password</h3>
                <p>
                    <label>Password:</label>
                    <%:Html.PasswordFor(m => m.Password1, new { @class = "k-textbox", style = "width: 250px;" })%>
                    <%:Html.ValidationMessageFor(m => m.Password1) %>
                </p>
                <p>
                    <label>Retype password:</label>
                    <%:Html.PasswordFor(m => m.Password2, new { @class = "k-textbox noclipboard", style = "width: 250px;" })%>
                    <%:Html.ValidationMessageFor(m => m.Password2) %>
                </p>
                

                <div class="validation-summary-errors"></div>
                <p class="paddingl115">
                    <input type="submit" class="area_color k-button btnProceed prog1" value="Update" />
                </p>
            <% } %>
        </div>
    </div>
</div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/kendo.dropdownlist.min.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#forgot_pass").click(function() {
            var btn = $(this);
            btn.hide();
            $.ajax({
                dataType: "json",
                type: 'POST',
                url: '<%=Url.Action("forgot-password")%>',
                data: {
                    email: $("#Email").val()
                },
                cache: false,
                complete: function (jqXHR, textStatus) {
                    btn.show();
                }
            });
        });
    });
</script>
<script type="text/javascript">
    var default_country = "United Kingdom";
    var default_region=''; var default_region_id;
    var default_sub_region=''; var default_sub_region_id;
    if (document.getElementById("regID").value != '') {
        default_region_id = document.getElementById("regID").value;
    }
    if (document.getElementById("subregID").value != '') {
        default_sub_region_id = document.getElementById("subregID").value;
    }
    
    $(document).ready(function () {
        $(".delivery_option").change(function () {
            var div = $("#delivery_address");
            if ($("#DeliveryDifferentAddress").is(":checked")) {
                div.slideDown();
                div.removeClass("display-none");
                div.find("input").removeClass("ignore");
            } else {
                div.slideUp();
                div.find("input").addClass("ignore");
            }
        });

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
                if (default_country != '') {
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
                } else {
                    if (default_region_id != '') {
                        this.value(default_region_id);
                        this.enable(true);
                        this.trigger("cascade");
                    }
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
                    this.search(default_sub_region);
                } else {
                    if (default_sub_region_id != '') {
                        this.value(default_sub_region_id);
                        this.enable(true);
                    }
                }
            }
        });
        ddl.parents(".k-widget").find(".k-input").text("Select ...");
        




        $("#DeliveryCountryId").kendoDropDownList({
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
        $("#DeliveryRegionId").kendoDropDownList({
            autoBind: false,
            cascadeFrom: "DeliveryCountryId",
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
        var ddl2 = $("#DeliverySubRegionId").kendoDropDownList({
            autoBind: false,
            cascadeFrom: "DeliveryRegionId",
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
        ddl2.parents(".k-widget").find(".k-input").text("Select ...");





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
