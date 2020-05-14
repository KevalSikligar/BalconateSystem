using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Areas.Admin.Models;
using Balcony.Miracle.Web.Cms;

namespace Balcony.Miracle.Web.Areas.Admin.Controllers {


    public class ArticlesController : AdminBaseController {
        
       [SessionScope]
       public ActionResult Index() {
           return View(DbSession.QueryOver<Article>().OrderBy(p => p.Inx).Desc.List());
       }

        [SessionScope]
        [Jsonp]
        public ActionResult All(object model) {
            var res = DbSession.GetAll<Article>().ToList();

            return Json(new { d = new { __count = res.Count, results = res } } , JsonRequestBehavior.AllowGet);
        }

        [SessionScope]
        public ActionResult Edit(Guid? id) {
            Article article;
            if (id == null) {
                article = new Article();
                article.Inx = (DbSession.QueryOver<Article>().RowCount() + 1)*10;
            } else {
                article = DbSession.Get<Article>(id.Value);
            }
            if (article == null) {
                return HttpNotFound();
            }
            ViewBag.Areas = DbSession.GetAll<Area>(true);
            ViewBag.CmsBlocks = DbSession.GetAll<CmsBlock>(true);

            return View(article);
        }

        [HttpPost]
        [TransactionScope]
        [ActionName("Edit")]
        [ValidateInput(false)]
        public ActionResult EditPost(Guid id, IList<GalleryImage> images, Guid? links, AreaKind farea) {
                        
            Article article;

            if (Guid.Empty.Equals(id)) {
                article = new Article();
            } else {
                article = DbSession.Get<Article>(id);
                article.Image = null;
                article.SharedLinks = null;
            }
            if (TryUpdateModel(article)) {
                var dtos = article.Tags.ToList();
                article.Tags.Clear();
                foreach (var dtoTag in dtos) {
                    article.Tags.Add(DbSession.Get<Tag>(dtoTag.ID));
                }
                article.Area = DbSession.Get<Area>(farea);
                if (images != null) {
                    ImagesController.SaveImages(images, DbSession);
                    article.Image = images.FirstOrDefault(img => !img.ShouldDelete);
                }
                if (links.HasValue) {
                    article.SharedLinks = DbSession.Get<CmsBlock>(links.Value);
                }

                DbSession.SaveOrUpdate(article);
                DbSession.Flush();
                return RedirectToAction("Edit", new { id = article.ID });
            }

            ViewBag.Areas = DbSession.GetAll<Area>(true);
            ViewBag.CmsBlocks = DbSession.GetAll<CmsBlock>(true);
            return View(article);
        }

        [HttpPost]
        [TransactionScope]
        [ValidateInput(false)]
        public ActionResult Save(Guid id, string name, string body, string links, string areaLinks, string title, string desc, string keywords) {
            var article = DbSession.Get<Article>(id);
            if (article == null) return HttpNotFound();
            article.Name = name;
            article.Body = body;
            article.Title = title;
            article.Description = desc;
            article.Keywords = keywords;
            
            if (!String.IsNullOrEmpty(links) && article.SharedLinks != null) {
                article.SharedLinks.Html = links;
                DbSession.SaveOrUpdate(article.SharedLinks);
            }
            if (!String.IsNullOrEmpty(areaLinks) && article.Area.Links != null) {
                article.Area.Links.Html = areaLinks;
                DbSession.SaveOrUpdate(article.Area.Links);
            }
            DbSession.SaveOrUpdate(article);
            return Content("success");
        }

    }
}