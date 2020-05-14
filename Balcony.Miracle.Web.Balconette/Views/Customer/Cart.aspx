<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<IList<CartItem>>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<style type="text/css">
    label {
        width: 100px;
        display: inline-block;
        text-align: right;
        margin-right: 10px;
    }
    h1 { margin-bottom: 20px;}
   
    table.cartTable {
        border-collapse: collapse;
        width: 100%;
    }

    table.cartTable th.item {
        width: 80%;  
    }

    table.cartTable td,th {
        padding: 5px;
        border: 1px solid #c5c5c5;
        vertical-align: middle;
    }

    table.cartTable th {
        white-space: nowrap;
        font-weight: bold;
    }

    #big_cart {
        width: 750px;
        float: left;
    }

    #cart_actions {
        float: left;
        width: 190px;
        text-align: center;
        margin-left: 20px;
        padding: 10px;
        background-color: #f4f4f4;
        border-radius: 4px;
        -moz-border-radius: 4px;
        -webkit-border-radius: 4px;        
    }

    #btnContinueWrap {
        margin-bottom: 20px;
    }

    #btnDelivery {
        font-weight: normal !important;
    }

    #btnContinue {
        font-weight: normal !important;
        font-size: 18px;
        width: 180px;
    }

    #btnSaveCart {
        font-weight: normal !important;
        font-size: 14px;
        width: 147px;
        margin-bottom: 20px;
    }
    
    #btn-shopping {
        font-size: 14px;
        font-weight: normal;
        width: 148px;
        padding-left: 0 !important;
        padding-right: 0 !important;
    }

    .cartRemove {
        display: block;
        margin: 10px auto 0 auto;
        width: 30px;
        height: 30px;
    }

    #cart-footer-info p,
    #cart-footer-info h3 {
        color: #666 !important;
        margin-top: 10px;
        font-size: 16px !important;
        font-weight: normal !important;
    }

    @media only screen and (max-width: 659px) {
        #cart-footer-info p,
        #cart-footer-info h3 {
            font-size: 12px !important;
        }

        #cart_actions {
            float: none !important;
            margin: 25px auto 10px auto !important;
            width: 100% !important;
            padding: 10px !important;
            display: inline-block !important;
            text-align: center !important;
        }

        #cart_actions form {
            text-align: center;
        }

        .cart_actions_btn_wrap {
            display: block;
            margin: 5px auto;
        }

        .cart_actions_btn_wrap abbr {
            margin-left: -38px;
        }

        .cart_actions_btn_wrap img.qmarkinfo {
            margin: 0 10px 5px 10px !important;
        }
    }
