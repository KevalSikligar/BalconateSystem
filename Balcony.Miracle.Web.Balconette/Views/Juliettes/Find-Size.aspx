<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<CustomJulietteQuoteModel>" %>

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
        margin-bottom: 10px;
    }
    #type-and-color p.small {
        margin-bottom: 5px;
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
        vertical-align: bottom;
    }
    #sectionImage {
        height: 430px;
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
        text-align: center;
    }
    #next_cell input {
        font-weight: bold;
        font-size: 15px;
        width: 170px;
        white-space: normal;
    }
    .mes span.label {
        width: 40px;
        text-align: right;
        display: inline-block;
    }
    #type-and-color span.num {
        font-weight: bold;
    }
    #modelImage {
        width: 550px;
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
		<li class="last"><%:Model.Page.Name %></li>
	</ul>
    <h1><%:Model.Page.Name %></h1>
    <div>
        <%=ViewBag.Body %>
    </div>
    <% using (Html.BeginForm("find-size", null, FormMethod.Post, new { id="frm" })) { %>
    <%:Html.HiddenFor(m => m.MinWidth) %>
    <%:Html.HiddenFor(m => m.MaxWidth) %>
    <div id="type-and-color">
        <p>
            <span class="num area_color">1. Enter your opening width</span>
            <%:Html.TextBoxFor(m => m.Width, new { style="width: 60px", @class="k-textbox only-numbers ta-center", autocomplete = "off", maxlength="5" }) %>
            <%:Html.ValidationMessageFor(m => m.Width) %>
            <span style="font-style: italic;">
                &nbsp; Based on the size we will offer the closest Fast-track sized Juliet or offer a custom size option    
            </span>
        </p>        
        <p class="small">            
            <span class="num area_color">2. Choose system type</span>
            <%:Html.TextBoxFor(m => m.TypeId, new { style="width: 300px" }) %>
        </p>
        <% foreach (var type in ViewBag.Types) { %>
        <p class="small" style="margin-left: 10px;">
            <%=type.Name %>
            - This system is suitable for an opening of up to <%=(type.MaxWidth - type.AppendToHandrail2) %>mm
        </p>
        <% } %>
        <p>
            <span class="num area_color">3. Choose colour</span>
            <%:Html.TextBoxFor(m => m.ColorId, new { style="width: 200px" }) %>
        </p>
    </div>
    <div id="middle_wrap">
        <div id="section_cell">
            <img id="sectionImage" src="/images/juliettes/sections/<%=Model.TypeId %>.jpg" alt=" Section" /> 
        </div>
        <div id="model_cell">
            <img id="modelImage" src="/images/juliettes/custom/<%=Model.TypeId %>/<%=Model.ColorId %>.jpg" alt="Find the juliet balcony size you need." />
        </div>
        <div id="next_cell">
            <div id="btn-find-standard">
                <input type="submit" class="k-button area_color" name="cmd" value="Find standard size" title="" />
                <span class="msg" style="display: none;">No standard size available for this opening</span>
                <br/><br/>
                <span class="or">Or</span>
            </div>
            
            <br/>
            <div id="btn-quote-custom">
                <input type="submit" class="k-button prog1 area_color" name="cmd" value="Get a quote for custom size" title="" />
                <span class="msg" style="display: none;">No custom size available for this opening</span>
            </div>
        </div>
    </div>
    <% } %>    
</div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/kendo.dropdownlist.min.js" type="text/javascript"></script>
<script type="text/javascript">

    var types = eval(<%=Json.Encode(((IEnumerable<JulietteType>)ViewBag.Types).Select(t => new {
                id = t.ID, 
                ws = t.WidthStep, 
                a1 = t.AppendToHandrail1, 
                a2 = t.AppendToHandrail2, 
                mx = t.MaxWidth,
                name = t.Name
            })) %>);

    var standards = eval(<%=Json.Encode(ViewBag.Standards) %>);

    var typesDict = {};
    for (var i = 0; i < types.length; i++) {
        var type = types[i];
        typesDict[type.id] = type;
    }

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
            select: function(e) {                
                var dataItem = this.dataItem(e.item.index());
                $("#MinWidth").val(dataItem.MinWidth);
                $("#MaxWidth").val(dataItem.MaxWidth);
                updateImages(dataItem.ID, ddlColor.data("kendoDropDownList").value());
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
            select: function(e) {                
                var dataItem = this.dataItem(e.item.index());
                updateImages(ddlType.data("kendoDropDownList").value(), dataItem.ID);
            },
            dataBound: function () {
                updateImages(ddlType.data("kendoDropDownList").value(), ddlColor.data("kendoDropDownList").value());
            }
        });

        $("#Width").keyup(function() {
            var w = parseInt($(this).val());
            w = isNaN(w) ? 0 : w;
            var typeId = parseInt(ddlType.data("kendoDropDownList").value());
            var type = typesDict[typeId];

            if (w <= type.ws - type.a1) {
                w = w + type.a1;
            } else {
                w = w + type.a2;
            }

            var filtered = standards.filter(function(x) {
                return w <= x;
            });

            var hasStandard = filtered.length > 0;

            $("#btn-find-standard input").toggle(hasStandard);
            $("#btn-find-standard span.msg").toggle(!hasStandard);
            $("#btn-find-standard span.or").toggle(hasStandard);

            var hasCustom = w <= type.mx;

            $("#btn-quote-custom input").toggle(hasCustom);
            $("#btn-quote-custom span.msg").toggle(!hasCustom);
        });
    });
</script>
</asp:Content>
