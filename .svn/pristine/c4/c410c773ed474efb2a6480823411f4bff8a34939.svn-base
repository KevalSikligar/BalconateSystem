using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Web;
using Balcony.Miracle.Core;

namespace Balcony.Miracle.Web.Cms {

    public class GalleryImage : BaseEntity<Guid> {

        private const int THUMB_HEIGHT = 200;

        private const int ZOOM_MAX_WIDTH = 1500;

        private const int ZOOM_MAX_HEIGHT = 1100;

        private static readonly ImageCodecInfo jpegCodecInfo;

        private static readonly EncoderParameters fullQuality = new EncoderParameters(1);

        public const int DEFAULT_QUALITY = 80;

        static GalleryImage() {
            foreach (var codec in ImageCodecInfo.GetImageDecoders())
            {
                if (codec.FormatID == ImageFormat.Jpeg.Guid) {
                    jpegCodecInfo = codec;
                }
            }
            fullQuality.Param[0] = new EncoderParameter(Encoder.Quality, 100L);
        }

        public GalleryImage() {
            // ReSharper disable DoNotCallOverridableMethodsInConstructor
            Tags = new List<Tag>();
            ThumbSize = THUMB_HEIGHT;
            ThumbSizeIsWidth = false;
            // ReSharper restore DoNotCallOverridableMethodsInConstructor
        }

        public GalleryImage(Image original, string fileName) : 
            this() {
            // ReSharper disable DoNotCallOverridableMethodsInConstructor
            InitFromImage(original, fileName);
            Name = Path.GetFileNameWithoutExtension(fileName);
            Description = Name;
            // ReSharper restore DoNotCallOverridableMethodsInConstructor
        }

        public GalleryImage(Image original, string fileName, int thumbSize, bool isWidth) :
            this() {
            // ReSharper disable DoNotCallOverridableMethodsInConstructor
            ThumbSize = thumbSize;
            ThumbSizeIsWidth = isWidth;

            InitFromImage(original, fileName);
            Name = Path.GetFileNameWithoutExtension(fileName).Trim();
            Description = Name;
            // ReSharper restore DoNotCallOverridableMethodsInConstructor
        }

        protected void InitFromImage(Image original, string fileName) {
            var name = Path.GetFileNameWithoutExtension(fileName).ToLower().Trim().Replace(" ", "-").Replace("_", "-");
            var path = "/content/upimages/" + Guid.NewGuid() + "/";
            
            var dir = HttpContext.Current.Server.MapPath(path);
            if (!Directory.Exists(dir))
                Directory.CreateDirectory(dir);

            OrgUrl = path + name + ".jpg";
            ThumbUrl = path + name + "_t.jpg";
            ZoomUrl = path + name + "_z.jpg";

            //save original
            original.Save(HttpContext.Current.Server.MapPath(OrgUrl), jpegCodecInfo, fullQuality);

            //thumbnail
            using (var thumb = CreateThumnail(original)) {
                SaveWithPhi(thumb, HttpContext.Current.Server.MapPath(ThumbUrl), 75);
            }
            
            //zoomed
            using (var zoomed = CreateZoomed(original)) {
                SaveWithPhi(zoomed, HttpContext.Current.Server.MapPath(ZoomUrl), DEFAULT_QUALITY);
            }
        }

        public static void SaveWithPhi(Image image, string path, int quality)
        {
            try {
                File.Delete(path);
            }
            catch { }
            using (var fileStream = new FileStream(path, FileMode.Create, FileAccess.Write))
            {
                var prms = new EncoderParameters(1);
                prms.Param[0] = new EncoderParameter(Encoder.Quality, quality);
                image.Save(fileStream, jpegCodecInfo, prms);
            }
        }

        public virtual Image CreateThumnail(Image original) {
            int thumbWidth, thumbHeight;
            if (ThumbSizeIsWidth) {
                thumbWidth = ThumbSize;
                thumbHeight = (int)Math.Round((thumbWidth / (double)original.Size.Width) * original.Size.Height);
            } else {
                thumbHeight = ThumbSize;
                thumbWidth = (int)Math.Round((thumbHeight / (double)original.Size.Height) * original.Size.Width);
            }

            return ResizeImage(original, thumbWidth, thumbHeight);
        }

