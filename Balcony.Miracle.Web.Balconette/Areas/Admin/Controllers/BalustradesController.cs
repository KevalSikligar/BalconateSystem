using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Balcony.Miracle.Web.Cms;
using Balcony.Miracle.Web.Controllers;
using Balcony.Miracle.Core;

namespace Balcony.Miracle.Web.Areas.Admin.Controllers {
    
    public class BalustradesController : BaseController {        
        
        [SessionScope]
        public ActionResult Index() {
            return View(DbSession.QueryOver<BalustradeModel>().OrderBy(bm => bm.Inx).Asc.List());
        }

        [SessionScope]
        public ActionResult Edit(Guid? id) {
            BalustradeModel balustradeModel;
            if (id == null) {
                balustradeModel = new BalustradeModel();
            } else {
                balustradeModel = DbSession.Get<BalustradeModel>(id.Value);
            }
            if (balustradeModel == null) {
                return HttpNotFound();
            }
            return View(balustradeModel);
        }

        [HttpPost]
        [TransactionScope]
        [ActionName("Edit")]
        [ValidateInput(false)]
        public ActionResult EditPost(Guid id) {

            BalustradeModel balustradeModel;

            if (Guid.Empty.Equals(id)) {
                balustradeModel = new BalustradeModel();
            } else {
                balustradeModel = DbSession.Get<BalustradeModel>(id);
                balustradeModel.Sections.Clear();
            }
            if (TryUpdateModel(balustradeModel)) {

                DbSession.SaveOrUpdate(balustradeModel);
                DbSession.Flush();
                return RedirectToAction("Edit", new { id = balustradeModel.ID });
            }


            return View(balustradeModel);
        }

      
    }
}
