using System;
using System.Linq;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Cms;

namespace Balcony.Miracle.Web.Areas.Admin.Controllers {

    public class CmsBlocksController : AdminBaseController {
        
       [SessionScope]
       public ActionResult Index() {

           return View(DbSession.GetAll<CmsBlock>(true).ToList());
       }

     
        [SessionScope]
        public ActionResult Edit(Guid? id) {
            CmsBlock block;
            if (id == null) {
                block = new CmsBlock();
            } else {
                block = DbSession.Get<CmsBlock>(id.Value);
            }
            if (block == null) {
                return HttpNotFound();
            }
            return View(block);
        }

        [HttpPost]
        [TransactionScope]
        [ActionName("Edit")]
        [ValidateInput(false)]
        public ActionResult EditPost(Guid id) {
            CmsBlock block;
            if (Guid.Empty.Equals(id)) {
                block = new CmsBlock();
            } else {
                block = DbSession.Get<CmsBlock>(id);
            }
            if (TryUpdateModel(block)) {
                DbSession.SaveOrUpdate(block);
                DbSession.Flush();
                return RedirectToAction("Edit", new { id = block.ID });
            }

            return View(block);
        }

    }
}