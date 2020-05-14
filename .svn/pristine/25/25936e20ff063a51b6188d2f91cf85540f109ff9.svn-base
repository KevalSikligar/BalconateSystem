<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<OrderPaymentModel>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<style type="text/css">
    label {
        width: 340px;
        display: inline-block;
        text-align: left;
        margin-right: 10px;
        max-width: 340px;
    }

    h1 {
        margin-bottom: 20px;
    }
   
    table.cartTable {
        border-collapse: collapse;
        width: 100%;
    }
    table.cartTable th.item {
        width: 80%;  
    }
    table.cartTable td,th {
        padding: 5px;
        border: 1px solid #383838;
        vertical-align: middle;
    }
    table.cartTable th {
        white-space: nowrap;
        font-weight: bold;
    }
    #big_cart {
        width: 980px;
    }

    #payment_methods {
        clear: both;
        width: 99%;
        padding: 10px;
    }

    #payment_methods .submit {
        font-weight: bold;
        font-size: 13px;
    }
    #payment_methods h2 {
        font-weight: bold;
        display: block;
        text-align: center;
    }
    #payment_methods .creditcard {
        float: left;
        padding: 10px;
        width: 520px;
        border-right: 1px dotted rgb(125, 125, 125);
    }
    #payment_methods .paypal {
        float: left;
        width: 400px;
        padding: 10px;
    }
    #billing_address label {
        width: 70px;
    }

    #terms-link {
        color: red;
    }

    .paypal-link {
        margin-bottom: 10px;
        display: block;
        text-align: center;
    }

    .paypal-logo {
        width: 40px;
        height: 18px;
        margin: 0;
        display: inline-block;
        background-image: url('../../images/paypal.png');
        background-repeat: no-repeat;
        background-size: contain;
        background-position-y: bottom;
    }

    .card_details p .exp-date-field {
        display: inline-block !important;
        float: left !important;
        margin-right: 15px !important;
    }

    .card_details p .k-header .k-dropdown-wrap {
        min-width: unset !important;
        max-width: unset !important;
    }

    .card_details p .exp-date-divider {
        margin-top: 10px;
    }

    .card_details p .cvv-field {
        margin-top: -22px;
        margin-bottom: 10px;
    }

    .card_details p .cvv-field label {
        display: block;
        margin-bottom: 1px;
    }

    .exp-date-label {
        width: 100%;
        display: block;
        margin-bottom: 3px;
    }

    .card-type-label {
        margin-bottom: 3px;
    }

    @media only screen and (max-width: 659px) {
        body {
            font-size: 14px;
        }

        .card_details p .exp-date-divider {
            margin-top: 15px;
        }

        .card_details p .cvv-field {
            margin-top: -12px;
            margin-bottom: 10px;
        }

        .exp-date-label {
            margin-bottom: -5px;
        }

        #btnCredit {
            font-size: 16px;
            font-weight: normal;
        }

        .card-type-label {
            margin-bottom: -5px;
        }

        .card_details p .cvv-field label {
            margin-bottom: 5px;
        }

    }
