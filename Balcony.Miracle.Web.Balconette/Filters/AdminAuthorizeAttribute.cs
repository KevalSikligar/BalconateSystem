using System.Web;
using System.Web.Mvc;

namespace Balcony.Miracle.Web {

    public class AdminAuthorizeAttribute : AuthorizeAttribute {

        protected override bool AuthorizeCore(HttpContextBase httpContext) {
            return httpContext.IsAdmin();
        }

        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext) {
            filterContext.Result = new RedirectResult("/admin/account/signin?redirect=" + filterContext.HttpContext.Request.Url);
        }
       
       
    }
}