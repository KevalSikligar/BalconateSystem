using System;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Cms;

namespace Balcony.Miracle.Web.Areas.Admin.Controllers {
    public class FilesController : AdminBaseController {


        public ActionResult Index()
        {
            ViewBag.TagCategories = DbSession.GetAll<TagCategory>(true).OrderBy(tc => tc.Inx);
            return View();
        }

        public ActionResult Add()
        {
            return View();
        }






        [HttpPost]
        public ActionResult Upload(HttpPostedFileBase upload, string CKEditorFuncNum) {
            var name = Path.GetFileNameWithoutExtension(upload.FileName).ToLower().Trim().Replace(" ", "-");
            var ext = Path.GetExtension(upload.FileName).ToLower();
            var path = "/content/uploads/" + Guid.NewGuid() + "/";
            var dir = Server.MapPath(path);
            if (!Directory.Exists(dir))
                Directory.CreateDirectory(dir);

            string url;
            try {
                url = path + name + ".jpg";
                using (var image = Image.FromStream(upload.InputStream)) {
                    using (var zoomed = GalleryImage.CreateZoomed(image)) {
                        GalleryImage.SaveWithPhi(zoomed, Server.MapPath(path + name + ".jpg"), GalleryImage.DEFAULT_QUALITY);
                    }
                }
            } catch (ArgumentException) {
                url = path + name + ext;
                upload.SaveAs(Server.MapPath(path + name + ext));
            }

            var msg = "Thank you";                        
            
            return Content(String.Format("<html><body><script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction({0}, '{1}', '{2}');</script></body></html>", CKEditorFuncNum, url, msg));
        }

    }
}
