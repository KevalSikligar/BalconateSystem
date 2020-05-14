<%@ Page Language="C#" MasterPageFile="~/Areas/Admin/Views/Shared/Admin.Master" Inherits="ViewPage<IList<CmsRedirect>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadStart" runat="server">
    <title>Redirects Index</title>
    <style type="text/css">
        .validation-error {
            background-color: #f08080;
        }
    </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="BodyContent" runat="server">
    <h1>Redirects Index</h1>
    <div>
        <button id="add-row-button">Add row</button>
        <button id="save-button">Save</button>
    </div>
    <hr/>
    <table class="indextable">
        <thead>
            <tr>
                <th>Url</th>
                <th>Redirect Url</th>
                <th>Permanent</th>
                <th>Delete</th>
            </tr>
        </thead>
        <tbody class="template" style="display: none;">
            <tr>
                <td>
                    <input type="text" name="Url" style="width: 100%;"/>
                </td>
                <td>
                    <input type="text" name="RedirectUrl" style="width: 100%;"/>
                </td>
                <td>
                    <input name="IsPermanent" type="checkbox" checked/>
                </td>
                <td>
                    <button class="delete-button">X</button>
                </td>
            </tr>
        </tbody>
        <tbody class="real">
            <% foreach (var redirect in Model) { %>
            <tr data-id="<%=redirect.ID %>">
                <td>
                    <input type="text" value="<%=redirect.Url %>" name="Url" style="width: 100%;"/>
                </td>
                <td>
                    <input type="text" value="<%=redirect.RedirectUrl %>" name="RedirectUrl" style="width: 100%;"/>
                </td>
                <td>
                    <input name="IsPermanent" type="checkbox" <%=(redirect.IsPermanent ? "checked" : "") %>/>
                </td>
                <td>
                    <button class="delete-button">X</button>
                </td>
            </tr>
            <% } %>
        </tbody>
        <tfoot></tfoot>
    </table>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="FooterEnd" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {

            var realTableBody = $('table.indextable tbody.real');
                     
            function initRow(row) {
                row.find('input').change(function() {
                    var rowId = row.attr("data-id");
                    if (rowId) {
                        row.addClass("changed");
                    }
                });

                row.find(".delete-button").click(function () {
                    row.hide().addClass("removed");;
                });
            }

            realTableBody.find('tr').each(function () {
                initRow($(this));
            });

            $("#add-row-button").click(function () {
                var row = $("table.indextable tbody.template tr:first").clone();
                initRow(row);
                $("table.indextable tbody.real").append(row);
            });

            $("#save-button").click(function() {

                var dataOk = true;

                var removed = [];
                var changed = [];
                var added = [];

                realTableBody.find('input[type="text"]').removeClass("validation-error");

                realTableBody.find('tr').each(function () {
                    var row = $(this);
                    var obj = {};
                    var rowId = row.attr("data-id");

                    row.find('input[type="text"]').each(function () {
                        var input = $(this);
                        if (!row.hasClass("removed") && input.val().trim().length == 0) {
                            input.addClass("validation-error");
                            dataOk = false;
                        }
                        obj[input.attr("name")] = input.val();
                    });

                    row.find('input[type="checkbox"]').each(function() {
                        obj[$(this).attr("name")] = $(this).is(":checked");
                    });

                    if (rowId) {
                        if (row.hasClass("removed")) {
                            removed.push($.extend({'ID': rowId}, obj));
                        } else if (row.hasClass("changed")) {
                            changed.push($.extend({ 'ID': rowId }, obj));
                        }
                    } else {
                        if (!row.hasClass("removed")) {
                            added.push(obj);
                        }
                    }
                });

                if (!dataOk) {
                    alert("Please enter all fields");
                    return false;
                }

                console.log(changed);
                console.log(added);
                console.log(removed);


                $.ajax({
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ Changed: changed, Added: added, Removed: removed }),
                    type: 'POST',
                    url: '<%=Url.Action(null)%>',
                    success: function (data, textStatus, xhr) {
                        alert("ok");
                    }
                });

                return false;
            });
        });
    </script>
</asp:Content>