using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using PdfSharp.Drawing;

namespace Balcony.Miracle.Web.Shared
{
    public static class DrawingExtensions
    {

        public static XMatrix ToXMatrix(this Matrix matrix)
        {
            var elements = matrix.Elements;
            return new XMatrix(elements[0], elements[1], elements[2], elements[3], elements[4], elements[5]);
        }

        public static XMatrixOrder ToXMatrixOrder(this MatrixOrder matrixOrder)
        {
            switch (matrixOrder)
            {
                case MatrixOrder.Prepend:
                    return XMatrixOrder.Prepend;

                case MatrixOrder.Append:
                    return XMatrixOrder.Append;

                default:
                    throw new ArgumentOutOfRangeException(nameof(matrixOrder), matrixOrder, null);
            }
        }

        public static XPen ToXPen(this Pen pen)
        {
            return new XPen(pen.Color.ToXColor(), pen.Width);
        }

        public static XColor ToXColor(this Color color)
        {
            return XColor.FromArgb(color.A, color.R, color.G, color.B);
        }

        public static XPoint ToXPoint(this Point point)
        {
            return new XPoint(point.X, point.Y);
        }

        public static XPoint ToXPoint(this PointF point)
        {
            return new XPoint(point.X, point.Y);
        }

        public static XSize ToXSize(this Size size)
        {
            return new XSize(size.Width, size.Height);
        }

        public static XSize ToXSize(this SizeF size)
        {
            return new XSize(size.Width, size.Height);
        }

        public static XRect ToXRect(this Rectangle rect)
        {
            return new XRect(rect.Location.ToXPoint(), rect.Size.ToXSize());
        }

        public static XRect ToXRect(this RectangleF rect)
        {
            return new XRect(rect.Location.ToXPoint(), rect.Size.ToXSize());
        }

        public static XBrush ToXBrush(this Brush brush)
        {
            var solidBrush = brush as SolidBrush;
            if (solidBrush != null)
                return new XSolidBrush(solidBrush.Color.ToXColor());
        
            throw new NotSupportedException("Only solid brush is supported");
        }

        public static XFont ToXFont(this Font font)
        {
            return new XFont(font.FontFamily, font.Size, font.Style.ToXFontStyle());
        }

        public static XFontStyle ToXFontStyle(this FontStyle fontStyle)
        {
            switch (fontStyle)
            {
                case FontStyle.Regular:
                    return XFontStyle.Regular;

                case FontStyle.Bold:
                    return XFontStyle.Bold;

                case FontStyle.Italic:
                    return XFontStyle.Italic;

                case FontStyle.Underline:
                    return XFontStyle.Underline;

                case FontStyle.Strikeout:
                    return XFontStyle.Strikeout;

                default:
                    throw new ArgumentOutOfRangeException(nameof(fontStyle), fontStyle, null);
            }
        }

        public static SizeF ToSizeF(this XSize size)
        {
            return new SizeF((float)size.Width, (float)size.Height);
        }

        public static XGraphicsUnit ToXGraphicsUnit(this GraphicsUnit graphicsUnit)
        {
            switch (graphicsUnit)
            {
                case GraphicsUnit.Inch:
                    return XGraphicsUnit.Inch;

                case GraphicsUnit.Millimeter:
                    return XGraphicsUnit.Millimeter;

                default:
                    return XGraphicsUnit.Point;
            }
        }

        public static XImage ToXImage(this Image image)
        {
            var stream = new MemoryStream();
            image.Save(stream, ImageFormat.Bmp);
            return XImage.FromStream(stream);
        }

        public static XStringFormat ToXStringFormat(this StringFormat stringFormat)
        {
            XLineAlignment lineAlignment;
            switch (stringFormat.LineAlignment)
            {
                case StringAlignment.Near:
                    lineAlignment = XLineAlignment.Near;
                    break;

                case StringAlignment.Center:
                    lineAlignment = XLineAlignment.Center;
                    break;

                case StringAlignment.Far:
                    lineAlignment = XLineAlignment.Far;
                    break;

                default:
                    throw new ArgumentOutOfRangeException();
            }

            return new XStringFormat
            {
                Alignment = stringFormat.Alignment.ToXStringAlignment(),
                LineAlignment = lineAlignment
            };
        }

        public static XStringAlignment ToXStringAlignment(this StringAlignment stringAlignment)
        {
            switch (stringAlignment)
            {
                case StringAlignment.Near:
                    return XStringAlignment.Near;

                case StringAlignment.Center:
                    return XStringAlignment.Center;

                case StringAlignment.Far:
                    return XStringAlignment.Far;

                default:
                    throw new ArgumentOutOfRangeException(nameof(stringAlignment), stringAlignment, null);
            }
        }

        public static XFillMode ToXFillMode(this FillMode fillMode)
        {
            switch (fillMode)
            {
                case FillMode.Alternate:
                    return XFillMode.Alternate;

                case FillMode.Winding:
                    return XFillMode.Winding;

                default:
                    throw new ArgumentOutOfRangeException(nameof(fillMode), fillMode, null);
            }
        }
    }
}