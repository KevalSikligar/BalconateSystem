using System;
using System.Collections.Generic;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Cms;
using NHibernate;

namespace Balcony.Miracle.Web.Areas.Admin.Controllers {


    public class PagesController : AdminBaseController {
        
       [SessionScope]
       public ActionResult Index() {

           return View(DbSession.QueryOver<StandardPage>()
               .OrderBy(p => p.Area).Asc
               .ThenBy(p => p.Name).Asc
               .Cacheable()
               .CacheMode(CacheMode.Normal)
               .List());
       }

     

        [SessionScope]
        public ActionResult Edit(Guid? id) {
            StandardPage page;
            if (id == null) {
                page = new StandardPage();
            } else {
                page = DbSession.Get<StandardPage>(id.Value);
            }
            if (page == null) {
                return HttpNotFound();
            }
            ViewBag.Areas = DbSession.GetAll<Area>(true);
            ViewBag.Blocks = DbSession.GetAll<CmsBlock>(true);
            return View(page);
        }

        [HttpPost]
        [TransactionScope]
        [ActionName("Edit")]
        [ValidateInput(false)]
        public ActionResult EditPost(Guid id, AreaKind farea, IList<Tag> tags, Guid? footerid, bool disableInline) {

            StandardPage page;

            if (Guid.Empty.Equals(id)) {
                page = new StandardPage();
            } else {
                page = DbSession.Get<StandardPage>(id);
            }
            if (TryUpdateModel(page)) {
                MvcApplication.DisableInlineEditing = disableInline;
                page.Tags.Clear();
                if (tags != null) {
                    foreach (var dtoTag in tags) {
                        page.Tags.Add(DbSession.Get<Tag>(dtoTag.ID));
                    }
                }
                page.Area = DbSession.Get<Area>(farea);
                page.FooterLinksID = footerid;
                DbSession.SaveOrUpdate(page);
                DbSession.Flush();
                return RedirectToAction("Edit", new { id = page.ID });
            }

            ViewBag.Areas = DbSession.GetAll<Area>(true);
            ViewBag.Blocks = DbSession.GetAll<CmsBlock>(true);
            return View(page);
        }

        [HttpPost]
        [TransactionScope]
        [ValidateInput(false)]
        public ActionResult Save(Guid id, string f_name, string f_body, string f_title, string f_desc, string f_keywords) {
            var page = DbSession.Get<StandardPage>(id);
            if (page == null) return HttpNotFound();
            page.Name = f_name;
            page.Body = f_body;
            page.Title = f_title;
            page.Description = f_desc;
            page.Keywords = f_keywords;
            DbSession.SaveOrUpdate(page);
            return Content("success");
        }

    }
}