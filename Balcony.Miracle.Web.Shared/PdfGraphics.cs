using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Drawing.Text;
using System.Linq;
using PdfSharp.Drawing;
using SvgNet.SvgGdi;

namespace Balcony.Miracle.Web.Shared
{
    public class PdfGraphics : IGraphics
    {
        private Graphics nativeGraphics;
        private Bitmap bitmap;
        private readonly XGraphics graphicsImplementation;

        public PdfGraphics(XGraphics graphics)
        {
            graphicsImplementation = graphics;
            bitmap = new Bitmap(10, 10);
            nativeGraphics = Graphics.FromImage(bitmap);
        }

        public XGraphics XGraphics
        {
            get { return graphicsImplementation;  }
        }

        public void Dispose()
        {
            graphicsImplementation.Dispose();
            nativeGraphics.Dispose();
            bitmap.Dispose();
        }

        public void Flush()
        {

        }

        public void Flush(FlushIntention intention)
        {

        }

        public void ResetTransform()
        {

        }

        public void MultiplyTransform(Matrix matrix)
        {
            graphicsImplementation.MultiplyTransform(matrix.ToXMatrix());
        }

        public void MultiplyTransform(Matrix matrix, MatrixOrder order)
        {
            graphicsImplementation.MultiplyTransform(matrix.ToXMatrix(), order.ToXMatrixOrder());
        }

        public void TranslateTransform(float dx, float dy)
        {
            graphicsImplementation.TranslateTransform(dx, dy);
        }

        public void TranslateTransform(float dx, float dy, MatrixOrder order)
        {
            graphicsImplementation.TranslateTransform(dx, dy, order.ToXMatrixOrder());
        }

        public void ScaleTransform(float sx, float sy)
        {
            graphicsImplementation.ScaleTransform(sx, sy);
        }

        public void ScaleTransform(float sx, float sy, MatrixOrder order)
        {
            graphicsImplementation.ScaleTransform(sx, sy, order.ToXMatrixOrder());
        }

        public void RotateTransform(float angle)
        {
            graphicsImplementation.RotateTransform(angle);
        }

        public void RotateTransform(float angle, MatrixOrder order)
        {
            graphicsImplementation.RotateTransform(angle, order.ToXMatrixOrder());
        }

        public void TransformPoints(CoordinateSpace destSpace, CoordinateSpace srcSpace, PointF[] pts)
        {

        }

        public void TransformPoints(CoordinateSpace destSpace, CoordinateSpace srcSpace, Point[] pts)
        {

        }

        public Color GetNearestColor(Color color)
        {
            return nativeGraphics.GetNearestColor(color);
        }

        public void DrawLine(Pen pen, float x1, float y1, float x2, float y2)
        {
            graphicsImplementation.DrawLine(pen.ToXPen(), x1, y1, x2, y2);
        }

        public void DrawLine(Pen pen, PointF pt1, PointF pt2)
        {
            graphicsImplementation.DrawLine(pen.ToXPen(), pt1.ToXPoint(), pt2.ToXPoint());
        }

        public void DrawLines(Pen pen, PointF[] points)
        {
            graphicsImplementation.DrawLines(pen.ToXPen(), points?.Select(p => p.ToXPoint()).ToArray());
        }

        public void DrawLine(Pen pen, int x1, int y1, int x2, int y2)
        {
            graphicsImplementation.DrawLine(pen.ToXPen(), x1, y1, x2, y2);
        }

        public void DrawLine(Pen pen, Point pt1, Point pt2)
        {
            graphicsImplementation.DrawLine(pen.ToXPen(), pt1.ToXPoint(), pt2.ToXPoint());
        }

        public void DrawLines(Pen pen, Point[] points)
        {
            graphicsImplementation.DrawLines(pen.ToXPen(), points?.Select(p => p.ToXPoint()).ToArray());
        }

        public void DrawArc(Pen pen, float x, float y, float width, float height, float startAngle, float sweepAngle)
        {
            graphicsImplementation.DrawArc(pen.ToXPen(), x, y, width, height, startAngle, sweepAngle);
        }

        public void DrawArc(Pen pen, RectangleF rect, float startAngle, float sweepAngle)
        {
            graphicsImplementation.DrawArc(pen.ToXPen(), rect.ToXRect(), startAngle, sweepAngle);
        }

