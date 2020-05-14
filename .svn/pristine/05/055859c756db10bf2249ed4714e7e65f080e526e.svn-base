<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<SearchModel>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
    <style type="text/css">
        .result {
            margin-bottom: 10px;
        }
        .result a.link {
            font-size: 1.2em;
        }
        .result p.url {
            margin-bottom: 0;
            color: rgb(4, 102, 0);
        }
        b {
            font-weight: bold;
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
	<div class="main">
		<ul id="cookie-menu">
			<li><a href="/">HOME</a></li>
			<li class="last">Search Results</li>
		</ul>
		<h1>Search Results For "<%:Model.Query %>"</h1>
        <div id="results">
            
            <% if(Model.Results != null && Model.Results.Items != null) { %>
            <% foreach (var item in Model.Results.Items) { %>
            <div class="result">
                <a class="link" href="<%=item.Link %>"><%=item.HtmlTitle %></a>
                <p class="url"><%=item.HtmlFormattedUrl %></p> 
                <p><%=item.HtmlSnippet %></p>
            </div>  
            <% } %>
            <% } %>

        </div>
	</div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">    
    

</asp:Content>
