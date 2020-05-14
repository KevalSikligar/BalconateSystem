using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Cms;

namespace Balcony.Miracle.Web.Areas.Admin.Controllers {


    public class CaseStudiesController : AdminBaseController {
        
       [SessionScope]
       public ActionResult Index() {
           return View(DbSession.QueryOver<CaseStudy>().OrderBy(p => p.Inx).Desc.List());
       }

        [SessionScope]
        [Jsonp]
        public ActionResult All(object model) {
            var res = DbSession.GetAll<CaseStudy>().ToList();

            return Json(new { d = new { __count = res.Count, results = res } } , JsonRequestBehavior.AllowGet);
        }

        [SessionScope]
        public ActionResult Edit(Guid? id) {
            CaseStudy caseStudy;
            if (id == null) {
                caseStudy = new CaseStudy();
                caseStudy.Inx = (DbSession.QueryOver<CaseStudy>().RowCount() + 1) * 10;
            }
            else
            {
                caseStudy = DbSession.Get<CaseStudy>(id.Value);
            }
            if (caseStudy == null) {
                return HttpNotFound();
            }
            ViewBag.Areas = DbSession.GetAll<Area>(true);
            ViewBag.CmsBlocks = DbSession.GetAll<CmsBlock>(true);

            return View(caseStudy);
        }

        [HttpPost]
        [TransactionScope]
        [ActionName("Edit")]
        [ValidateInput(false)]
        public ActionResult EditPost(Guid id, IList<GalleryImage> images, Guid? links, AreaKind farea, IList<Tag> tags) {

            CaseStudy caseStudy;

            if (Guid.Empty.Equals(id)) {
                caseStudy = new CaseStudy();
            } else {
                caseStudy = DbSession.Get<CaseStudy>(id);
                caseStudy.Image = null;
                caseStudy.SharedLinks = null;
            }
            if (TryUpdateModel(caseStudy)) {
                caseStudy.Tags.Clear();
                if (tags != null) {
                    foreach (var dtoTag in tags) {
                        caseStudy.Tags.Add(DbSession.Get<Tag>(dtoTag.ID));
                    }
                }
                caseStudy.Area = DbSession.Get<Area>(farea);
                if (images != null) {
                    ImagesController.SaveImages(images, DbSession);
                    caseStudy.Image = images.FirstOrDefault(img => !img.ShouldDelete);
                }
                if (links.HasValue) {
                    caseStudy.SharedLinks = DbSession.Get<CmsBlock>(links.Value);
                }

                DbSession.SaveOrUpdate(caseStudy);
                DbSession.Flush();
                return RedirectToAction("Edit", new { id = caseStudy.ID });
            }

            ViewBag.Areas = DbSession.GetAll<Area>(true);
            ViewBag.CmsBlocks = DbSession.GetAll<CmsBlock>(true);
            return View(caseStudy);
        }

        [HttpPost]
        [TransactionScope]
        [ValidateInput(false)]
        public ActionResult Save(Guid id, string name, string body, string links, string areaLinks, string title, string desc, string keywords) {
            var caseStudy = DbSession.Get<CaseStudy>(id);
            if (caseStudy == null) return HttpNotFound();
            caseStudy.Name = name;
            caseStudy.Body = body;
            caseStudy.Title = title;
            caseStudy.Description = desc;
            caseStudy.Keywords = keywords;
            
            if (!String.IsNullOrEmpty(links) && caseStudy.SharedLinks != null) {
                caseStudy.SharedLinks.Html = links;
                DbSession.SaveOrUpdate(caseStudy.SharedLinks);
            }
            if (!String.IsNullOrEmpty(areaLinks) && caseStudy.Area.Links != null) {
                caseStudy.Area.Links.Html = links;
                DbSession.SaveOrUpdate(caseStudy.Area.Links);
            }
            DbSession.SaveOrUpdate(caseStudy);
            return Content("success");
        }

    }
}