        public void DrawArc(Pen pen, int x, int y, int width, int height, int startAngle, int sweepAngle)
        {
            graphicsImplementation.DrawArc(pen.ToXPen(), x, y, width, height, startAngle, sweepAngle);
        }

        public void DrawArc(Pen pen, Rectangle rect, float startAngle, float sweepAngle)
        {
            graphicsImplementation.DrawArc(pen.ToXPen(), rect.ToXRect(), startAngle, sweepAngle);
        }

        public void DrawBezier(Pen pen, float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4)
        {
            graphicsImplementation.DrawBezier(pen.ToXPen(), x1, y1, x2, y2, x3, y3, x4, y4);
        }

        public void DrawBezier(Pen pen, PointF pt1, PointF pt2, PointF pt3, PointF pt4)
        {
            graphicsImplementation.DrawBezier(pen.ToXPen(), pt1.ToXPoint(), pt2.ToXPoint(), pt3.ToXPoint(), pt4.ToXPoint());
        }

        public void DrawBeziers(Pen pen, PointF[] points)
        {
            graphicsImplementation.DrawBeziers(pen.ToXPen(), points?.Select(p => p.ToXPoint()).ToArray());
        }

        public void DrawBezier(Pen pen, Point pt1, Point pt2, Point pt3, Point pt4)
        {
            graphicsImplementation.DrawBezier(pen.ToXPen(), pt1.ToXPoint(), pt2.ToXPoint(), pt3.ToXPoint(), pt4.ToXPoint());
        }

        public void DrawBeziers(Pen pen, Point[] points)
        {
            graphicsImplementation.DrawBeziers(pen.ToXPen(), points?.Select(p => p.ToXPoint()).ToArray());
        }

        public void DrawRectangle(Pen pen, Rectangle rect)
        {
            graphicsImplementation.DrawRectangle(pen.ToXPen(), rect.ToXRect());
        }

        public void DrawRectangle(Pen pen, float x, float y, float width, float height)
        {
            graphicsImplementation.DrawRectangle(pen.ToXPen(), x, y, width, height);
        }

        public void DrawRectangles(Pen pen, RectangleF[] rects)
        {
            graphicsImplementation.DrawRectangles(pen.ToXPen(), rects?.Select(r => r.ToXRect()).ToArray());
        }

        public void DrawRectangle(Pen pen, int x, int y, int width, int height)
        {
            graphicsImplementation.DrawRectangle(pen.ToXPen(), x, y, width, height);
        }

        public void DrawRectangles(Pen pen, Rectangle[] rects)
        {
            graphicsImplementation.DrawRectangles(pen.ToXPen(), rects?.Select(r => r.ToXRect()).ToArray());
        }

        public void DrawEllipse(Pen pen, RectangleF rect)
        {
            graphicsImplementation.DrawEllipse(pen.ToXPen(), rect.ToXRect());
        }

        public void DrawEllipse(Pen pen, float x, float y, float width, float height)
        {
            graphicsImplementation.DrawEllipse(pen.ToXPen(), x, y, width, height);
        }

        public void DrawEllipse(Pen pen, Rectangle rect)
        {
            graphicsImplementation.DrawEllipse(pen.ToXPen(), rect.ToXRect());
        }

        public void DrawEllipse(Pen pen, int x, int y, int width, int height)
        {
            graphicsImplementation.DrawEllipse(pen.ToXPen(), x, y, width, height);
        }

        public void DrawPie(Pen pen, RectangleF rect, float startAngle, float sweepAngle)
        {
            graphicsImplementation.DrawPie(pen.ToXPen(), rect.ToXRect(), startAngle, sweepAngle);
        }

        public void DrawPie(Pen pen, float x, float y, float width, float height, float startAngle, float sweepAngle)
        {
            graphicsImplementation.DrawPie(pen.ToXPen(), x, y, width, height, startAngle, sweepAngle);
        }

        public void DrawPie(Pen pen, Rectangle rect, float startAngle, float sweepAngle)
        {
            graphicsImplementation.DrawPie(pen.ToXPen(), rect.ToXRect(), startAngle, sweepAngle);
        }

