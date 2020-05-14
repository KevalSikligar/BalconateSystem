using System.Web.Mvc;
using Balcony.Miracle.Web.Cms;

namespace Balcony.Miracle.Web.Controllers {

    
    public class BalconyViewsController : BaseController {

        public BalconyViewsController() :
            base(AreaKind.BalconyViews) {
        }


        public override string DefaultAction {
            get {
                return "homepage";
            }
        }

        public ActionResult Homepage() {
            return View(Area);
        }



    }
}