</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="main shoppingcart">
	<ul id="cookie-menu">
		<li><a href="/">Home</a></li>
		<li class="last"><%=ViewBag.H1 %></li>
	</ul>
    <h1><%=ViewBag.H1 %></h1>
    
    <div id="big_cart">
        <table class="cartTable">
            <thead>
                <tr>
                    <th>#</th>
                    <th class="item">Item</th>
                    <th>Unit Price</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th class="no-border"></th>
                </tr>
            </thead>
            <tbody>
                <% var i = 0; %>
                <% foreach (var item in Model) { %>
                <tr data-id="<%=item.ID %>">
                    <td><%=(i+1) %></td>
                    <td>
                        <% if (item.Quote != null) { %>
                        <a target="_blank" href="<%=Url.Action("Quote", "Customer", new { id = item.Quote.ID }) %>"><%=item.Name.ToHtml() %></a>
                        <% } else { %>
                        <%=item.Name.ToHtml() %>
                        <% } %>
                    </td>
                    <td class="ta-right no-wrap">
                        &pound;<%:item.Price.ToString("N02") %>
                        <input type="hidden" class="unitPrice" value="<%:item.Price %>"/>
                    </td>
                    <td class="ta-center no-wrap">
                        <input type="text" value="<%:item.Quantity.ToString("0") %>" class="quantity ta-center only-numbers" style="width: 60px;" />
                    </td>
                    <td class="ta-right bold no-wrap subTotal">
                        &pound;<%:item.Total.ToString("N02") %>
                        <a class="k-button cartRemove" title="Remove this item" style="padding: 5px !important;"><span class="k-icon k-i-close"></span></a>
                    </td>
                </tr>   
                <% i++; %>
                <% } %>
            </tbody>
            <tfoot>
                <tr>
                    <td class="ta-right" colspan="4">Sub total excluding VAT:</td>
                    <td class="ta-right no-wrap bold cartTotal">&pound;<%:Model.Sum(item => item.Total).ToString("N02") %></td>
                    <td class="no-border"></td>
                </tr>
            </tfoot>
        </table>
        <div id="cart-footer-info">
            <p>Delivery cost will be added during the checkout process and after filling in your invoice and billing details. It is also possible to pick up the goods from our factory at no extra cost.</p>
            <%=ViewBag.Body %>
        </div>
    </div>

    <div id="cart_actions">
        <div id="btnContinueWrap">
            <a id="btnContinue" class="k-button area_color submit prog1" title="Continue to place your order">Proceed to Checkout</a>
        </div>
        <div class="cart_actions_btn_wrap">
            <abbr title="Click here to save your changes." rel="tooltip">
                <img class="qmarkinfo" src="/images/qmark1311.png" alt="Save your cart status.">
            </abbr>
            <a id="btnSaveCart" class="k-button area_color submit" title="Save your cart status" href="#">Save Cart Changes</a>
        </div>
        <div class="cart_actions_btn_wrap">
            <abbr title="Calculate the delivery cost here. This will show the total delivery cost for all the items in your shopping cart to the chosen location. Delivery cost will be added during the checkout process and after filling in your invoice and billing details. It is also possible to pick up the goods from our factory at no extra cost." rel="tooltip">
                <img class="qmarkinfo" src="/images/qmark1311.png" alt="Check delivery Cost.">
            </abbr>
            <a id="btnDelivery" href="#" class="k-button area_color submit">Delivery Cost</a>
        </div>
        <div class="cart_actions_btn_wrap">
            <abbr title="You can leave this page and come back to your shopping cart at any time, by clicking 'View Cart', located at the top right corner of any page on this website" rel="tooltip">
                <img class="qmarkinfo comtinueabbr" src="/images/qmark1311.png" alt="Continue shopping.">
            </abbr>
            <a id="btn-shopping" href="<%=Url.Action("shopping", "general") %>" class="k-button area_color" href="#">Continue Shopping</a>
        </div>
    </div>
    

<br class="clear"/><br/>
</div>

<script src="/Scripts/tooltip.js"></script>

<script type="text/javascript">

    function saveCart(success) {
        var data = {};

        $(".cartTable tbody tr").each(function(i) {
            data["[" + i + "].ID"] = $(this).attr("data-id");
            data["[" + i + "].Quantity"] = $(this).find("input.quantity").val();
        });

        $("#cart_actions .submit").hide();
        var prog = $("<div/>")
                    .addClass("prog prog1")
                    .prop("title", "Please wait ...")
                    .insertAfter($("#cart_actions .prog1"));

        $.post('<%=Url.Action(null) %>', data, function() {
            var result = true;
            if (success)
                result = success();

            if (result) {
                $("#cart_actions .submit").show();
                prog.remove();
            }
        });
    }

    $(document).ready(function () {

        $("#btnSaveCart").click(function () {
            saveCart();
        });

        $("#btnContinue").click(function () {
            saveCart(function() {
                location.assign("<%=Url.Action("order-details") %>");
                return false;
            });
        });

        $("#btnDelivery").click(function() {
            saveCart(function() {
                $.fancybox({
                    fitToView: false,
                    autoSize: false,
                    width: 380,
                    height: 360,
                    href: '<%=Url.Action("delivery-calculator", new { areas=ViewBag.Area }) %>',
                    type: 'iframe'
                });
                return true;
            });
            return false;
        });

        function onchange() {
            $(".cartTable").each(function () {
                var total = 0;
                $(this).find("tbody tr").each(function() {
                    var unitPrice = $(this).find(".unitPrice").val();
                    var quanitity = $(this).find("input.quantity").val();
                    var subTotal = unitPrice * quanitity;
                    $(this).find(".subTotal").html("&pound;" + kendo.toString(subTotal, "n2"));
                    total += subTotal;
                });
                $(this).find(".cartTotal").html("&pound;" + kendo.toString(total, "n2"));
            });
        }

        $(".quantity").kendoNumericTextBox({
            format: "n0",
            min: 1,
            max: parseInt("<%=AppSettings.MAX_QUANTITY%>"),
            step: 1,
            change: onchange,
            spin: onchange
        });

        $(".cartRemove").click(function () {
            $(this).hide();
            var tr = $(this).parents("tr");
            tr.fadeOut("slow", function() {
                tr.remove();
                onchange();
            });
        });

    });
</script>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">

</asp:Content>
