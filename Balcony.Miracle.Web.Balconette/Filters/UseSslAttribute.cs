using System;
using System.Configuration;
using System.Web.Mvc;

namespace Balcony.Miracle.Web {

    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, Inherited = true, AllowMultiple = false)]
    public class UseSslAttribute : FilterAttribute, IAuthorizationFilter
    {

        public UseSslAttribute()
            : this(false) {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="RequireHttpsAttribute"/> class.
        /// </summary>
        /// <param name="permanent">Whether the redirect to HTTPS should be a permanent redirect.</param>
        public UseSslAttribute(bool permanent) {
            Permanent = permanent;
        }

        /// <summary>
        /// Gets a value indicating whether the redirect to HTTPS should be a permanent redirect.
        /// </summary>
        public bool Permanent { get; private set; }

        public virtual void OnAuthorization(AuthorizationContext filterContext) {
            if (filterContext == null) {
                throw new ArgumentNullException("filterContext");
            }

            if (String.Equals(filterContext.HttpContext.Request.HttpMethod, "GET", StringComparison.OrdinalIgnoreCase) &&
                !String.IsNullOrWhiteSpace(ConfigurationManager.AppSettings[AppSettings.USE_SSL]) &&
                Boolean.Parse(ConfigurationManager.AppSettings[AppSettings.USE_SSL]) &&
                !filterContext.HttpContext.Request.IsSecureConnection) {

                var url = "https://" + filterContext.HttpContext.Request.Url.Host + filterContext.HttpContext.Request.RawUrl;
                filterContext.Result = new RedirectResult(url, Permanent);
            }
        }
    }
}