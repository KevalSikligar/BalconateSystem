﻿<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<Balcony.Miracle.Web.Models.LoginModel>" %>



<asp:Content ID="loginContent" ContentPlaceHolderID="MainContent" runat="server">
    <%: Html.Partial("LoginPartial", Model) %>
</asp:Content>

<asp:Content ID="scriptsContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
</asp:Content>