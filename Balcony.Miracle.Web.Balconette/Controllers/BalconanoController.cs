using System;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Cms;
using NHibernate;

namespace Balcony.Miracle.Web.Controllers {

    
    public class BalconanoController : BaseController {

        public BalconanoController() :
            base(AreaKind.Balconano) {
                AccessoryKindId = "BALCONANO";
        }

        public override string DefaultAction {
            get {
                return "homepage";
            }
        }

        [SessionScope]
        public ActionResult Homepage() {
            ViewBag.Products = DbSession.QueryOver<AccessoryTypeLocal>()
                .Where(at => at.OnlineVisible && at.F2 < 0)
                .OrderBy(at => at.F2)
                .Asc
                .Cacheable()
                .CacheMode(CacheMode.Normal)
                .List();            

            return View(Area);
        }
    }
}