using System.Web.Mvc;

namespace Balcony.Miracle.Web.Areas.Api {

    public class ApiAreaRegistration : AreaRegistration {
        public override string AreaName {
            get {
                return "api";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) {
            context.MapRouteLowercase(
                "api_Route",
                "api/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional },
                null,
                new[] { "Balcony.Miracle.Web.Areas.Api.Controllers" }
            );
        }
    }
}
