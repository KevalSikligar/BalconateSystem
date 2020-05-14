<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<CustomJulietteQuoteModel>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<style type="text/css">
    h1 {
        margin-bottom: 15px;
    }
   
    #type-and-color p {
        margin-right: 10px;
        float: left;
        margin-bottom: 10px;
    }
    #model_cell {
        position: relative;
        vertical-align: bottom;
        display: table-cell;
    }
    #model_cell .mes {
        position: absolute;
        padding: 5px;
        overflow: visible;
        white-space: nowrap;
    }
    #model_cell .mes input {
        width: 80px;
        text-align: right;
    }
    #section_cell {
        display: table-cell;
        vertical-align: bottom;
        padding-right: 5px;
        text-align: center;
        font-weight: bold;
    }
    #sectionImage {
        width: 200px;
    }

    #middle_wrap {
        display: table;
        margin: 0 auto;
    }
    #next_cell {
        display: table-cell;
        vertical-align: middle;
        padding-left: 20px;
        font-weight: bold;
        width: 150px;
    }
    #next_cell input {
        font-weight: bold;
        font-size: 15px;
    }
    .mes span.label {
        width: 40px;
        text-align: right;
        display: inline-block;
    }
    #type-and-color span.num {
        font-weight: bold;
        font-size: 1.4em;
    }
</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="main quote-custom">
    <ul id="cookie-menu">
		<li><a href="/">Home</a></li>
        <% if (ViewBag.Area != AreaKind.General) { %>
        <li><a href="<%=ViewBag.AreaUrl %>"><%:ViewBag.AreaName %></a></li>
		<% } %>
		<li class="last"><%:Model.Page.Name %></li>
	</ul>
    <h1>Custom Juliet Balcony</h1>
	<p class="toplinksp"><a href="/juliet-balcony/homepage" style="color:#666;">Juliet Balconies</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/juliet-balcony/technical-details" style="color:#666;">Tech Specs</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/juliet-balcony/how-to-install-juliet-glass-balconies" style="color:#666;">Installation</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/juliet-balcony/photos" style="color:#666;">Gallery</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/juliet-balcony/case-studies" style="color:#666;">Projects</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/juliet-balcony/articles" style="color:#666;">Articles</a></p>
	<p style="margin: 20px 0 40px;">We can manufacture a Juliet balcony to suit your exact requirement. Please enter the width of the opening that you have. We will calculate the size that is required for that opening. Choose a colour and the glass you would like and get an instant price.</p>
    <% using (Html.BeginForm("quote-custom", null, FormMethod.Post, new { id="frm" })) { %>
    <%:Html.HiddenFor(m => m.MinWidth) %>
    <%:Html.HiddenFor(m => m.MaxWidth) %>

    <div id="type-and-color">
			<p>
            <label>
                <span class="num">1.</span>
                Enter opening width: <abbr title="Pick the Juliet size from the list. Please note this will be the handrail size and must be a minimum of 260mm (26cm) larger than the opening width. Watch as the image below changes to the size you have chosen." rel="tooltip"><img class="qmarkinfo" src="/images/qmark1311.png" alt="Set Juliet width"></abbr>
            </label>
            <%:Html.TextBoxFor(m => m.Width, new { style="width: 60px", @class="k-textbox only-numbers ta-center", autocomplete = "off" }) %>
            <%:Html.ValidationMessageFor(m => m.Width) %>
        </p>        
        <p>
            <label>
                <span class="num">2.</span>
                Choose System: <abbr title="Choose from the 4 different system options available. You can see the section and 3D model change in the image below as you choose different options." rel="tooltip"><img class="qmarkinfo" src="/images/qmark1311.png" alt="Choose handrail type"></abbr>
            </label>
            <%:Html.TextBoxFor(m => m.TypeId, new { style="width: 300px" }) %>
        </p>
        <p>
            <label>
                <span class="num">3.</span>
                Choose Colour: <abbr title="Pick from a list of available colours for the metalwork. Watch as the Juliet image below changes to the colour you choose." rel="tooltip"><img class="qmarkinfo" src="/images/qmark1311.png" alt="Choose the handrail and fixings colour."></abbr>
            </label>
            <%:Html.TextBoxFor(m => m.ColorId, new { style="width: 160px" }) %>
        </p>
        <p>
            <label>
                <span class="num">4.</span>
                Choose Glass: <abbr title="Pick the glass type for your Juliet balcony from a list of available glass options." rel="tooltip"><img class="qmarkinfo" src="/images/qmark1311.png" alt="Choose the glass type."></abbr>
            </label>
            <%:Html.TextBoxFor(m => m.GlassId, new { style="width: 100%" }) %>
        </p>
    </div>
    <div id="middle_wrap">
        <div id="section_cell">
            <div>Section</div>
            <img id="sectionImage" src="/images/juliettes/sections/<%=Model.TypeId %>.jpg" alt=" Section" /> 
        </div>
        <div id="model_cell">
            <img id="modelImage" src="/images/juliettes/custom/<%=Model.TypeId %>/<%=Model.ColorId %>.jpg" alt="Juliet Balcony - Custom size" />
        </div>
        <div id="next_cell">
            <input type="submit" class="k-button prog1 area_color" value="<%:this.IsCustomerOrQuoteCustomer() ? "Get Quote ..." : "Next ..." %>" title="Click here to get a quote" />
        </div>
    </div>
    <% } %>    
</div>

<script src="/Scripts/tooltip.js"></script>

</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/kendo.dropdownlist.min.js" type="text/javascript"></script>
<script type="text/javascript">

    function updateImages(typeId, colorId) {
        $("#modelImage").attr("src", "/images/juliettes/custom/" + typeId + "/" + colorId + ".jpg");
        $("#sectionImage").attr("src", "/images/juliettes/sections/" + typeId + ".jpg");
    }

    $(function() {
        var ddlType = $("#TypeId").kendoDropDownList({
            dataTextField: "Name",
            dataValueField: "ID",
            dataSource: {
                type: "odata",
                transport: {
                    read: "<%=Url.Action("GetTypes")%>"
                }
            },
            select: function (e) {
                var dataItem = this.dataItem(e.item.index());
                $("#MinWidth").val(dataItem.MinWidth);
                $("#MaxWidth").val(dataItem.MaxWidth);
            }
        });

        var ddlColor = $("#ColorId").kendoDropDownList({
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
                updateImages(ddlType.data("kendoDropDownList").value(), dataItem.ID);
            },
            dataBound: function () {
                updateImages(ddlType.data("kendoDropDownList").value(), ddlColor.data("kendoDropDownList").value());
            }
        });

        $("#GlassId").kendoDropDownList({
            dataTextField: "Name",
            dataValueField: "ID",
            cascadeFrom: "TypeId",
            dataSource: {
                type: "odata",
                serverFiltering: true,
                transport: {
                    read: "<%=Url.Action("GetCustomGlasses")%>"
                }
            }
        });
    });
</script>
</asp:Content>
