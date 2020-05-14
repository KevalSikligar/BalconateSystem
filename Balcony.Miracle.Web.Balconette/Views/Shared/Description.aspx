<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Main.Master" Inherits="ViewPage<DescriptionModel>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
	<%=Model.Body %>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">

</asp:Content>
