using System;
using System.Web.Mvc;
using System.Web.Security;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Areas.Admin.Models;
using Balcony.Miracle.Web.Controllers;
 
namespace Balcony.Miracle.Web.Areas.Admin.Controllers {
    public class AccountController : BaseController {
        
        //[UseSsl]
        public ActionResult SignIn(string redirect) {
            if (HttpContext.IsAdmin()) {
                return Redirect("/admin");
            }
            return View(new SignInModel{ Redirect = redirect});
        }

        //[UseSsl]
        [HttpPost]
        public ActionResult SignIn(SignInModel model) {
            if (HttpContext.IsAdmin()) {
                return Redirect("/admin");
            }

            if (ModelState.IsValid) {
                var user = DbSession.Get<User>(model.Username);
                if (user == null || !user.ValidatePassword(model.Password)) {
                    ModelState.AddModelError("", "User - Password combination is invalid");
                    return View(model);
                }
                SetAuthCookie(user.ID, false);
                if (String.IsNullOrEmpty(model.Redirect)) {
                    return Redirect("/admin");
                }
                return Redirect(model.Redirect);
            }
            return View(model);
        }

        public ActionResult SignOut(string redirect) {
            FormsAuthentication.SignOut();
            if (String.IsNullOrEmpty(redirect)) {
                return RedirectToAction("signin");
            }
            return Redirect(redirect);
        }
    }
}