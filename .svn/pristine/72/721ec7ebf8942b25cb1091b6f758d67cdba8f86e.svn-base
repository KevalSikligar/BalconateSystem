<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="ViewPage<DeliveryCalculatorModel>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<style type="text/css">
    label {
        width: 100px;
        display: inline-block;
        text-align: right;
        margin-right: 10px;
    }
    h1 {
         margin-bottom: 20px;
         margin-top: 10px;
         text-align: center;
    }
    form#form0 {
        max-width: unset !important;
    }
    #get_quote_btn {
        font-weight: bold;
        font-size: 15px;
    }
    .ddl {
        width: 200px;
    }
    #btnCalc {
        font-weight: bold;
        font-size: 14px;
    }
    span.field-validation-error {
        display: block;
    }
    #results {
        font-weight: bold;
        font-size: 14px;
    }

    @media only screen and (max-width: 659px) {
        html {
            height: auto;
        }
        body {
            top: 0;
            font-size: 14px;
            height: auto;
        }
        h1 {
            font-size: 22px;
            color: red !important;
        }
        p, span, input, a, label {
            font-size: 14px !important;
        }
        input[type=submit]{
            color: red !important;
        }
    }
</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">    
    <% using (Ajax.BeginForm(new AjaxOptions { HttpMethod = "POST", UpdateTargetId = "results" })) { %>
        <%:Html.HiddenFor(m => m.StandardId) %>
        <%:Html.HiddenFor(m => m.TypeId) %>
        <%:Html.HiddenFor(m => m.ColorId) %>
        <%:Html.HiddenFor(m => m.GlassId) %>
        <h1>Delivery Calculator</h1>
        <p>
            <label>Country:</label>
            <%:Html.TextBox("country", "", new { @class="ddl" })%>
        </p>
        <p>
            <label>Region:</label>
            <%:Html.TextBox("region", "", new { disabled="disabled", @class="ddl" })%>
        </p>
        <p>
            <label>Sub region:</label>
            <%:Html.TextBoxFor(m => m.SubRegionId, new { disabled="disabled", @class="ddl" })%>
            <%:Html.ValidationMessageFor(m => m.SubRegionId) %>
        </p>
        <p>
            <input id="btnCalc" type="submit" value="Calculate ..." class="k-button area_color prog1" />
        </p>

        <div id="results"></div>

        <p style="margin-top: 30px; font-weight:normal;">Delivery cost will be added during the checkout process and after filling in your invoice and billing details.</p>

    <% } %>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
<script src="/scripts/kendo.dropdownlist.min.js" type="text/javascript"></script>
<script type="text/javascript">

    $(document).ready(function () {

        $('.slicknav_menu').hide();
        
        $("#country").kendoDropDownList({
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

        $("#region").kendoDropDownList({
            autoBind: false,
            cascadeFrom: "country",
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
            cascadeFrom: "region",
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



    });
</script>
</asp:Content>
