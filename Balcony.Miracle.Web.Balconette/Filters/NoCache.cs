using System;
using System.Web;
using System.Web.Mvc;

namespace Balcony.Miracle.Web {

    public class NoCache : OutputCacheAttribute {

        public NoCache() {
            Duration = 1;
        }

        public override void OnActionExecuted(ActionExecutedContext filterContext) {
            base.OnActionExecuted(filterContext);
            filterContext.HttpContext.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            filterContext.HttpContext.Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
            filterContext.HttpContext.Response.Cache.SetNoStore();
            try {
                filterContext.HttpContext.Response.AppendHeader("pragma", "no-cache");
            } catch { }
        }

    }
}
