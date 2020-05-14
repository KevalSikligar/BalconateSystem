<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<BalustradeQuoteModel>" %>

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
        width: 150px;
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
        width: 90px;
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
    #ajxCont {
        min-height: 570px;
    }
    #ajxCont h1 {
        margin-bottom: 0;
    }
    #ajxCont .back-to-quote {
        margin-bottom: 10px;
    }
</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="main singleprodpage">
    <ul id="cookie-menu">
		<li><a href="/">Home</a></li>
        <% if (ViewBag.Area != AreaKind.General) { %>
        <li><a href="<%=ViewBag.AreaUrl %>"><%:ViewBag.AreaName %></a></li>
		<% } %>
		<li><a href="<%:Url.Action("Quote", new { id = "" }) %>">Choose Shape</a></li>
		<li class="last">Enter Details</li>
	</ul>
    <% using (Html.BeginForm("Quote", null, FormMethod.Post, new { id="frm" })) { %>
        <%:Html.HiddenFor(m => m.ModelId) %>
        <%:Html.HiddenFor(m => m.P) %>
        <div id="ajxCont">
            <%:Html.Partial("ModelDetails", Model) %>
        </div>
    <% } %>   
<div style="margin-top: 100px;">
<h2>Need a different model?</h2>
<table cellpadding="5" cellspacing="5" class="baltopmodelstd">
	<tbody>
		<tr>
			<td><a href="/glass-balustrade/quote/one-section"><img alt="1 section glass balustrade" src="/content/uploads/cd59a5bb-22eb-457c-9c26-666a63bf99cb/1section-balustrade.jpg"></a></td>
			<td><a href="/glass-balustrade/quote/two-sections"><img alt="2 section glass balustrade" src="/content/uploads/629ebd89-a62f-48e1-b54f-70d72a959743/2section-balustrade.jpg"></a></td>
			<td><a href="/glass-balustrade/quote/three-sections"><img alt="3 section glass balustrade" src="/content/uploads/4fc4a66f-e6a5-43aa-b8ce-2463306085c4/3section-balustrade.jpg"></a></td>
		</tr>
		<tr>
			<td><a href="/glass-balustrade/quote/4-sided"><img alt="4 sides glass balustrade" src="/content/uploads/c11c4755-22d6-4c53-9804-d5a5d95a6485/4section-balustrade.jpg"></a></td>
			<td><a href="/glass-balustrade/quote/five-sided"><img alt="5 sides glass balustrade" src="/content/uploads/7b5fcf56-8d27-4521-bcaa-3cbc4017c6cf/5section-balustrade.jpg"></a></td>
			<td><a href="/glass-balustrade/quote/curved"><img alt="curved glass balustrade" src="/content/uploads/49883371-1f42-411c-96a0-09bc22c718e8/curved.jpg"></a></td>
		</tr>
	</tbody>
</table>	
</div>
</div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/kendo.dropdownlist.min.js" type="text/javascript"></script>
<script type="text/javascript">

    function getDetails(type, color, glass) {

        var state = [];
        var mes = [];
        $(".bal-dim").each(function () {
            state.push([$(this).attr("id"), $(this).val()]);
            mes.push($(this).val());
        });

        function getParameterByName(name, url) {
            if (!url) url = window.location.href;
            name = name.replace(/[\[\]]/g, '\\$&');
            var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
                results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, ' '));
        }

        $.ajax({
            dataType: "html",
            type: 'POST',
            url: '<%=Url.Action("model-ajax")%>',
            data: {
                id: '<%=Model.ModelUrl%>',
                type: type,
                color: color,
                glass: glass,
                mes: mes.join(';'),
                p: getParameterByName('p')
            },
            success: function (data, textStatus, xhr) {
                $("#ajxCont").html(data);
                load();

                state.forEach(function(item) {
                    $("#" + item[0]).val(item[1]);
                });
            }
        });
    }

    $(document).ready(function () {
        load();
    });

    function load() {
        var ddlType = $("#TypeId").kendoDropDownList({
            /*optionLabel: "Select ...",*/
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
                getDetails(dataItem.ID, ddlColor.data("kendoDropDownList").value(), ddlGlass.data("kendoDropDownList").value());
            }
        });

        var ddlColor = $("#ColorId").kendoDropDownList({
            autoBind: false,
            cascadeFrom: "TypeId",
            dataTextField: "Name",
            dataValueField: "ID",
            dataSource: {
                type: "odata",
                serverFiltering: true,
                transport: {
                    read: "<%=Url.Action("GetColors")%>"
                }
            },
            select: function (e) {
                var dataItem = this.dataItem(e.item.index());
                getDetails(ddlType.data("kendoDropDownList").value(), dataItem.ID, ddlGlass.data("kendoDropDownList").value());
            }
        });

        var ddlGlass = $("#GlassId").kendoDropDownList({
            autoBind: false,
            cascadeFrom: "TypeId",
            dataTextField: "Name",
            dataValueField: "ID",
            dataSource: {
                type: "odata",
                serverFiltering: true,
                transport: {
                    read: "<%=Url.Action("GetGlasses")%>"
                }
            },
            select: function (e) {
                var dataItem = this.dataItem(e.item.index());
                getDetails(ddlType.data("kendoDropDownList").value(), ddlColor.data("kendoDropDownList").value(), dataItem.ID);
            }
        });

        $(".bal-dim").on('input', function () {
            $(".btnRefresh").show();
        });

        $(".btnRefresh").click(function () {

            if ($("#frm").valid()) {
                getDetails(ddlType.data("kendoDropDownList").value(),
                    ddlColor.data("kendoDropDownList").value(),
                    ddlGlass.data("kendoDropDownList").value());
            }

            return false;
        });
    }

    function updateImages(typeId, colorId) {
        var model = "<%=Model.ModelImage%>";
        $("#modelImage").attr("src", "/images/balustrades/arrows/b" + typeId + "/" + model + "/" + colorId + ".png");
        $("#sectionImage").attr("src", "/images/balustrades/sections/b" + typeId + ".jpg");
    }
</script>
</asp:Content>
