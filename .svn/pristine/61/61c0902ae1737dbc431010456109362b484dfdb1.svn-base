<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="ViewPage<CallMeBackModel>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
    <style>
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
    <div>
        <div id="call-me-back-container">
        <h1>Talk to a specialist</h1>
        <p>Please leave your name and number and a Balconette Specialist will call you back.</p>
        <!--<h2>Office Work Hours 9:30 - 17:30 (UK)</h2>-->
        <% using (Ajax.BeginForm(null, null, new AjaxOptions { HttpMethod = "POST", UpdateTargetId = "call-me-back-container" }, new { id = "frm" }))
           {%>
            <div class="form">
                <p>
                    <label>Name:</label>
                    <%:Html.TextBoxFor(m => m.Name, new { @class = "k-textbox" })%>
                </p>
                <p>
                    <label>Phone:</label>
                    <%:Html.TextBoxFor(m => m.Phone, new { @class = "k-textbox" })%>
                </p>
                <p>
                    <label>Day:</label>
                    <%:Html.TextBoxFor(m => m.Day, new { @class = "k-textbox day" })%>
                </p>
                <p>
                    <label>Time:</label>
                    <%:Html.TextBoxFor(m => m.Time, new { @class = "k-textbox time" })%>
                </p>
                <p>
                    <input class="k-button bold" type="submit" value="Send" />
                </p>
            </div>
        <% } %>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FooterEnd" runat="server">
<script type="text/javascript">
    $(document).ready(function () {
        $("#call-me-back-container .day").kendoDropDownList({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: [
                { text: "Select", value: "" },
                { text: "Today", value: "Today" },
                { text: "Tomorrow", value: "Tomorrow" },
                { text: "Any day", value: "Any day" }
            ],
            index: 0
        });
        $("#call-me-back-container .time").kendoDropDownList({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: [
                { text: "Select", value: "" },
                { text: "Any Time", value: "Any Time" },
                { text: "9:30 - 10:30",  value: "9:30 - 10:30" },
                { text: "10:30 - 11:30", value: "10:30 - 11:30" },
                { text: "11:30 - 12:30", value: "11:30 - 12:30" },
                { text: "12:30 - 13:30", value: "12:30 - 13:30" },
                { text: "13:30 - 14:30", value: "13:30 - 14:30" },
                { text: "14:30 - 15:30", value: "14:30 - 15:30" },
                { text: "15:30 - 16:30", value: "15:30 - 16:30" },
                { text: "16:30 - 17:30", value: "16:30 - 17:30" }
            ],
            index: 0
        });
        $('.slicknav_menu').hide();
        $('.clicktocalltopbtn').hide();
    });
</script>
</asp:Content>