        public void DrawPie(Pen pen, int x, int y, int width, int height, int startAngle, int sweepAngle)
        {
            graphicsImplementation.DrawPie(pen.ToXPen(), x, y, width, height, startAngle, sweepAngle);
        }

        public void DrawPolygon(Pen pen, PointF[] points)
        {
            graphicsImplementation.DrawPolygon(pen.ToXPen(), points?.Select(p => p.ToXPoint()).ToArray());
        }

        public void DrawPolygon(Pen pen, Point[] points)
        {
            graphicsImplementation.DrawPolygon(pen.ToXPen(), points?.Select(p => p.ToXPoint()).ToArray());
        }

        public void DrawPath(Pen pen, GraphicsPath path)
        {

        }

        public void DrawCurve(Pen pen, PointF[] points)
        {
            graphicsImplementation.DrawCurve(pen.ToXPen(), points?.Select(p => p.ToXPoint()).ToArray());
        }

        public void DrawCurve(Pen pen, PointF[] points, float tension)
        {
            graphicsImplementation.DrawCurve(pen.ToXPen(), points?.Select(p => p.ToXPoint()).ToArray(), tension);
        }

        public void DrawCurve(Pen pen, PointF[] points, int offset, int numberOfSegments)
        {
            graphicsImplementation.DrawCurve(pen.ToXPen(), points?.Select(p => p.ToXPoint()).ToArray(), offset, numberOfSegments, 0.5);
        }

        public void DrawCurve(Pen pen, PointF[] points, int offset, int numberOfSegments, float tension)
        {
            graphicsImplementation.DrawCurve(pen.ToXPen(), points?.Select(p => p.ToXPoint()).ToArray(), offset, numberOfSegments, tension);
        }

        public void DrawCurve(Pen pen, Point[] points)
        {
            graphicsImplementation.DrawCurve(pen.ToXPen(), points?.Select(p => p.ToXPoint()).ToArray());
        }

        public void DrawCurve(Pen pen, Point[] points, float tension)
        {
            graphicsImplementation.DrawCurve(pen.ToXPen(), points?.Select(p => p.ToXPoint()).ToArray(), tension);
        }

        public void DrawCurve(Pen pen, Point[] points, int offset, int numberOfSegments, float tension)
        {
            graphicsImplementation.DrawCurve(pen.ToXPen(), points?.Select(p => p.ToXPoint()).ToArray(), offset, numberOfSegments, tension);
        }

        public void DrawClosedCurve(Pen pen, PointF[] points)
        {
            graphicsImplementation.DrawClosedCurve(pen.ToXPen(), points?.Select(p => p.ToXPoint()).ToArray());
        }

        public void DrawClosedCurve(Pen pen, PointF[] points, float tension, FillMode fillmode)
        {
            graphicsImplementation.DrawClosedCurve(pen.Brush.ToXBrush(), points?.Select(p => p.ToXPoint()).ToArray(), fillmode.ToXFillMode(), tension);
        }

        public void DrawClosedCurve(Pen pen, Point[] points)
        {
            graphicsImplementation.DrawClosedCurve(pen.ToXPen(), points?.Select(p => p.ToXPoint()).ToArray());
        }

        public void DrawClosedCurve(Pen pen, Point[] points, float tension, FillMode fillmode)
        {
            graphicsImplementation.DrawClosedCurve(pen.Brush.ToXBrush(), points?.Select(p => p.ToXPoint()).ToArray(), fillmode.ToXFillMode(), tension);
        }

        public void Clear(Color color)
        {

        }

        public void FillRectangle(Brush brush, RectangleF rect)
        {
            graphicsImplementation.DrawRectangle(brush.ToXBrush(), rect.ToXRect());
        }

        public void FillRectangle(Brush brush, float x, float y, float width, float height)
        {
            graphicsImplementation.DrawRectangle(brush.ToXBrush(), x, y, width, height);
        }

        public void FillRectangles(Brush brush, RectangleF[] rects)
        {
            graphicsImplementation.DrawRectangles(brush.ToXBrush(), rects?.Select(r => r.ToXRect()).ToArray());
        }

        public void FillRectangle(Brush brush, Rectangle rect)
        {
            graphicsImplementation.DrawRectangle(brush.ToXBrush(), rect.ToXRect());
        }

