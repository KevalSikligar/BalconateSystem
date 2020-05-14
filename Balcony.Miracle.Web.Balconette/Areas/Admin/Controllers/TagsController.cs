using System;
using System.Linq;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Data;
using Balcony.Miracle.Web.Cms;

namespace Balcony.Miracle.Web.Areas.Admin.Controllers {

    public class TagsController : AdminBaseController {
        
       [SessionScope]
       public ActionResult Index() {
           return View(DbSession.GetAll<Tag>("tags")
               .OrderBy(t => t.TagCategory.Inx)
               .ThenBy(t => t.Inx)
               .ToList());
       }

     
        [SessionScope]
        public ActionResult Edit(Guid? id) {
           Tag area;
           if (id == null) {
               area = new Tag();
           } else {
               area = DbSession.Get<Tag>(id.Value);
           }
           if (area == null) {
               return HttpNotFound();
           }
           ViewBag.Categories = DbSession.GetAll<TagCategory>("tags");

           return View(area);
       }

        [HttpPost]
        [TransactionScope]
        [ValidateInput(false)]
        [ActionName("Edit")]
        public ActionResult EditPost(Guid id, Guid fcategory) {
            Tag area;
            if (Guid.Empty.Equals(id)) {
                area = new Tag();
            } else {
                area = DbSession.Get<Tag>(id);
                area.TagCategory = null;
            }
            if (TryUpdateModel(area)) {
                area.TagCategory = DbSession.Get<TagCategory>(fcategory);
                DbSession.SaveOrUpdate(area);
                DbSession.Flush();
                NHibernateHelper.ClearCache("tags");
                return RedirectToAction("Edit", new { id = area.ID });
            }

            ViewBag.Categories = DbSession.GetAll<TagCategory>("tags");
            return View(area);
        }

    }
}