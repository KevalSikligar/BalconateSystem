<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<CurvedDoorQuoteModel>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<style type="text/css">
    h1 {
        margin-bottom: 15px;
    }

    .main p {
        margin-bottom: 0;
    }
    #type-and-color p {
        margin-right: 10px;
        float: left;
        margin-bottom: 10px;
    }
    #model_cell {
        position: relative;
        vertical-align: middle;
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
        vertical-align: middle;
    }
    #section_drawing img {
        height: 300px;
        width: 200px;
        border: 1px;
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
        width: 200px;
    }
    #next_cell input {
        font-weight: bold;
        font-size: 15px;
    }
    #next_cell img {
        vertical-align: middle;
        text-decoration: none !important;
        margin-right: 3px;
    }
    .mes span.label {
        width: 40px;
        text-align: right;
        display: inline-block;
    }
    span.field-validation-error {
        display: block;
        clear: both;
    }
    #type-and-color span.num {
        font-weight: bold;
        font-size: 1.4em;
    }
    #modelImage {
        width: 700px;
        height: 380px;
    }
    
    p.back-to-quote {
        margin-bottom: 10px;
    }
</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="main curvedprod">
    <ul id="cookie-menu">
		<li><a href="/">Home</a></li>
        <% if (ViewBag.Area != AreaKind.General) { %>
        <li><a href="<%=ViewBag.AreaUrl %>"><%:ViewBag.AreaName %></a></li>
		<% } %>
		<li><a href="<%:Url.Action("Quote", new { id = "" }) %>">Choose Shape</a></li>
		<li class="last"><%=Model.H1 %></li>
	</ul>
    <h1><%=Model.H1 %></h1>
	<p class="toplinksp"><a href="/curved-doors/homepage" style="color: rgb(102, 102, 102); line-height: 20.8px; text-align: center;">Curved Glass Doors</a><span style="line-height: 20.8px; text-align: center;">&nbsp;&nbsp;|&nbsp;&nbsp;</span><a href="/curved-doors/technical-details" style="color: rgb(102, 102, 102); line-height: 20.8px; text-align: center;">Tech Specs</a><span style="line-height: 20.8px; text-align: center;">&nbsp;&nbsp;|&nbsp;&nbsp;</span><a href="/curved-doors/how-to-install-curved-doors" style="color: rgb(102, 102, 102); line-height: 20.8px; text-align: center;">Installation</a><span style="line-height: 20.8px; text-align: center;">&nbsp;&nbsp;|&nbsp;&nbsp;</span><a href="/curved-doors/photos" style="color: rgb(102, 102, 102); line-height: 20.8px; text-align: center;">Gallery</a><span style="line-height: 20.8px; text-align: center;">&nbsp;&nbsp;|&nbsp;&nbsp;</span><a href="/curved-doors/case-studies" style="color: rgb(102, 102, 102); line-height: 20.8px; text-align: center;">Projects</a><span style="line-height: 20.8px; text-align: center;">&nbsp;&nbsp;|&nbsp;&nbsp;</span><a href="/curved-doors/articles" style="color: rgb(102, 102, 102); line-height: 20.8px; text-align: center;">Articles</a></p>    
	<p style="margin: 20px 0 40px;">(Need a different model? <a href="<%=Url.Action("quote", new{ id = (string)null }) %>">Click here</a>)</p>
    <% using (Html.BeginForm("Quote", null, FormMethod.Post, new { id="frm" })) { %>
    <%:Html.HiddenFor(m => m.TypeId) %>
    <%:Html.HiddenFor(m => m.MinHeight) %>
    <%:Html.HiddenFor(m => m.MaxHeight) %>
    <%:Html.HiddenFor(m => m.MinLength) %>
    <%:Html.HiddenFor(m => m.MaxLength) %>
    <div id="type-and-color">
        <p>
            <label>
                <span class="num">1.</span>
                Choose door colour:  <abbr title="Pick from a list of available colours for the door frames" rel="tooltip"><img class="qmarkinfo" src="/images/qmark1311.png" alt="Choose the door colour."></abbr>
            </label>
            <%:Html.TextBoxFor(m => m.ColorId, new { style="width: 163px" }) %>
        </p>
        <p>
            <label>
                <span class="num">2.</span>
                Choose glass type:  <abbr title="Pick the glass type for your doors from a list of available glass options." rel="tooltip"><img class="qmarkinfo" src="/images/qmark1311.png" alt="Choose the door glass type."></abbr>
            </label>
            <%:Html.TextBoxFor(m => m.GlassId, new { style="width: 550px" }) %>
        </p>
        <p class="float-none clear">
            <span class="num">3.</span>
            Please fill in dimensions below:  <abbr title="Fill in the dimensions of your door requirement in the relevant box/es and click “next”. The curved length will be determined either by filling in the external length of the curve OR filling in the width and depth. Please note that the sizes are in millimetres." rel="tooltip"><img class="qmarkinfo" src="/images/qmark1311.png" alt="Choose the door dimensions."></abbr>
        </p>
    </div>
    <div id="middle_wrap">
        <div id="model_cell">
            <img id="modelImage" src="/images/curved-doors/arrows/<%=Model.CurvedDoorModelShortName.ToLower() %>.png" alt="<%:Model.CurvedDoorModelName %>" />                                   
            <div class="mes" style="left: <%:Model.LengthPosition.X%>px; top: <%:Model.LengthPosition.Y%>px;">
                <div style="margin-bottom: 5px;">
                    <span class="label">Length</span>
                    <%:Html.TextBoxFor(m => m.Length, new { @class="k-textbox only-numbers", style="width: 50px", autocomplete = "off" }) %>
                    <span>mm</span>
                    <%:Html.ValidationMessageFor(m => m.Length) %>
                </div>
            </div>
            <div class="mes" style="left: <%:Model.HeightPosition.X%>px; top: <%:Model.HeightPosition.Y%>px;">
                <div style="margin-bottom: 5px;">
                    <span class="label">Height</span>
                    <%:Html.TextBoxFor(m => m.Height, new { @class="k-textbox only-numbers", style="width: 50px", autocomplete = "off" }) %>
                    <span>mm</span>
                    <%:Html.ValidationMessageFor(m => m.Height) %>
                </div>
            </div>
            <div class="mes" style="left: <%:Model.WidthPosition.X%>px; top: <%:Model.WidthPosition.Y%>px;">
                <div style="margin-bottom: 5px;">
                    <span class="label">Width</span>
                    <%:Html.TextBoxFor(m => m.Width, new { @class="k-textbox only-numbers", style="width: 50px", autocomplete = "off" }) %>
                    <span>mm</span>
                    <%:Html.ValidationMessageFor(m => m.Width) %>
                </div>
            </div>
            <div class="mes" style="left: <%:Model.DepthPosition.X%>px; top: <%:Model.DepthPosition.Y%>px;">
                <div style="margin-bottom: 5px;">
                    <span class="label">Depth</span>
                    <%:Html.TextBoxFor(m => m.Depth, new { @class="k-textbox only-numbers", style="width: 50px", autocomplete = "off" }) %>
                    <span>mm</span>
                    <%:Html.ValidationMessageFor(m => m.Depth) %>
                </div>
            </div>
        </div>
        <div id="next_cell">
            <p>
                <input type="submit" class="k-button prog1 area_color" value="<%:this.IsCustomerOrQuoteCustomer() ? "Get Quote ..." : "Next ..." %>" title="Click here to get a quote" />
            </p>
            <p>&nbsp;</p>
            <p class="ta-left">
                <a href="/pdfs/curved-doors/technical-details/<%=Model.ShortName.ToLower()%>.pdf" target="_blank" style="white-space: nowrap">
                    <img src="/images/pdf.png" alt="pdf" />Technical Details
                </a>
            </p>
            <p>&nbsp;</p>
            <p class="ta-left">
                <a href="/images/curved-doors/plan/<%=Model.ShortName.ToLower()%>.jpg" target="_blank" style="white-space: nowrap">
                    <img src="/images/magnifying-glass-brown.jpg" alt="pdf" />Plan View
                </a>
            </p>
        </div>
    </div>
	<div class="cpd-quote-model-info">
	    <%=Model.ProductDescription %>
	</div>
	
    <% } %>    
	
	<h2>Need a different model?</h2>
	
	<div id="modelscpdpage">