        public void FillRectangle(Brush brush, int x, int y, int width, int height)
        {
            graphicsImplementation.DrawRectangle(brush.ToXBrush(), x, y, width, height);
        }

        public void FillRectangles(Brush brush, Rectangle[] rects)
        {
            graphicsImplementation.DrawRectangles(brush.ToXBrush(), rects?.Select(r => r.ToXRect()).ToArray());
        }

        public void FillPolygon(Brush brush, PointF[] points)
        {
            graphicsImplementation.DrawPolygon(brush.ToXBrush(), points?.Select(p => p.ToXPoint()).ToArray(), XFillMode.Alternate);
        }

        public void FillPolygon(Brush brush, PointF[] points, FillMode fillMode)
        {
            graphicsImplementation.DrawPolygon(brush.ToXBrush(), points?.Select(p => p.ToXPoint()).ToArray(), fillMode.ToXFillMode());
        }

        public void FillPolygon(Brush brush, Point[] points)
        {
            graphicsImplementation.DrawPolygon(brush.ToXBrush(), points?.Select(p => p.ToXPoint()).ToArray(), XFillMode.Alternate);
        }

        public void FillPolygon(Brush brush, Point[] points, FillMode fillMode)
        {
            graphicsImplementation.DrawPolygon(brush.ToXBrush(), points?.Select(p => p.ToXPoint()).ToArray(), fillMode.ToXFillMode());
        }

        public void FillEllipse(Brush brush, RectangleF rect)
        {
            graphicsImplementation.DrawEllipse(brush.ToXBrush(), rect.ToXRect());
        }

        public void FillEllipse(Brush brush, float x, float y, float width, float height)
        {
            graphicsImplementation.DrawEllipse(brush.ToXBrush(), x, y, width, height);
        }

        public void FillEllipse(Brush brush, Rectangle rect)
        {
            graphicsImplementation.DrawEllipse(brush.ToXBrush(), rect.ToXRect());
        }

        public void FillEllipse(Brush brush, int x, int y, int width, int height)
        {
            graphicsImplementation.DrawEllipse(brush.ToXBrush(), x, y, width, height);
        }

        public void FillPie(Brush brush, Rectangle rect, float startAngle, float sweepAngle)
        {

        }

        public void FillPie(Brush brush, float x, float y, float width, float height, float startAngle, float sweepAngle)
        {

        }

        public void FillPie(Brush brush, int x, int y, int width, int height, int startAngle, int sweepAngle)
        {

        }

        public void FillPath(Brush brush, GraphicsPath path)
        {

        }

        public void FillClosedCurve(Brush brush, PointF[] points)
        {
            graphicsImplementation.DrawClosedCurve(brush.ToXBrush(), points?.Select(p => p.ToXPoint()).ToArray());
        }

        public void FillClosedCurve(Brush brush, PointF[] points, FillMode fillmode)
        {
            graphicsImplementation.DrawClosedCurve(brush.ToXBrush(), points?.Select(p => p.ToXPoint()).ToArray(), fillmode.ToXFillMode());
        }

        public void FillClosedCurve(Brush brush, PointF[] points, FillMode fillmode, float tension)
        {
            graphicsImplementation.DrawClosedCurve(brush.ToXBrush(), points?.Select(p => p.ToXPoint()).ToArray(), fillmode.ToXFillMode(), tension);
        }

        public void FillClosedCurve(Brush brush, Point[] points)
        {
            graphicsImplementation.DrawClosedCurve(brush.ToXBrush(), points?.Select(p => p.ToXPoint()).ToArray());
        }

        public void FillClosedCurve(Brush brush, Point[] points, FillMode fillmode)
        {
            graphicsImplementation.DrawClosedCurve(brush.ToXBrush(), points?.Select(p => p.ToXPoint()).ToArray(), fillmode.ToXFillMode());
        }

        public void FillClosedCurve(Brush brush, Point[] points, FillMode fillmode, float tension)
        {
            graphicsImplementation.DrawClosedCurve(brush.ToXBrush(), points?.Select(p => p.ToXPoint()).ToArray(), fillmode.ToXFillMode(), tension);
        }

        public void FillRegion(Brush brush, Region region)
        {

        }

