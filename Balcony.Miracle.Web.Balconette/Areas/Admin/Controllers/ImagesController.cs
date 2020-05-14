using System;
using System.Linq;
using System.Collections.Generic;
using System.Drawing;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Cms;
using NHibernate;

namespace Balcony.Miracle.Web.Areas.Admin.Controllers {
    
    public class ImagesController : AdminBaseController {

        public ActionResult Index() {
            ViewBag.TagCategories = DbSession.GetAll<TagCategory>(true).OrderBy(tc => tc.Inx);
            return View();
        }

        public ActionResult Add() {
            return View();
        }

        [HttpPost]
        public ActionResult Upload(int? tsize, bool? tisWidth) {
            var file = Request.Files[0];
            if (file == null) {
                throw new Exception("No File");
            }

            using (var image = Image.FromStream(file.InputStream)) {
                GalleryImage galleryImage;
                if (tsize.HasValue && tisWidth.HasValue) {
                    galleryImage = new GalleryImage(image, file.FileName, tsize.Value, tisWidth.Value);
                } else {
                    galleryImage = new GalleryImage(image, file.FileName);
                }

                DbSession.SaveOrUpdate(galleryImage);
                return Json(galleryImage);
            }
        }

        public static void SaveImages(IList<GalleryImage> images, ISession session) {
            if (images == null) return;
            foreach (var dto in images) {
                var image = session.Get<GalleryImage>(dto.ID);
                if (image == null)
                    continue;
                
                if (dto.ShouldDelete) {
                    image.DeleteFiles();
                    session.Delete(image);
                    continue;
                }

                // tags
                image.Tags.Clear();
                foreach (var dtoTag in dto.Tags) {
                    image.Tags.Add(session.Get<Tag>(dtoTag.ID));
                }

                image.Name = dto.Name;
                image.Description = dto.Description;
                image.Inx = dto.Inx;
                image.Rotate(dto.RotateAngle);

                session.SaveOrUpdate(image);
            }
        }

        [HttpPost]
        [TransactionScope]
        public ActionResult BulkEdit(IList<GalleryImage> images) {
            SaveImages(images, DbSession);
            return Json(new { });
        }

        [HttpPost]
        public ActionResult GetImage(Guid id) {
            return Json(DbSession.Get<GalleryImage>(id));
        }
    }
}