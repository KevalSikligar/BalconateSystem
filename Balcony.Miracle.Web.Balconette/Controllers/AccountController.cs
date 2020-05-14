using System;
using System.Web;
using System.Web.Mvc;

namespace Balcony.Miracle.Web.Controllers {

    public class AccountController : BaseController {

        [HttpPost]
        [ActionName("allow-cookies")]
        public ActionResult AllowCookies() {
            Session[SessionKeys.ALLOW_COOKIES] = true;
            if (Request.Cookies[CookieKeys.ALLOW_COOKIES] == null) {
                Response.Cookies.Add(new HttpCookie(CookieKeys.ALLOW_COOKIES, "true"){  Expires = DateTime.Now.AddMonths(3) });
            }
            return Content("");
        }
    }
}