</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="main orderpayment">
	<ul id="cookie-menu">
		<li><a href="/">Home</a></li>
        <li><a href="<%:Url.Action("cart") %>">Shopping Cart</a></li>
		<li><a href="<%:Url.Action("order-details") %>">Order Details</a></li>
		<li class="last">Payment</li>
	</ul>
    <h1>Payment</h1>
    
    <% using (Html.BeginForm(null, null, FormMethod.Post, new { id="cart_form" })) { %>
    <%:Html.ValidationSummary() %>
    <input type="hidden" name="save" id="f_save" value="false"/>
    <div id="big_cart">
        <table class="cartTable">
            <thead>
                <tr>
                    <th class="item">Item</th>
                    <th>Unit Price</th>
                    <th>Quantity</th>
                    <th>Price</th>
                </tr>
            </thead>
            <tbody>
                <% var i = 0; %>
                <% foreach (var item in Model.Items) { %>
                <tr>
                    <td>
                        <%:Html.HiddenFor(m => m.Items[i].ID) %>
                        <% if (item.Quote != null) { %>
                        <a target="_blank" href="<%=Url.Action("Quote", "Customer", new { id = item.Quote.ID }) %>"><%=item.Name.ToHtml() %></a>
                        <% } else { %>
                        <%=item.Name.ToHtml() %>
                        <% } %>
                    </td>
                    <td class="ta-right no-wrap">
                        &pound;<%:item.Price.ToString("N02") %>
                    </td>
                    <td class="ta-center no-wrap">
                        <%:item.Quantity.ToString("0") %>
                    </td>
                    <td class="ta-right no-wrap">
                        &pound;<%:item.Total.ToString("N02") %>
                    </td>
                </tr>   
                <% i++; %>
                <% } %>
            </tbody>
            <tfoot>
                <tr>
                    <td rowspan="10" class="no-border authorizebox">
                        <p>
                            <%:Html.CheckBoxFor(m => m.AuthorizeOrder, new { @class="labeledCheckbox", required="required" }) %>
                            <label for="AuthorizeOrder" class="checkboxLabel" style="width: 350px; text-align: left;">
                                I authorize the order as per the above details.
                            </label>
                            <%:Html.ValidationMessageFor(m => m.AuthorizeOrder) %>
                        </p>
                        <p>
                            <%:Html.CheckBoxFor(m => m.AcceptTerms, new { @class="labeledCheckbox", required="required" }) %>
                            <label for="AcceptTerms" class="checkboxLabel" style="width: 400px; text-align: left;">
                                I accept Balcony Systems Solutions Ltd <a id="terms-link">Terms & conditions</a> of sale.
                            </label>
                            <%:Html.ValidationMessageFor(m => m.AcceptTerms) %>
                        </p>
                    </td>
                    <th class="ta-right no-border" colspan="2">Sub Total:</th>
                    <td class="ta-right no-wrap cartTotal">&pound;<%:Model.Items.Sum(item => item.Total).ToString("N02") %></td>
                </tr>
                <% if (Math.Abs(Model.DiscountPercent) > 0) { %>
                <tr>
                    <td class="ta-right no-border" colspan="2">Discount %<%:Model.DiscountPercent.ToString("N02")%>:</td>
                    <td class="ta-right no-wrap">&pound;<%: Model.DiscountSum.ToString("N02") %></td>
                </tr>
                <tr>
                    <th class="ta-right no-border" colspan="2">Sub Total:</th>
                    <td class="ta-right no-wrap">&pound;<%: Model.SubTotalWithDiscount.ToString("N02") %></td>
                </tr>
                <% } %>
                <% if (Model.IncludesDelivery) { %>
                <tr>
                    <th class="ta-right no-border no-wrap" colspan="2">Delivery to <%:Model.DeliveryTo %>:</th>
                    <td class="ta-right no-wrap">&pound;<%: Model.DeliveryPrice.ToString("N02") %></td>
                </tr>
                <tr>
                    <th class="ta-right no-border" colspan="2">Sub Total:</th>
                    <td class="ta-right no-wrap">&pound;<%: Model.SubTotalWithDelivery.ToString("N02") %></td>
                </tr>
                <% } %>
                <% if (Math.Abs(Model.VatPercent - 0) > 0.01) { %>
                <tr>
                    <th class="ta-right no-border" colspan="2">VAT %<%:Model.VatPercent.ToString("N02")%>:</th>
                    <td class="ta-right no-wrap">&pound;<%: Model.VatSum.ToString("N02") %></td>
                </tr>
                <% } %>
                <tr>
                    <th class="ta-right no-border" colspan="2">Total:</th>
                    <td class="ta-right no-wrap bold">&pound;<%: Model.Total.ToString("N02") %></td>
                </tr>
                <% if (Math.Abs(Model.Total - Model.Deposit) > 0.001) { %>
                <tr>
                    <th class="ta-right no-border" colspan="2">Required Deposit <a class="fancybox fancybox.iframe" data-fancybox-width="550" href="/general/required-deposit">(?)</a>: </th>
                    <td class="ta-right no-wrap bold">&pound;<%: Model.Deposit.ToString("N02") %></td>
                </tr>
                

                <% } %>
            </tfoot>
        </table>
    </div>
    
    <div id="payment_methods">
        <div class="creditcard">
            <h2>Pay with credit card</h2>
            <div class="paypal-link">or <span style="color: blue; border-bottom: 1px solid blue;">pay with </span><div class="paypal-logo"></div> <span style="color: blue;"> >></span></div>
            <div class="card_details">
                <p class="crd_number">
                    <label>Card number:</label>
                    <%:Html.TextBoxFor(m => m.CreditCardNumber, new { @class="k-textbox ccnumber", style = "width: 200px;", autocomplete = "off" })%>
                    <%:Html.ValidationMessageFor(m => m.CreditCardNumber) %>
                </p>
                <p>
                    <label class="card-type-label">Card type:</label>
                    <%:Html.TextBoxFor(m => m.CreditCardType, new { style = "width: 200px;" })%>
                    <%:Html.ValidationMessageFor(m => m.CreditCardType) %>
                </p>
                <p>
                    <label class="exp-date-label">Expiration Date:</label>
                    <span class="exp-date-month exp-date-field"><%:Html.TextBoxFor(m => m.ExpMonth, new { style = "width: 50px; text-align: right;" })%></span>
                    <span class="exp-date-field exp-date-divider" style="margin-bottom: -5px;">/</span>
                    <span class="exp-date-year exp-date-field"><%:Html.TextBoxFor(m => m.ExpYear, new { style = "width: 70px; text-align: right;" })%></span>
                    <span class="exp-date-field cvv-field">
                        <label style="width: 50px;">CVV:</label>
                        <span><%:Html.TextBoxFor(m => m.Cvv, new { @class="k-textbox", style = "width: 70px; text-align: right;", autocomplete = "off" })%></span>
                    </span>
                    <%:Html.ValidationMessageFor(m => m.Cvv) %>
                </p>
                <p style="clear: both;"></p>
                <div id="cc_start" class="display-none">
                    <p>
                        <label>Start Date:</label>
                        <%:Html.TextBoxFor(m => m.StartMonth, new { style = "width: 50px; text-align: right;" })%>
                        <span>/</span>
                        <%:Html.TextBoxFor(m => m.StartYear, new { style = "width: 70px; text-align: right;" })%>
                    </p>
                    <p>
                        <label>Issue number:</label>
                        <%:Html.TextBoxFor(m => m.IssueNumber, new { @class="k-textbox", style = "width: 130px;" })%>
                        <%:Html.ValidationMessageFor(m => m.IssueNumber) %>
                    </p>
                </div>

            </div>    
            <p>
                <%:Html.RadioButtonFor(m => m.BillingOption, OrderPaymentModel.BillingOptionType.SameAddress, new { id="BillingSameAddress", @class="billing_option labeledCheckbox" }) %>
                <label for="BillingSameAddress" class="checkboxLabel" style="width: 350px; text-align: left;">
                    Credit/debit card address is the same as billing address.
                </label>
            </p>
            <p>
                <%:Html.RadioButtonFor(m => m.BillingOption, OrderPaymentModel.BillingOptionType.DifferentAddress, new { id="BillingDifferentAddress",@class="billing_option labeledCheckbox" }) %>
                <label for="BillingDifferentAddress" class="checkboxLabel" style="width: 350px; text-align: left;">
                    Credit/debit card address is different.
                </label>
            </p>
            <div id="billing_address" class="<%=Model.BillingOption == OrderPaymentModel.BillingOptionType.SameAddress ? "display-none" : "" %>">
                <p>
                    <label>House:</label>
                    <%:Html.TextBoxFor(m => m.CreditHouse, new { @class = "k-textbox" + (Model.BillingOption != OrderPaymentModel.BillingOptionType.DifferentAddress ? " ignore" : ""), style = "width: 250px;" })%>
                    <%:Html.ValidationMessageFor(m => m.CreditHouse) %>
                </p>
                <p>
                    <label>Street:</label>
                    <%:Html.TextBoxFor(m => m.CreditStreet, new { @class = "k-textbox" + (Model.BillingOption != OrderPaymentModel.BillingOptionType.DifferentAddress ? " ignore" : ""), style = "width: 250px;" })%>
                    <%:Html.ValidationMessageFor(m => m.CreditStreet) %>
                </p>
                <p>
                    <label>Town:</label>
                    <%:Html.TextBoxFor(m => m.CreditTown, new { @class = "k-textbox" + (Model.BillingOption != OrderPaymentModel.BillingOptionType.DifferentAddress ? " ignore" : ""), style = "width: 250px;" })%>
                    <%:Html.ValidationMessageFor(m => m.CreditStreet) %>
                </p>
                <p>
                    <label>Country:</label>
                    <%:Html.TextBoxFor(m => m.CreditCountryId, new { @class= (Model.BillingOption != OrderPaymentModel.BillingOptionType.DifferentAddress ? " ignore" : "")  })%>
                    <%:Html.ValidationMessageFor(m => m.CreditCountryId) %>
                </p>
                <p>
                    <label>Postcode:</label>
                    <%:Html.TextBoxFor(m => m.CreditPostCode, new { @class = "k-textbox" + (Model.BillingOption != OrderPaymentModel.BillingOptionType.DifferentAddress ? " ignore" : ""), style = "width: 150px;" })%>
                    <%:Html.ValidationMessageFor(m => m.CreditPostCode) %>
                </p>
            </div>
            <div class="ta-center" style="margin-top: 25px;">
                <input id="btnCredit" type="submit" value="Place your payment" name="credit" class="k-button area_color submit prog1"  />
                <div class="paypal-link" style="margin-top: 25px;">or <span style="color: blue; border-bottom: 1px solid blue;">pay with </span><div class="paypal-logo"></div> <span style="color: blue;"> >></span></div>
            </div>
        </div>
        <div class="paypal">
            <!--<h2>Pay with PayPal</h2>-->
            <div class="ta-right" style="display: none;">
                <input id="btnPayPal" type="submit" value="Continue to PayPal" name="paypal" class="k-button area_color submit prog1"  />
            </div>
        </div>
    </div>
    <% } %>
    <br class="clear"/><br/><br/><br/><br/><br/>