<div class="model">
<h2>W2 - 2 Doors Sliding</h2>
<a class="fancybox" href="/curved-doors/quote/w2" rel="sidegal" title="Curved Glass Sliding Doors - W2"><img alt="Curved Glass Sliding Doors - W2" src="/images/curved-doors/thumb/W2.jpg"> </a>

<p>&nbsp;</p>
<a class="btnSelect k-button" href="/curved-doors/quote/w2">Select</a></div>

<div class="model">
<h2>W2F - 2 Doors One Sliding One Fixed</h2>
<a class="fancybox" href="/curved-doors/quote/w2f" rel="sidegal" title="Curved Glass Sliding Doors - W2F"><img alt="Curved Glass Sliding Doors - W2F" src="/images/curved-doors/thumb/W2F.jpg"> </a>

<p>&nbsp;</p>
<a class="btnSelect k-button" href="/curved-doors/quote/w2f">Select</a></div>

<div class="model">
<h2>W3F - 3 Doors Two Sliding One Fixed</h2>
<a class="fancybox" href="/curved-doors/quote/w3f" rel="sidegal" title="Curved Glass Sliding Doors - W3F"><img alt="Curved Glass Sliding Doors - W3F" src="/images/curved-doors/thumb/W3F.jpg"> </a>

<p>&nbsp;</p>
<a class="btnSelect k-button" href="/curved-doors/quote/w3f">Select</a></div>

