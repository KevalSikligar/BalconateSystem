<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<RequestBrochureModel>" Title="Photo Competition Entry Form" %>
<%@ Import Namespace="Newtonsoft.Json" %>
 
<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<style type="text/css">

  .loader {
  border: 6px solid #f3f3f3;
  border-radius: 50%;
  border-top: 6px solid blue;
  border-bottom: 6px solid blue;
  width: 30px;
  height: 30px;
  -webkit-animation: spin 2s linear infinite;
  animation: spin 2s linear infinite;
}

@-webkit-keyframes spin {
  0% { -webkit-transform: rotate(0deg); }
  100% { -webkit-transform: rotate(360deg); }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

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
		<li class="last">Photo Competition Entry Form</li>
	</ul>
    <h1 style="text-align: center;margin-bottom: 30px;">Photo Competition Entry Form</h1>
    <h6 style="    margin-bottom: 25px;">Please fill in the details on this form and upload at least one image</h6>
    <div style="display:none;">
     <%=ViewBag.Body %>
    </div>
    <%--<% using(Html.BeginForm("Photo-Comp-Entry", "Customer", FormMethod.Post, new { enctype = "multipart/form-data", id="frm" })) {%>--%>
    <% using(Html.BeginForm(null, null, FormMethod.Post, new { enctype = "multipart/form-data", id="frm" })) {%>
    <div>
      <div class="col-left">
           <%: Html.EditorForModel() %>
            <input id="CheckBox1" type="checkbox" value="" /> <span><a style="color:none;" href="https://www.balconette.co.uk/general/competition-terms" target="_blank">I have read and accept the competition terms and conditions</a></span>
            <%--<input type="submit" onclick="javascript:return acceptTermAndcondition()" value="Submit Entry" />--%>
         <button id="submitBtn" style="margin-left: 15px; margin-top: 10px;height: 30px;" type="submit" value="Submit">Submit Entry</button>
         
          <div id="loading1" style="display:none;" class="loader">

          </div> 
          <span id="text1" style="display:none;">Your submission is in progress, once completed you will be transferred to a new page</span>
      </div>   
      <div class="col-right" id="inputFiletxt ">
      <span style="font-size:large">Upload Images</span>  <i class="fa fa-question-circle" title="File types accepted: [Jpeg,Jpg,PNG] & Maximum image size: 10 Mb" style="font-size:24px;    margin-left: 15px;"></i>
      <br />
          <div>
        <span style="margin-top:5px;">Image 1</span> <i onclick="removeImage('image1')" class="fa fa-remove" style="font-size:16px;margin-left: 15px;"></i>
        <input id="image1" onchange="validateSize(this)"  style="margin-top:5px;" type="file" name="image1" > 
     </div>
          <br />
      <div>
          <span style="margin-top:5px;">Image 2</span> <i onclick="removeImage('image2')" class="fa fa-remove" style="font-size:16px;margin-left: 15px;"></i>
       <input id="image2" style="margin-top: 6px;;" onchange="validateSize(this)" type="file" name="image2">
     </div>
          <br />
        <div>
          <span style="margin-top:5px;">Image 3</span> <i onclick="removeImage('image3')" class="fa fa-remove" style="font-size:16px;margin-left: 15px;"></i>
       <input id="image3" style="margin-top: 6px;;" onchange="validateSize(this)" type="file" name="image3">
     </div>
          <br />
         <div>
        <span style="margin-top:5px;">Image 4</span> <i onclick="removeImage('image4')" class="fa fa-remove" style="font-size:16px;margin-left: 15px;"></i>
       <input id="image4" style="margin-top: 6px;;" onchange="validateSize(this)" type="file" name="image4">
     </div>
          <br />
         <div>
         <span style="margin-top:5px;">Image 5</span> <i onclick="removeImage('image5')" class="fa fa-remove" style="font-size:16px;margin-left: 15px;"></i>
       <input id="image5" style="margin-top: 6px;;" onchange="validateSize(this)" type="file"  name="image5">
     </div>
          <br />
         <div>
          <span style="margin-top:5px;">Image 6</span> <i onclick="removeImage('image6')" class="fa fa-remove" style="font-size:16px;margin-left: 15px;"></i>
       <input id="image6" style="margin-top: 6px;;" onchange="validateSize(this)" type="file"  name="image6">
     </div>
          <br />
         <div>
          <span style="margin-top:5px;">Image 7</span> <i onclick="removeImage('image7')" class="fa fa-remove" style="font-size:16px;margin-left: 15px;"></i>
       <input id="image7" style="margin-top: 6px;;" onchange="validateSize(this)" type="file" name="image7">
     </div>
          <br />
         <div>
          <span style="margin-top:5px;">Image 8</span> <i onclick="removeImage('image8')" class="fa fa-remove" style="font-size:16px;margin-left: 15px;"></i>
       <input id="image8" style="margin-top: 6px;;" onchange="validateSize(this)" type="file"  name="image8">
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
    document.title = 'Photo Competition Entry Form';
    function removeImage(id) {
        $("#" + id).val('');
        $("#"+ id).css({ "background-color": "#f5f5fb"});
        $("#"+ id).css({"color": "black"});
    }

    function validateSize(file) {
        
        var FileSize = file.files[0].size / 1024 / 1024; // in MB
        if (FileSize > 10) {
            alert('File size exceeds 10 MB');
            $(file).val(''); //for clearing with Jquery
        } 
  /// valid image 
        const fileType = file.files[0]['type'];
    const validImageTypes = ['image/gif', 'image/jpeg','image/jpg', 'image/png'];
        if (!validImageTypes.includes(fileType)) {
            alert('Please select image only');
            $(file).val(''); //for clearing with Jquery
        }
        else
        {
            $(file).css({ "background-color": "#f5f5fb"});
            $(file).css({"color": "#5a5af1"});
        }
       };
    //function acceptTermAndcondition() {
    //       if ($("#CheckBox1").is(':checked')) {
    //           //
    //       }
    //        else {
    //           alert("Please accept term and condition");
    //           document.getElementById("loading1").style.display = "none";
    //            return false;
    //    }
    //    // check if atleast 1 file uploaded or not
    //    if (!$('#image1').val()) {
    //        document.getElementById("loading1").style.display = "none";
    //        alert("Please select atleast 1 image");
    //         return false;
    //    }
    //    else {
    //        document.getElementById("loading1").style.display = "block";
    //        document.getElementById("text1").style.display = "block";
    //          return true;

    //        }
    //}

    var default_country = "United Kingdom";
    var default_region = '';
    var default_sub_region = '';
    window.onload = function () {
        //$(".col-right#inputFiletxt div").attr("style", "")
        $(".col-right div").attr("style","")

   };
    $(document).ready(function () {
 
   function checkInputs() {
    var isValid = true;
    $('.input-required').each(function() {
     if($(this).val() === ''){
        isValid = false;
         return false;
     }        
  });
       return isValid;
   }

        $("#submitBtn").click(function (e) {
            debugger

            if (!$("#CheckBox1").is(':checked')) {
                alert("Please accept term and condition");
                e.preventDefault();
            }

            // check if atleast 1 file uploaded or not
            if (!$('#image1').val()) {
                alert("Please select atleast 1 image");
                e.preventDefault();
            }

            if ($("#CheckBox1").is(':checked') && $('#image1').val()) {
                if ($('#frm').valid())
               {
                $("#loading1").css("display", "block");
                $("#text1").css("display", "block");
                $("#frm").submit();
               }
               else
               {
                return false;
               }
            }
        });

       $(".col-right div").attr("style","")
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
        //treeview.data("kendoTreeView").bind("dataBound", function (e) {
        //    $('#products .k-in').click(function () {
        //        var p = $(this).parents(".k-item");
        //        var chb = p.find(':checkbox');
        //        var old = chb.prop('checked');
        //        chb.prop('checked', old ? false : true);
        //    });
        //});
       
        //$("#frm").submit(function () {
        //    debugger
        //    $("input.product").each(function (i) {
        //        $(this).attr("name", "");
        //    });
        //    $("input.product:checked").each(function (i) {
        //        $(this).attr("name", "Products[" + i + "]");
        //    });
        //});
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

<%--<script>
    $(document).ready(function(){
        var tooltipHTML = '<abbr id="address-lookup-tooltip" title="Put in your postcode and press \'Address lookup\' - this will automatically fill in the address of the desired postcode." rel="tooltip">'+
                          '   <img class="qmarkinfo comtinueabbr" src="/images/qmark1311.png" alt="Continue shopping.">\n'+
                          '</abbr>';
        $('input[value="Address lookup"]').closest('p').append(tooltipHTML);
    });
</script>--%>
<%--<script src="/Scripts/tooltip.js"></script>--%>
</asp:Content>