        public void DrawString(string s, Font font, Brush brush, float x, float y)
        {
            graphicsImplementation.DrawString(s.Trim(), font.ToXFont(), brush.ToXBrush(), x, y);
        }

        public void DrawString(string s, Font font, Brush brush, PointF point)
        {
            graphicsImplementation.DrawString(s.Trim(), font.ToXFont(), brush.ToXBrush(), point.ToXPoint());
        }

        public void DrawString(string s, Font font, Brush brush, float x, float y, StringFormat format)
        {
            graphicsImplementation.DrawString(s.Trim(), font.ToXFont(), brush.ToXBrush(), x, y, format.ToXStringFormat());
        }

        public void DrawString(string s, Font font, Brush brush, PointF point, StringFormat format)
        {
            graphicsImplementation.DrawString(s.Trim(), font.ToXFont(), brush.ToXBrush(), point.ToXPoint(), format.ToXStringFormat());
        }

        public void DrawString(string s, Font font, Brush brush, RectangleF layoutRectangle)
        {
            graphicsImplementation.DrawString(s.Trim(), font.ToXFont(), brush.ToXBrush(), layoutRectangle.ToXRect());
        }

        public void DrawString(string s, Font font, Brush brush, RectangleF layoutRectangle, StringFormat format)
        {
            graphicsImplementation.DrawString(s.Trim(), font.ToXFont(), brush.ToXBrush(), layoutRectangle.ToXRect(), format.ToXStringFormat());
        }

        public SizeF MeasureString(string text, Font font, SizeF layoutArea, StringFormat stringFormat, out int charactersFitted, out int linesFilled)
        {
            return nativeGraphics.MeasureString(text, font, layoutArea, stringFormat, out charactersFitted, out linesFilled);
        }

        public SizeF MeasureString(string text, Font font, PointF origin, StringFormat stringFormat)
        {
            return nativeGraphics.MeasureString(text, font, origin, stringFormat);
        }

        public SizeF MeasureString(string text, Font font, SizeF layoutArea)
        {
            return nativeGraphics.MeasureString(text, font, layoutArea);
        }

        public SizeF MeasureString(string text, Font font, SizeF layoutArea, StringFormat stringFormat)
        {
            return nativeGraphics.MeasureString(text, font, layoutArea, stringFormat);
        }

        public SizeF MeasureString(string text, Font font)
        {
            return nativeGraphics.MeasureString(text, font);
        }

        public SizeF MeasureString(string text, Font font, int width)
        {
            return nativeGraphics.MeasureString(text, font, width);
        }

        public SizeF MeasureString(string text, Font font, int width, StringFormat format)
        {
            return nativeGraphics.MeasureString(text, font, width, format);
        }

        public Region[] MeasureCharacterRanges(string text, Font font, RectangleF layoutRect, StringFormat stringFormat)
        {
            return nativeGraphics.MeasureCharacterRanges(text, font, layoutRect, stringFormat);
        }

        public void DrawIcon(Icon icon, int x, int y)
        {

        }

        public void DrawIcon(Icon icon, Rectangle targetRect)
        {

        }

        public void DrawIconUnstretched(Icon icon, Rectangle targetRect)
        {

        }

        public void DrawImage(Image image, PointF point)
        {
            graphicsImplementation.DrawImage(image.ToXImage(), point.ToXPoint());
        }

        public void DrawImage(Image image, float x, float y)
        {
            graphicsImplementation.DrawImage(image.ToXImage(), x, y);
        }

        public void DrawImage(Image image, RectangleF rect)
        {
            graphicsImplementation.DrawImage(image.ToXImage(), rect.ToXRect());
        }

        public void DrawImage(Image image, float x, float y, float width, float height)
        {
            graphicsImplementation.DrawImage(image.ToXImage(), x, y, width, height);
        }

        public void DrawImage(Image image, Point point)
        {
            graphicsImplementation.DrawImage(image.ToXImage(), point.ToXPoint());
        }

        public void DrawImage(Image image, int x, int y)
        {
            graphicsImplementation.DrawImage(image.ToXImage(), x, y);
        }

        public void DrawImage(Image image, Rectangle rect)
        {
            graphicsImplementation.DrawImage(image.ToXImage(), rect.ToXRect());
        }

