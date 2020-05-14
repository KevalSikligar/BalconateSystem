using System.Web.Mvc;
using Balcony.Miracle.Web.Cms;

namespace Balcony.Miracle.Web.Controllers {

    
    public class DeckingController : BaseController {

        public DeckingController() :
            base(AreaKind.Decking) {
            AccessoryKindId = "DECKING";
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