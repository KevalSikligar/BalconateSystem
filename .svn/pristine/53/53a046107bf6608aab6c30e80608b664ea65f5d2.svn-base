<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="ViewPage<IList<Juliette>>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="HeadEnd" runat="server">
<style type="text/css">
   h1 {
       margin-bottom: 15px;
   }
   #models {
       padding-left: 2px;
       text-align: center;
   }
   .model {
       display: inline-block;
       width: 23%;
       margin: 0 5px 10px 5px;
       border: 1px solid #a99f9a;
       border-radius: 5px;
       -webkit-border-radius: 5px;
       -moz-border-radius: 5px;
       text-align: center;
       padding: 10px 0 10px 0;
   }
   .model h2 {
       margin: 0;
       font-size: 16px;
   }
   .model p.subtitle {
       margin: 0;   
   }

   a.btnSelect {
       font-weight: bold;
       color: #7314A5;
       font-size: 14px;
   }
   .model p.oldPrice {
       margin: 0 0 5px 0 ;
       text-align: center;
       color: #606060;
       text-decoration: line-through;
   }
   .model p.newPrice {
       margin: 0 0 5px 0 ;
       text-align: center;
       font-weight: bold;
       font-size: 14px;
   }


   .model img {
       width: 80%;
        border: 8px #ffffff solid;
       margin-bottom: 15px;

        -webkit-box-shadow:  rgba(136, 136, 136, 0.5) 5px 5px 5px  !important;
        -moz-box-shadow:     rgba(136, 136, 136, 0.5) 5px 5px 5px  !important;
        box-shadow:          rgba(136, 136, 136, 0.5) 5px 5px 5px !important;

   }
</style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="BodyContent" runat="server">
<div class="wide-main">
    <ul id="cookie-menu">
		<li><a href="/">Home</a></li>
        <% if (ViewBag.Area != AreaKind.General) { %>
        <li><a href="<%=ViewBag.AreaUrl %>"><%:ViewBag.AreaName %></a></li>
		<% } %>
		<li class="last">Choose size</li>
	</ul>    
    <%=ViewBag.Body %>
    <div id="models">
        <% foreach(var model in Model){ %>
        <% var url = Url.Action("standard-model", new {id = model.JulietteStandard.ID, type = model.JulietteType.ID, color = model.Color.ID, glass = model.GlassSystem.ID}); %>
        <div class="model">
            <h2><a href="<%:url %>"><%:model.Width %>mm wide Juliet Balcony</a></h2>
            <p class="subtitle">(Suitable for an opening width of up to <%=model.OpenWidth %>mm)</p>
            <a title="<%=model.JulietteStandard.H1 %>" href="<%:url %>">
                <img src="/images/juliettes/standards/med/<%=model.JulietteType.ID%>/<%=model.Color.ID%>/<%=model.JulietteStandard.ID%>.jpg" alt="<%:model.Width %>mm wide Juliet Balcony" />
            </a> 
            <p class="oldPrice">
            <% if (model.JulietteStandard.OnlineOldPricePercent != 0) { %>
                &pound;<%= model.OnlineOldPrice.ToString("0.00") %> + VAT
            <% } %>
                &nbsp;
            </p>
            <p class="newPrice area_color">&pound;<%=model.SellingPrice.ToString("0.00") %> + VAT</p>
            <a class="btnSelect k-button" href="<%:url %>">Select</a>
        </div>
        <% } %>
        <div class="model">
            <% var curl = Url.Action("quote-custom"); %>
            <h2><a href="<%:curl %>">Custom Size Juliet</a></h2>
            <p class="subtitle">&nbsp;</p>
            <a href="<%:curl %>">
                <img src="/images/juliettes/standards/med/<%=Model.Last().JulietteType.ID%>/<%=Model.Last().Color.ID%>/<%=Model.Last().JulietteStandard.ID %>.jpg" alt="Custom Size Juliet Balcony" />
            </a> 
            <p class="oldPrice">
                &nbsp;
            </p>
            <p class="newPrice area_color">Up to 4100mm wide</p>
            <a class="btnSelect k-button" href="<%:curl %>">Select</a>
        </div>
		<h2 style="margin-top: 80px;">TYPES OF GLASS JULIET BALCONIES</h2>
	<table class="jul-system-type" style="max-width: 700px;margin: 50px auto;">
        <tbody>
            <tr>
                <td>
                <div class="system-type" style="text-align:center;">
                <h3><a class="fancybox" href="/juliet-balcony/traditional-juliet">The Traditional Juliet</a></h3>

                <p><a class="fancybox" href="/content/uploads/52ac2273-cc59-425e-86e8-ac4c39da54c6.png"><img alt="Glass Juliet Balcony The Traditional Juliet" src="/content/uploads/242d0a57-2b50-44f9-abb2-fc03946fc9d8/traditional-juliet-1115.1.jpg" style="width: 100%; box-shadow: rgba(136, 136, 136, 0.498039) 5px 5px 5px !important;"></a></p>
                </div>
                </td>
                <td>
                <div class="system-type" style="text-align:center;">
                <h3><a class="fancybox" href="/juliet-balcony/aerofoil-juliet">Aerofoil Bal2 Juliet</a></h3>

                <p><a class="fancybox" href="/content/upimages/f6758b64-bd79-46f4-ad2c-69275fbef6c9/aerofoil-juliete-pop-up.jpg"><img alt="Aerofoil Glass Juliet Balcony" src="/content/uploads/0a602ffe-f2a5-4088-bdbb-dd494b3ff630/airofoil-juliet-1115.1.jpg" style="width: 100%; box-shadow: rgba(136, 136, 136, 0.498039) 5px 5px 5px !important;"></a></p>
                </div>
                </td>
                <td>
                <div class="system-type" style="text-align:center;">
                <h3><a class="fancybox" href="/juliet-balcony/mirror-juliet">The Mirror Juliet</a></h3>

                <p><a class="fancybox" href="/content/uploads/687042eb-a8bc-4c09-a17d-bb599ba78c43.png"><img alt="Glass Juliet Balcony The Mirror Juliet" src="/content/uploads/2b63fb8e-4a95-4dc8-96a5-3c33f3056439.jpg" style="-webkit-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; -moz-box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important; box-shadow: rgba(136, 136, 136, 0.5) 5px 5px 5px !important;width: 100%;"></a></p>
                </div>
                </td>
                <td>
                <div class="system-type" style="text-align:center;">
                <h3><a class="fancybox" href="/juliet-balcony/frameless-glass-juliet-balcony">The Frameless Juliet</a></h3>

                <p><a class="fancybox" href="/content/uploads/aa39a81c-5665-4dba-9d24-b5752e180bcf/frameless-juliet-drawing.jpg"><img alt="Glass Juliet Balcony Frameless Juliet" src="/content/uploads/8bdfe204-9dc9-4110-b8c0-3e53de2ba48c/frameless-balustrade-illustration-1115.1.jpg" style="width: 100%; box-shadow: rgba(136, 136, 136, 0.498039) 5px 5px 5px !important;"></a></p>
                </div>
                </td>
            </tr>
        </tbody>
    </table>

    <div style="padding-top:20px;padding-bottom:20px;"><iframe allowfullscreen="" frameborder="0" height="400" src="https://www.youtube.com/embed/jhCYJgOFa5c" width="600"></iframe></div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="FooterEnd" runat="server">
    
</asp:Content>
