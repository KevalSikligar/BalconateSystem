using System;
using System.Web;
using System.Web.Mvc;
using Balcony.Miracle.Core;

namespace Balcony.Miracle.Web {

    public class ApiAuthorizeAttribute : AuthorizeAttribute {

        protected override bool AuthorizeCore(HttpContextBase httpContext) {
            return String.Equals(httpContext.Request["k"], Global.WEB_SERVICES_KEY);
        }

    }
}