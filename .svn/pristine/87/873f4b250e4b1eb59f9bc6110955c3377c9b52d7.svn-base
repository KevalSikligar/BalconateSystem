using System;
using System.Web.Mvc;
using Balcony.Miracle.Web.Cms;

namespace Balcony.Miracle.Web.Controllers {
    
    public class CmsController : BaseController {

        public ActionResult Block(Guid id) {
            var block = DbSession.Get<CmsBlock>(id);
            if (block == null)
                return HttpNotFound();
            return Content(block.Html);
        }

    }
}
