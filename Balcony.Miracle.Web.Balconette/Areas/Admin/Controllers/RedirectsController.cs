using System;
using System.Linq;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Data;
using Balcony.Miracle.Web.Cms;
using Balcony.Miracle.Web.Models;
using Org.BouncyCastle.Crypto.Prng;

namespace Balcony.Miracle.Web.Areas.Admin.Controllers {

    public class RedirectsController : AdminBaseController {

        [SessionScope]
        public ActionResult Index()
        {
            var redirects = DbSession.GetAll<CmsRedirect>()
                .OrderBy(t => t.Url)
                .ToList();
            return View(redirects);
        }

        [HttpPost]
        [SessionScope]
        [TransactionScope]
        public ActionResult Index(ChangesWrapper<CmsRedirect> changes)
        {
            var ok = Json(new {Status = "ok"});

            if (changes == null)
                return ok;
            if (changes.Removed != null)
            {
                foreach (var removed in changes.Removed)
                {
                    DbSession.Delete(removed);
                }
            }
            if (changes.Added != null)
            {
                foreach (var added in changes.Added)
                {
                    DbSession.Save(added);
                }
            }
            if (changes.Changed != null)
            {
                foreach (var changed in changes.Changed)
                {
                    DbSession.Update(changed);
                }
            }
            return ok;
        }
    }
}