        public static Image CreateZoomed(Image original) {
            int zoomWidth = original.Size.Width, zoomHeight = original.Size.Height;
            if (ZOOM_MAX_WIDTH < original.Size.Width) {
                zoomHeight = (int)Math.Round((ZOOM_MAX_WIDTH / (double)original.Size.Width) * original.Size.Height);
                zoomWidth = ZOOM_MAX_WIDTH;
            }
            if (ZOOM_MAX_HEIGHT < zoomHeight) {
                zoomWidth = (int)Math.Round((ZOOM_MAX_HEIGHT / (double)zoomHeight) * zoomWidth);
                zoomHeight = ZOOM_MAX_HEIGHT;
            }

            return ResizeImage(original, zoomWidth, zoomHeight);
        }

        private static Image ResizeImage(Image original, int width, int height) {
            var thumb = new Bitmap(width, height);
            // Set the resolutions the same to avoid cropping due to resolution differences
            thumb.SetResolution(original.HorizontalResolution, original.VerticalResolution);

            using (var graphics = Graphics.FromImage(thumb))
            {
                // Set the resize quality modes to high quality
                graphics.CompositingQuality = CompositingQuality.HighQuality;
                graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
                graphics.SmoothingMode = SmoothingMode.HighQuality;

                graphics.DrawImage(original, 0, 0, width, height);
                return thumb;
            }
        }

        public virtual void DeleteFiles() {
            string file;
            var dirs = new HashSet<string>();
            try {
                file = HttpContext.Current.Server.MapPath(OrgUrl);
                dirs.Add(Path.GetDirectoryName(file) ?? "");
                if (File.Exists(file))
                    File.Delete(file);    
            } catch {}
            try {
                file = HttpContext.Current.Server.MapPath(ThumbUrl);
                dirs.Add(Path.GetDirectoryName(file) ?? "");
                if (File.Exists(file))
                    File.Delete(file);
            } catch { }
            try {
                file = HttpContext.Current.Server.MapPath(ZoomUrl);
                dirs.Add(Path.GetDirectoryName(file) ?? "");
                if (File.Exists(file))
                    File.Delete(file);
            } catch { }
            foreach (var dir in dirs) {
                try {
                    if (!String.IsNullOrEmpty(dir)) {
                        var info = new DirectoryInfo(dir);
                        if (info.GetFileSystemInfos().Length == 0) {
                            info.Delete(true);
                        }
                    }
                }
                catch { }
            }
        }

        public virtual void Rotate(int angle) {
            angle = angle % 360;
            if (angle == 0) return;
            var filename = HttpContext.Current.Server.MapPath(OrgUrl);
            using (var original = Image.FromFile(filename)) {
                var type = RotateFlipType.RotateNoneFlipNone;
                switch(angle) {
                    case 90: 
                        type = RotateFlipType.Rotate90FlipNone;
                        break;
                    case 180:
                        type = RotateFlipType.Rotate180FlipNone;
                        break;
                    case 270:
                        type = RotateFlipType.Rotate270FlipNone;
                        break;
                }
                original.RotateFlip(type);
                DeleteFiles();
                InitFromImage(original, filename);
            }
        }

        public virtual string Name { get; set; }

        public virtual string Description { get; set; }

        public virtual IList<Tag> Tags { get; protected set; }

        public virtual string OrgUrl { get; set; }
        
        public virtual string ThumbUrl { get; set; }
        
        public virtual string ZoomUrl { get; set; }

        public virtual int RotateAngle { get; set; }

        public virtual bool ShouldDelete { get; set; }

        public virtual int ThumbSize { get; set; }

        public virtual bool ThumbSizeIsWidth { get; set; }

        public virtual int Inx { get; set; }
    }
}