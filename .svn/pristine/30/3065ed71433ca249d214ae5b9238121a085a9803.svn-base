using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Cms;
using NHibernate;

namespace Balcony.Miracle.Web.Areas.Admin.Controllers {
    public class DownloadsController : AdminBaseController {


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
        public ActionResult Upload()
        {
            var file = Request.Files[0];
            if (file == null)
            {
                throw new Exception("No File");
            }

            


            var galleryImage = new UploadedFile(file);

            DbSession.SaveOrUpdate(galleryImage);
            return Json(galleryImage);

        }

        [HttpPost]
        [TransactionScope]
        public ActionResult BulkEdit(IList<UploadedFile> files)
        {
            SaveFiles(files, DbSession);
            return Json(new { });
        }

        public static void SaveFiles(IList<UploadedFile> files, ISession session)
        {
            if (files == null) return;
            foreach (var dto in files)
            {
                var file = session.Get<UploadedFile>(dto.ID);
                if (file == null) 
                    continue;

                if (dto.ShouldDelete) {
                    file.Delete();
                    session.Delete(file);
                    continue;
                }

                // tags
                file.Tags.Clear();
                foreach (var dtoTag in dto.Tags) {
                    file.Tags.Add(session.Get<Tag>(dtoTag.ID));
                }

                file.Name = dto.Name;
                file.Description = dto.Description;
                file.Inx = dto.Inx;

                session.SaveOrUpdate(file);
            }
        }



    }
}
