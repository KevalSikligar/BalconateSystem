using System;
using System.Web.Mvc;
using Balcony.Miracle.Data;
using Balcony.Miracle.Web.Cms;

namespace Balcony.Miracle.Web.Areas.Admin.Controllers {

    public class TagCategoriesController : AdminBaseController {
        
       [SessionScope]
       public ActionResult Index() {

           return View(TagCategories);
       }

     
        [SessionScope]
        public ActionResult Edit(Guid? id) {
            TagCategory block;
            if (id == null) {
                block = new TagCategory();
            } else {
                block = DbSession.Get<TagCategory>(id.Value);
            }
            if (block == null) {
                return HttpNotFound();
            }
            return View(block);
        }

        [HttpPost]
        [TransactionScope]
        [ValidateInput(false)]
        [ActionName("Edit")]
        public ActionResult EditPost(Guid id) {
            TagCategory block;
            if (Guid.Empty.Equals(id)) {
                block = new TagCategory();
            } else {
                block = DbSession.Get<TagCategory>(id);
            }
            if (TryUpdateModel(block)) {
                DbSession.SaveOrUpdate(block);
                DbSession.Flush();
                NHibernateHelper.ClearCache("tags");
                return RedirectToAction("Edit", new { id = block.ID });
            }

            return View(block);
        }

    }
}