        public void DrawImage(Image image, int x, int y, int width, int height)
        {
            graphicsImplementation.DrawImage(image.ToXImage(), x, y, width, height);
        }

        public void DrawImageUnscaled(Image image, Point point)
        {
            graphicsImplementation.DrawImage(image.ToXImage(), point.ToXPoint());
        }

        public void DrawImageUnscaled(Image image, int x, int y)
        {
            graphicsImplementation.DrawImage(image.ToXImage(), x, y);
        }

        public void DrawImageUnscaled(Image image, Rectangle rect)
        {
            graphicsImplementation.DrawImage(image.ToXImage(), rect.ToXRect());
        }

        public void DrawImageUnscaled(Image image, int x, int y, int width, int height)
        {
            graphicsImplementation.DrawImage(image.ToXImage(), x, y, width, height);
        }

        public void DrawImage(Image image, PointF[] destPoints)
        {

        }

        public void DrawImage(Image image, Point[] destPoints)
        {

        }

        public void DrawImage(Image image, float x, float y, RectangleF srcRect, GraphicsUnit srcUnit)
        {

        }

        public void DrawImage(Image image, int x, int y, Rectangle srcRect, GraphicsUnit srcUnit)
        {

        }

        public void DrawImage(Image image, RectangleF destRect, RectangleF srcRect, GraphicsUnit srcUnit)
        {

        }

        public void DrawImage(Image image, Rectangle destRect, Rectangle srcRect, GraphicsUnit srcUnit)
        {

        }

        public void DrawImage(Image image, PointF[] destPoints, RectangleF srcRect, GraphicsUnit srcUnit)
        {

        }

        public void DrawImage(Image image, PointF[] destPoints, RectangleF srcRect, GraphicsUnit srcUnit, ImageAttributes imageAttr)
        {

        }

        public void DrawImage(Image image, PointF[] destPoints, RectangleF srcRect, GraphicsUnit srcUnit, ImageAttributes imageAttr, Graphics.DrawImageAbort callback)
        {

        }

        public void DrawImage(Image image, Point[] destPoints, Rectangle srcRect, GraphicsUnit srcUnit)
        {

        }

        public void DrawImage(Image image, Point[] destPoints, Rectangle srcRect, GraphicsUnit srcUnit, ImageAttributes imageAttr)
        {

        }

        public void DrawImage(Image image, Rectangle destRect, float srcX, float srcY, float srcWidth, float srcHeight, GraphicsUnit srcUnit)
        {

        }

        public void DrawImage(Image image, Rectangle destRect, float srcX, float srcY, float srcWidth, float srcHeight, GraphicsUnit srcUnit, ImageAttributes imageAttrs)
        {

        }

        public void DrawImage(Image image, Rectangle destRect, int srcX, int srcY, int srcWidth, int srcHeight, GraphicsUnit srcUnit)
        {

        }

        public void DrawImage(Image image, Rectangle destRect, int srcX, int srcY, int srcWidth, int srcHeight, GraphicsUnit srcUnit, ImageAttributes imageAttr)
        {

        }

        public void SetClip(Graphics g)
        {

        }

        public void SetClip(Graphics g, CombineMode combineMode)
        {

        }

        public void SetClip(Rectangle rect)
        {

        }

        public void SetClip(Rectangle rect, CombineMode combineMode)
        {

        }

        public void SetClip(RectangleF rect)
        {

        }

        public void SetClip(RectangleF rect, CombineMode combineMode)
        {

        }

        public void SetClip(GraphicsPath path)
        {

        }

        public void SetClip(GraphicsPath path, CombineMode combineMode)
        {

        }

        public void SetClip(Region region, CombineMode combineMode)
        {

        }

        public void IntersectClip(Rectangle rect)
        {
            graphicsImplementation.IntersectClip(rect.ToXRect());
        }

        public void IntersectClip(RectangleF rect)
        {
            graphicsImplementation.IntersectClip(rect.ToXRect());
        }

        public void IntersectClip(Region region)
        {

        }

        public void ExcludeClip(Rectangle rect)
        {

        }

        public void ExcludeClip(Region region)
        {

        }

        public void ResetClip()
        {

        }

        public void TranslateClip(float dx, float dy)
        {

        }