</div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
    
<script type="text/javascript">

    $(document).ready(function () {

        <% if (!String.IsNullOrEmpty(Model.Iframe)) { %>
        $.fancybox({
            modal: true,
            width: 600,
            height: 400,
            minHeight: 300,
            closeBtn: false,
            href: '<%=Model.Iframe%>',
            type: 'iframe'
        });
        <% } %>


        $("#btnSaveCart").click(function () {
            $("#f_save").val("true");
            $("#cart_form").submit();
        });
        $("#btnContinue").click(function () {
            $("#f_save").val("false");
            $("#cart_form").submit();
        });
        $("#cart_form").submit(function () {
            $(this).find(".cartTable tbody tr").each(function (i) {
                $(this).find(".quantity").attr("name", "[" + i + "].Quantity");
            });
        });
        
     
        $(".billing_option").change(function () {
            var div = $("#billing_address");
            if ($("#BillingDifferentAddress").is(":checked")) {
                div.slideDown();
                div.removeClass("display-none");
                div.find("input").removeClass("ignore");
            } else {
                div.slideUp();
                div.find("input").addClass("ignore");
            }
        });
        
        $("#CreditCountryId").kendoDropDownList({
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
        
        $("#CreditCardType").kendoDropDownList({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: [<%=OrderPaymentModel.CardTypes.Select(t => String.Format(@"{{ text: ""{0}"", value: ""{1}"" }}", t.Name, t.Value)).Aggregate("", (s1, s2)=> s1 +  (String.IsNullOrWhiteSpace(s1) ? "" : ", ") + s2)%>],
            index: 0
        });

        $("#ExpMonth").kendoDropDownList({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: [<%=OrderPaymentModel.Months.Select(t => String.Format(@"{{ text: ""{0}"", value: ""{1}"" }}", t.ToString("00"), t)).Aggregate("", (s1, s2)=> s1 +  (String.IsNullOrWhiteSpace(s1) ? "" : ", ") + s2)%>],
            index: 0
        });
        
        $("#ExpYear").kendoDropDownList({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: [<%=OrderPaymentModel.ExpYears.Select(t => String.Format(@"{{ text: ""{0}"", value: ""{1}"" }}", t, t)).Aggregate("", (s1, s2)=> s1 +  (String.IsNullOrWhiteSpace(s1) ? "" : ", ") + s2)%>],
            index: 0
        });
        
        $("#StartMonth").kendoDropDownList({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: [<%=OrderPaymentModel.Months.Select(t => String.Format(@"{{ text: ""{0}"", value: ""{1}"" }}", t.ToString("00"), t)).Aggregate("", (s1, s2)=> s1 +  (String.IsNullOrWhiteSpace(s1) ? "" : ", ") + s2)%>],
            index: 0
        });

        $("#StartYear").kendoDropDownList({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: [<%=OrderPaymentModel.StartYears.Select(t => String.Format(@"{{ text: ""{0}"", value: ""{1}"" }}", t, t)).Aggregate("", (s1, s2)=> s1 +  (String.IsNullOrWhiteSpace(s1) ? "" : ", ") + s2)%>],
            index: 0
        });


        $("#CreditCardType").change(function() {
            var ctx = $(this).val();
            var div = $("#cc_start");
            if (ctx >= 4) {
                div.slideDown();
                div.removeClass("display-none");
                div.find("input").removeClass("ignore");
            } else {
                div.slideUp();
                div.find("input").addClass("ignore");
            }
        });


        $("#btnCredit").click(function () {
            $("#CreditCardNumber").removeClass("ignore");
            $("#Cvv").removeClass("ignore");

            return true;
        });

        $("#btnPayPal").click(function() {
            $("#CreditCardNumber").addClass("ignore");
            $("#Cvv").addClass("ignore");

            return true;
        });

        $('.paypal-link').click(function(){
            $("#btnPayPal").click();
        });

        $("#terms-link").fancybox({
            fitToView: false,
            autoSize: true,
            width: '90%',
            height: 380,
            href: '/terms.html',
            type: 'iframe'
        });

    });

   

    
</script>
</asp:Content>