<div class="model">
<h2>W3-2F - 3 Doors, One sliding, two fixed</h2>
<a class="fancybox" href="/curved-doors/quote/w3-2f" rel="sidegal" title="Curved Glass Sliding Doors - W3-2F"><img alt="Curved Glass Sliding Doors - W3-2F" src="/images/curved-doors/thumb/W3-2F.jpg"> </a>

<p>&nbsp;</p>
<a class="btnSelect k-button" href="/curved-doors/quote/w3-2f">Select</a></div>

<div class="model">
<h2>W4 - 4 Doors Sliding on two rails</h2>
<a class="fancybox" href="/curved-doors/quote/w4" rel="sidegal" title="Curved Glass Sliding Doors - W4"><img alt="Curved Glass Sliding Doors - W4" src="/images/curved-doors/thumb/W4.jpg"> </a>

<p>&nbsp;</p>
<a class="btnSelect k-button" href="/curved-doors/quote/w4">Select</a></div>

<div class="model">
<h2>W4F - 4 Doors Two Sliding Two Fixed</h2>
<a class="fancybox" href="/curved-doors/quote/w4f" rel="sidegal" title="Curved Glass Sliding Doors - W4F"><img alt="Curved Glass Sliding Doors - W4F" src="/images/curved-doors/thumb/W4F.jpg"> </a>

<p>&nbsp;</p>
<a class="btnSelect k-button" href="/curved-doors/quote/w4f">Select</a></div>

<div class="model">
<h2>W6F - 6 Doors Four Sliding Two Fixed</h2>
<a class="fancybox" href="/curved-doors/quote/w6f" rel="sidegal" title="Curved Glass Sliding Doors - W6F"><img alt="Curved Glass Sliding Doors - W6F" src="/images/curved-doors/thumb/W6F.jpg"> </a>

<p>&nbsp;</p>
<a class="btnSelect k-button" href="/curved-doors/quote/w6f">Select</a></div>

<div class="model">
<h2>W6-4F - 6 Doors, 2 Sliding and Four are fixed</h2>
<a class="fancybox" href="/curved-doors/quote/w6-4f" rel="sidegal" title="Curved Glass Sliding Doors - W6-4F"><img alt="Curved Glass Sliding Doors - W6-4F" src="/images/curved-doors/thumb/W6-4F.jpg"> </a>

<p>&nbsp;</p>
<a class="btnSelect k-button" href="/curved-doors/quote/w6-4f">Select</a></div>

<div class="model">
<h2>W8-4F - 8 Doors, 4 Sliding, 4 Fixed</h2>
<a class="fancybox" href="/curved-doors/quote/w8-4f" rel="sidegal" title="Curved Glass Sliding Doors - W8-4F"><img alt="Curved Glass Sliding Doors - W8-4F" src="/images/curved-doors/thumb/W8-4F.jpg"> </a>

<p>&nbsp;</p>
<a class="btnSelect k-button" href="/curved-doors/quote/w8-4f">Select</a></div>

<div class="model">
<h2>W8-6F - 8 Doors, 2 Sliding, 6 Fixed</h2>
<a class="fancybox" href="/curved-doors/quote/w8-6f" rel="sidegal" title="Curved Glass Sliding Doors - W8-6F"><img alt="Curved Glass Sliding Doors - W8-6F" src="/images/curved-doors/thumb/W8-6F.jpg"> </a>

<p>&nbsp;</p>
<a class="btnSelect k-button" href="/curved-doors/quote/w8-6f">Select</a></div>
</div>
</div>

<script src="/Scripts/tooltip.js"></script>

</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/kendo.dropdownlist.min.js" type="text/javascript"></script>
<script type="text/javascript">

    $(function () {
        $("#ColorId").kendoDropDownList({
            dataTextField: "Name",
            dataValueField: "ID",
            dataSource: {
                type: "odata",
                transport: {
                    read: "<%=Url.Action("GetColors")%>"
                }
            }
        });

        $("#GlassId").kendoDropDownList({
            dataTextField: "Name",
            dataValueField: "ID",
            dataSource: {
                type: "odata",
                transport: {
                    read: "<%=Url.Action("GetGlasses")%>"
                }
            }
        });

        function updateMes() {
            var width = parseInt($("#Width").val());
            var depth = parseInt($("#Depth").val());
            $("#Length").val("");
            if (depth > 0 && width > 0) {
                var r = (((width * width) / 8) / depth) + (depth / 2);
                var a = (Math.asin(width / 2 / r) * 2) * (180 / Math.PI);
                if (2 * depth > width)
                    a = 360 - a;
                var l = Math.ceil((a / 360) * 2 * Math.PI * r);
                $("#Length").val(l);
            }
        }

        $("#Width").keyup(updateMes);

        $("#Depth").keyup(updateMes);

        $("#Length").keyup(function() {
            $("#Width").val("");
            $("#Depth").val("");
        });
    });
</script>
</asp:Content>