        public void TranslateClip(int dx, int dy)
        {

        }

        public bool IsVisible(int x, int y)
        {
            return nativeGraphics.IsVisible(x, y);
        }

        public bool IsVisible(Point point)
        {
            return nativeGraphics.IsVisible(point);
        }

        public bool IsVisible(float x, float y)
        {
            return nativeGraphics.IsVisible(x, y);
        }

        public bool IsVisible(PointF point)
        {
            return nativeGraphics.IsVisible(point);
        }

        public bool IsVisible(int x, int y, int width, int height)
        {
            return nativeGraphics.IsVisible(x, y, width, height);
        }

        public bool IsVisible(Rectangle rect)
        {
            return nativeGraphics.IsVisible(rect);
        }

        public bool IsVisible(float x, float y, float width, float height)
        {
            return nativeGraphics.IsVisible(x, y, width, height);
        }

        public bool IsVisible(RectangleF rect)
        {
            return nativeGraphics.IsVisible(rect);
        }

        public GraphicsState Save()
        {
            return nativeGraphics.Save();
        }

        public void Restore(GraphicsState gstate)
        {
            nativeGraphics.Restore(gstate);
        }

        public GraphicsContainer BeginContainer(RectangleF dstrect, RectangleF srcrect, GraphicsUnit unit)
        {
            return nativeGraphics.BeginContainer(dstrect, srcrect, unit);
        }

        public GraphicsContainer BeginContainer()
        {
            return nativeGraphics.BeginContainer();
        }

        public void EndContainer(GraphicsContainer container)
        {
            nativeGraphics.EndContainer(container);
        }

        public GraphicsContainer BeginContainer(Rectangle dstrect, Rectangle srcrect, GraphicsUnit unit)
        {
            return nativeGraphics.BeginContainer(dstrect, srcrect, unit);
        }

        public void AddMetafileComment(byte[] data)
        {
            nativeGraphics.AddMetafileComment(data);
        }

        public CompositingMode CompositingMode
        {
            get => nativeGraphics.CompositingMode;
            set => nativeGraphics.CompositingMode = value;
        }

        public Point RenderingOrigin
        {
            get => nativeGraphics.RenderingOrigin;
            set => nativeGraphics.RenderingOrigin = value;
        }

        public CompositingQuality CompositingQuality
        {
            get => nativeGraphics.CompositingQuality;
            set => nativeGraphics.CompositingQuality = value;
        }

        public TextRenderingHint TextRenderingHint
        {
            get => nativeGraphics.TextRenderingHint;
            set => nativeGraphics.TextRenderingHint = value;
        }

        public int TextContrast
        {
            get => nativeGraphics.TextContrast;
            set => nativeGraphics.TextContrast = value;
        }

        public SmoothingMode SmoothingMode
        {
            get => nativeGraphics.SmoothingMode;
            set => nativeGraphics.SmoothingMode = value;
        }

        public PixelOffsetMode PixelOffsetMode
        {
            get => nativeGraphics.PixelOffsetMode;
            set => nativeGraphics.PixelOffsetMode = value;
        }

        public InterpolationMode InterpolationMode
        {
            get => nativeGraphics.InterpolationMode;
            set => nativeGraphics.InterpolationMode = value;
        }

        public Matrix Transform
        {
            get => nativeGraphics.Transform;
            set => nativeGraphics.Transform = value;
        }

        public GraphicsUnit PageUnit
        {
            get => nativeGraphics.PageUnit;
            set => nativeGraphics.PageUnit = value;
        }

        public float PageScale
        {
            get => nativeGraphics.PageScale;
            set => nativeGraphics.PageScale = value;
        }

        public float DpiX => nativeGraphics.DpiX;

        public float DpiY => nativeGraphics.DpiY;

        public Region Clip
        {
            get => nativeGraphics.Clip;
            set => nativeGraphics.Clip = value;
        }

        public RectangleF ClipBounds => nativeGraphics.ClipBounds;

        public bool IsClipEmpty => nativeGraphics.IsClipEmpty;

        public RectangleF VisibleClipBounds => nativeGraphics.VisibleClipBounds;

        public bool IsVisibleClipEmpty => nativeGraphics.IsVisibleClipEmpty;
    }
}
