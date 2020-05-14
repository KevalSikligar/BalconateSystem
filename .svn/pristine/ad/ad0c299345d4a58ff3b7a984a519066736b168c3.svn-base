using System.Web.Mvc;

namespace Balcony.Miracle.Web.Areas.Admin {
    
    public class AdminAreaRegistration : AreaRegistration {
        
        public override string AreaName {
            get {
                return "Admin";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) {
            context.MapRouteLowercase(
                "admin_default",
                "admin/{controller}/{action}/{id}",
                new { controller = "areas", action = "Index", id = UrlParameter.Optional },                
                null,
                new[] { "Balcony.Miracle.Web.Areas.Admin.Controllers" }
            );
        }
    }
}
