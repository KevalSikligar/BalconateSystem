using System;
using System.Drawing;
using System.Web;
using Balcony.Miracle.Core;
using Balcony.Miracle.Core.Drawing.Drawing2D;
using PdfSharp;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using SvgNet.SvgGdi;
using Margins = System.Drawing.Printing.Margins;

namespace Balcony.Miracle.Web.Shared {
    
    public static class Extensions {

        public static void PermanentRedirect(this HttpResponse response, string relativeUrl) {
            if (HttpContext.Current == null) return;
            response.AddHeader("Location", relativeUrl.ToAbsoluteUrl());
            response.StatusCode = 301;
            response.Status = "301 Moved Permanently";
            response.End();
        }

        public static void RedirectToSecure(this HttpResponse response) {
            if (HttpContext.Current == null || HttpContext.Current.Request.IsSecureConnection) return;
            PermanentRedirect(response, HttpContext.Current.Request.Url.AbsoluteUri.Insert(4, "s"));
        }   

        private static string ToAbsoluteUrl(this string relativeUrl) {
            if (HttpContext.Current == null || string.IsNullOrEmpty(relativeUrl))
                return relativeUrl;

            return new Uri(HttpContext.Current.Request.Url, relativeUrl).AbsoluteUri;
        }

        public static PdfDocument CreatePdf(this Balustrade balustrade)
        {
            var margins = new Margins(50, 50, 50, 50);

            var doc = new PdfDocument();

            var page = doc.AddPage();

            var size = new SizeF((float)page.Width.Value - margins.Left - margins.Right, (float)page.Height.Value - margins.Top - margins.Bottom);

            Bound block;
            using (var bitmap = new Bitmap((int)size.Width, (int)size.Height))
            using (var g = Graphics.FromImage(bitmap))
            {
                block = balustrade.Paint(new GdiGraphics(g));
            }

            if (block.Width > block.Height)
            {
                page.Orientation = PageOrientation.Landscape;
                size = new SizeF(size.Height, size.Width);
            }

            var regionRatio = block.Height / block.Width;
            var panelRatio = size.Height / size.Width;
            float zoom;
            if (regionRatio >= panelRatio) zoom = (size.Height / block.Height);
            else zoom = (size.Width / block.Width);

            using (var gfx = XGraphics.FromPdfPage(page))
            {
                var graphics = new PdfGraphics(gfx);
                gfx.TranslateTransform(margins.Left, margins.Top);

                gfx.ScaleTransform(zoom, zoom);
                gfx.TranslateTransform(size.Width / zoom / 2 - block.Center.X, size.Height / zoom / 2 + block.Center.Y);

                balustrade.Paint(graphics);
            }

            return doc;
        }

    }
}
