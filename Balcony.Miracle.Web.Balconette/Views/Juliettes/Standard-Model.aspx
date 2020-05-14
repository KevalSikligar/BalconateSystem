<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<StandardJulietteModel>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<style type="text/css">
    #standard-juliet-model h1 {
        margin: 0 0 5px 0;
    }
    #standard-juliet-model h2 {
        margin: 0 0 10px 0;
    }
    #standard-juliet-model  p {
        margin-bottom: 0;
    }
    #standard-juliet-model #type-and-color p {
        margin-right: 10px;
        float: left;
        margin-bottom: 10px;
    }
    #standard-juliet-model #model_cell {
        position: relative;
        vertical-align: bottom;
        display: table-cell;
    }
    #standard-juliet-model #model_cell .mes {
        position: absolute;
        padding: 5px;
        overflow: visible;
        white-space: nowrap;
    }
    #standard-juliet-model #model_cell .mes input {
        width: 80px;
        text-align: right;
    }
    #standard-juliet-model #section_cell {
        display: table-cell;
        vertical-align: bottom;
        text-align: center;
        padding-right: 5px;
        font-weight: bold;
    }
    #standard-juliet-model #sectionImage {
        width: 200px;
    }

    #standard-juliet-model #middle_wrap {
        display: table;
        margin: 0 auto;
        height: 490px;
        clear: both;
    }
    #standard-juliet-model #next_cell {
        position: relative;
        display: table-cell;
        vertical-align: top;
        padding-left: 20px;
        font-weight: bold;
        width: 150px;
        text-align: center;
    }
    #standard-juliet-model #next_cell #btnAddToCart {
        font-weight: bold;
        font-size: 18px;
    }
    #standard-juliet-model #next_cell img {
        vertical-align: middle;
        text-decoration: none !important;
        margin-right: 3px;
    }
    #standard-juliet-model .mes span.label {
        width: 40px;
        text-align: right;
        display: inline-block;
    }
    #standard-juliet-model #type-and-color span.num {
        font-weight: bold;
        font-size: 1.4em;
    }
    #standard-juliet-model #modelImage {
        width: 650px;
    }
    #standard-juliet-model div.prices {
        text-align: center;
        width: 200px;
        margin-bottom: 10px;
    }

    #standard-juliet-model div.prices .oldPrice {
        color: #606060;
        text-decoration: line-through;
        font-size: 14px;
    }

   #standard-juliet-model div.prices .newPrice {
        color: #606060;
        font-weight: bold;
        font-size: 16px;
    }

    .julietpageprodtd {
        margin: 20px auto !important;
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
		<li class="last"><%:Model.H1 %></li>
	</ul>	
    <div id="standard-juliet-model">
        <% using (Html.BeginForm("standard-model", null, FormMethod.Post, new { id="frm" })) { %>
        <%:Html.HiddenFor(m => m.CalcPrice) %>
		<div id="ajxCont">
            <%:Html.Partial("StandardDetails", Model) %>
        </div>
        <% } %>    
    </div>
	<div style="text-align: center; margin-top: 100px;">
  <h2>Need a different size Juliet?</h2>  
<table class="julietpageprodtd">
	<tbody>
		<tr>
			<td>
			<div class="model">
			<h2 style="font-size: 16px;font-weight: bold;margin: 0;"><a href="/juliet-balcony/standard-model/1000?type=1&color=3&glass=1">1000mm</a></h2>

			<p class="subtitle">up to 740mm opening</p>
			<a href="/juliet-balcony/standard-model/1000?type=1&color=3&glass=1" title="1860 mm wide Juliet Balcony"><img alt="1000 mm wide Juliet Balcony" src="https://www.balconette.co.uk/content/uploads/3765e8ee-1866-4ae8-bfd4-0f05a98ddb45/1000-mm-wide-juliet-balcony.jpg" style="width:150px; border: 5px #ffffff solid; -webkit-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; -moz-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important;"> </a>

			<p class="oldPrice" style="text-decoration: line-through;">£159.85 + VAT &nbsp;</p>

			<p class="newPrice area_color">£139.00 + VAT</p>
			<a class="btnSelect k-button" href="/juliet-balcony/standard-model/1000?type=1&color=3&glass=1">Select</a></div>
			</td>
			<td>
			<div class="model">
			<h2 style="font-size: 16px;font-weight: bold;margin: 0;"><a href="/juliet-balcony/standard-model/1280?type=1&amp;color=3&amp;glass=1">1280mm</a></h2>

			<p class="subtitle">up to 1020mm opening</p>
			<a href="/juliet-balcony/standard-model/1280?type=1&amp;color=3&amp;glass=1" title="1280 mm wide Juliet Balcony"><img alt="1280 mm wide Juliet Balcony" src="/images/juliettes/standards/med/1/3/1280.jpg" style="width:150px;border: 5px #ffffff solid;/* -webkit-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; */-moz-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important;/* box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; */"> </a>

			<p class="oldPrice1" style="text-decoration: line-through;">£192.50 + VAT &nbsp;</p>

			<p class="newPrice area_color">£175.00 + VAT</p>
			<a class="btnSelect k-button" href="/juliet-balcony/standard-model/1280?type=1&amp;color=3&amp;glass=1">Select</a></div>
			</td>
			<td>
			<div class="model">
			<h2 style="font-size: 16px;font-weight: bold;margin: 0;"><a href="/juliet-balcony/standard-model/1500?type=1&amp;color=3&amp;glass=1">1500mm</a></h2>

			<p class="subtitle">up to 1240mm opening</p>
			<a href="/juliet-balcony/standard-model/1500?type=1&amp;color=3&amp;glass=1" title="1500 mm wide Juliet Balcony"><img alt="1500 mm wide Juliet Balcony" src="/images/juliettes/standards/med/1/3/1500.jpg" style="width:150px; border: 5px #ffffff solid; -webkit-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; -moz-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important;"> </a>

			<p class="oldPrice" style="text-decoration: line-through;">£257.40 + VAT &nbsp;</p>

			<p class="newPrice area_color">£234.00 + VAT</p>
			<a class="btnSelect k-button" href="/juliet-balcony/standard-model/1500?type=1&amp;color=3&amp;glass=1">Select</a></div>
			</td>
			<td>
			<div class="model">
			<h2 style="font-size: 16px;font-weight: bold;margin: 0;"><a href="/juliet-balcony/standard-model/1680?type=1&amp;color=3&amp;glass=1">1680mm</a></h2>

			<p class="subtitle">up to 1420mm opening</p>
			<a href="/juliet-balcony/standard-model/1680?type=1&amp;color=3&amp;glass=1" title="1680 mm wide Juliet Balcony"><img alt="1680 mm wide Juliet Balcony" src="/images/juliettes/standards/med/1/3/1680.jpg" style="width:150px; border: 5px #ffffff solid; -webkit-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; -moz-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important;"> </a>

			<p class="oldPrice" style="text-decoration: line-through;">£279.40 + VAT &nbsp;</p>

			<p class="newPrice area_color">£254.00 + VAT</p>
			<a class="btnSelect k-button" href="/juliet-balcony/standard-model/1680?type=1&amp;color=3&amp;glass=1">Select</a></div>
			</td>			
		</tr>
	</tbody>
</table>
<table class="julietpageprodtd">
	<tbody>
		<tr>
			<td>
			<div class="model">
			<h2 style="font-size: 16px;font-weight: bold;margin: 0;"><a href="/juliet-balcony/standard-model/1860?type=1&amp;color=3&amp;glass=1">1860mm</a></h2>

			<p class="subtitle">up to 1600mm opening</p>
			<a href="/juliet-balcony/standard-model/1860?type=1&amp;color=3&amp;glass=1" title="1860 mm wide Juliet Balcony"><img alt="1860 mm wide Juliet Balcony" src="/images/juliettes/standards/med/1/3/1860.jpg" style="width:150px; border: 5px #ffffff solid; -webkit-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; -moz-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important;"> </a>

			<p class="oldPrice" style="text-decoration: line-through;">£339.12 + VAT &nbsp;</p>

			<p class="newPrice area_color">£314.00 + VAT</p>
			<a class="btnSelect k-button" href="/juliet-balcony/standard-model/1860?type=1&amp;color=3&amp;glass=1">Select</a></div>
			</td>
			<td>
			<div class="model">
			<h2 style="font-size: 16px;font-weight: bold;margin: 0;"><a href="/juliet-balcony/standard-model/2180?type=1&amp;color=3&amp;glass=1">2180mm</a></h2>

			<p class="subtitle">up to 1920mm opening</p>
			<a href="/juliet-balcony/standard-model/2180?type=1&amp;color=3&amp;glass=1" title="2180 mm wide Juliet Balcony - 5 working day delivery"><img alt="2180 mm wide Juliet Balcony" src="/images/juliettes/standards/med/1/3/2180.jpg" style="width:150px; border: 5px #ffffff solid; -webkit-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; -moz-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important;"> </a>

			<p class="oldPrice" style="text-decoration: line-through;">£393.12 + VAT &nbsp;</p>

			<p class="newPrice area_color">£364.00 + VAT</p>
			<a class="btnSelect k-button" href="/juliet-balcony/standard-model/2180?type=1&amp;color=3&amp;glass=1">Select</a></div>
			</td>
			<td>
			<div class="model">
			<h2 style="font-size: 16px;font-weight: bold;margin: 0;"><a href="/juliet-balcony/standard-model/2450?type=1&amp;color=3&amp;glass=1">2450mm</a></h2>

			<p class="subtitle">up to 2190mm opening</p>
			<a href="/juliet-balcony/standard-model/2450?type=1&amp;color=3&amp;glass=1" title="2450 mm wide Juliet Balcony - 5 working day delivery"><img alt="2450 mm wide Juliet Balcony" src="/images/juliettes/standards/med/1/3/2450.jpg" style="width:150px; border: 5px #ffffff solid; -webkit-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; -moz-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important;"> </a>

			<p class="oldPrice" style="text-decoration: line-through;">£490.32 + VAT &nbsp;</p>

			<p class="newPrice area_color">£454.00 + VAT</p>
			<a class="btnSelect k-button" href="/juliet-balcony/standard-model/2450?type=1&amp;color=3&amp;glass=1">Select</a></div>
			</td>
			<td>
			<div class="model">
			<h2 style="font-size: 16px;font-weight: bold;margin: 0;"><a href="/juliet-balcony/standard-model/2840?type=1&amp;color=3&amp;glass=1">2840mm</a></h2>

			<p class="subtitle">up to 2580mm opening</p>
			<a href="/juliet-balcony/standard-model/2840?type=1&amp;color=3&amp;glass=1" title="2840 mm wide Juliet Balcony - 5 working day delivery"><img alt="2840 mm wide Juliet Balcony" src="/images/juliettes/standards/med/1/3/2840.jpg" style="width:150px; border: 5px #ffffff solid; -webkit-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; -moz-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important;"> </a>

			<p class="oldPrice" style="text-decoration: line-through;">£555.12 + VAT &nbsp;</p>

			<p class="newPrice area_color">£514.00 + VAT</p>
			<a class="btnSelect k-button" href="/juliet-balcony/standard-model/2840?type=1&amp;color=3&amp;glass=1">Select</a></div>
			</td>			
		</tr>
	</tbody>
</table>




<table class="julietpageprodtd">
	<tbody>
		<tr>
			<td>
			<div class="model">
			<h2 style="font-size: 16px;font-weight: bold;margin: 0;"><a href="/juliet-balcony/standard-model/3200?type=1&amp;color=3&amp;glass=1">3200mm</a></h2>

			<p class="subtitle">up to 2940mm opening</p>
			<a href="/juliet-balcony/standard-model/3200?type=1&amp;color=3&amp;glass=1" title="3200 mm wide Juliet Balcony - 5 working day delivery"><img alt="3200 mm wide Juliet Balcony" src="/images/juliettes/standards/med/1/3/3200.jpg" style="width:150px; border: 5px #ffffff solid; -webkit-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; -moz-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important;"> </a>

			<p class="oldPrice" style="text-decoration: line-through;">£729.75 + VAT &nbsp;</p>

			<p class="newPrice area_color">£695.00 + VAT</p>
			<a class="btnSelect k-button" href="/juliet-balcony/standard-model/3200?type=1&amp;color=3&amp;glass=1">Select</a></div>
			</td>
			<td>
			<div class="model">
			<h2 style="font-size: 16px;font-weight: bold;margin: 0;"><a href="/juliet-balcony/standard-model/3560?type=2&color=3&glass=1">3560mm</a></h2>

			<p class="subtitle">up to 3300mm opening</p>
			<a href="/juliet-balcony/standard-model/3560?type=2&color=3&glass=1" title="3560 mm wide Juliet Balcony - 5 working day delivery"><img alt="3560 mm wide Juliet Balcony" src="https://www.balconette.co.uk/content/uploads/482242d2-cfd1-472b-a7cd-77995424080e/b2bal-356-white.jpg" style="width:150px; border: 5px #ffffff solid; -webkit-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; -moz-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important;"> </a>

			<p class="oldPrice" style="text-decoration: line-through;">£867.30 + VAT &nbsp;</p>

			<p class="newPrice area_color">£826.00 + VAT</p>
			<a class="btnSelect k-button" href="/juliet-balcony/standard-model/3560?type=2&color=3&glass=1">Select</a></div>
			</td>
			<td>
			<div class="model">
			<h2 style="font-size: 16px;font-weight: bold;margin: 0;"><a href="/juliet-balcony/standard-model/4000?type=2&color=3&glass=1">4000mm</a></h2>

			<p class="subtitle">up to 3740mm opening</p>
			<a href="/juliet-balcony/standard-model/4000?type=2&color=3&glass=1" title="2840 mm wide Juliet Balcony - 5 working day delivery"><img alt="4000 mm wide Juliet Balcony" src="https://www.balconette.co.uk/images/juliettes/standards/med/1/3/3200.jpg" style="width:150px; border: 5px #ffffff solid; -webkit-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; -moz-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important;"> </a>

			<p class="oldPrice" style="text-decoration: line-through;">£976.50 + VAT &nbsp;</p>

			<p class="newPrice area_color">£930.00 + VAT</p>
			<a class="btnSelect k-button" href="/juliet-balcony/standard-model/4000?type=2&color=3&glass=1">Select</a></div>
			</td>
			<td>
			<div class="model">
			</div>
			</td>
		</tr>
	</tbody>
</table>







<div style="text-align: center;"><a href="/juliet-balcony/quote-custom"><img alt="custom juliet balconies" src="/content/uploads/74bc1534-97aa-4b05-9866-609c267729f0/custom-juliet.jpg"></a></div>
</div>
</div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/kendo.dropdownlist.min.js" type="text/javascript"></script>
<script type="text/javascript">

    function getDetails(sid, type, color, glass) {
        $.ajax({
            dataType: "html",
            type: 'POST',
            url: '<%=Url.Action("standard-model-ajax")%>',
            data: {
                id: sid,
                type: type,
                color: color,
                glass: glass,
                vat: "<%=Model.VATSum.HasValue.ToString()%>"
            },
            success: function (data, textStatus, xhr) {
                $("#ajxCont").html(data);
                load();
				$(".fancybox-spc-sz").fancybox({
    maxWidth: 800,
    maxHeight: 600,
    fitToView: false,
    width: '70%',
    height: '70%',
    autoSize: false,
    closeClick: false,
    openEffect: 'none',
    closeEffect: 'none',
    beforeLoad: function () {
        this.width = parseInt(this.element.data('fancybox-width'));
        this.height = parseInt(this.element.data('fancybox-height'));
    },
    beforeShow: function () {

    },
    helpers: {
        overlay: {
            locked: false
        }
    }
}); 
            }
        });
    }

    function load() {
        var ddlType = $("#TypeId").kendoDropDownList({
            dataTextField: "Name",
            dataValueField: "ID",
            dataSource: {
                type: "odata",
                serverFiltering: true,
                transport: {
                    read: "<%=Url.Action("GetTypes")%>"
                }
            },
            select: function (e) {
                var dataItem = this.dataItem(e.item.index());
                getDetails(ddlStd.data("kendoDropDownList").value(), dataItem.ID, ddlColor.data("kendoDropDownList").value(), ddlGlass.data("kendoDropDownList").value());
            }
        });

        var ddlStd = $("#StandardId").kendoDropDownList({
            autoBind: false,
            dataTextField: "Name",
            dataValueField: "ID",
            cascadeFrom: "TypeId",
            dataSource: {
                type: "odata",
                serverFiltering: true,
                transport: {
                    read: "<%=Url.Action("GetStandards")%>"
                }
            },
            select: function (e) {
                var dataItem = this.dataItem(e.item.index());
                getDetails(dataItem.ID, ddlType.data("kendoDropDownList").value(), ddlColor.data("kendoDropDownList").value(), ddlGlass.data("kendoDropDownList").value());
            }
        });

        var ddlColor = $("#ColorId").kendoDropDownList({
            autoBind: false,
            dataTextField: "Name",
            dataValueField: "ID",
            cascadeFrom: "TypeId",
            dataSource: {
                type: "odata",
                serverFiltering: true,
                transport: {
                    read: "<%=Url.Action("GetColors")%>"
                }
            },
            select: function (e) {
                var dataItem = this.dataItem(e.item.index());
                getDetails(ddlStd.data("kendoDropDownList").value(), ddlType.data("kendoDropDownList").value(), dataItem.ID, ddlGlass.data("kendoDropDownList").value());
            }
        });

        var ddlGlass = $("#GlassId").kendoDropDownList({
            autoBind: false,
            dataTextField: "Name",
            dataValueField: "ID",
            cascadeFrom: "TypeId",
            dataSource: {
                type: "odata",
                serverFiltering: true,
                transport: {
                    read: "<%=Url.Action("GetStandardGlasses")%>"
                }
            },
            select: function (e) {
                var dataItem = this.dataItem(e.item.index());
                getDetails(ddlStd.data("kendoDropDownList").value(), ddlType.data("kendoDropDownList").value(), ddlColor.data("kendoDropDownList").value(), dataItem.ID);
            }
        });

        $("#Quantity").kendoNumericTextBox({
            format: "n0",
            min: 1,
            max: parseInt("<%=AppSettings.MAX_QUANTITY%>"),
            step: 1
        });
    }

    $(document).ready(function () {
        load();
    });

</script>
</asp:Content>
