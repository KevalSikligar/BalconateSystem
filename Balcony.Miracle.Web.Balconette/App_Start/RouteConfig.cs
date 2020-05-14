using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Balcony.Miracle.Web.Cms;
using NHibernate;

namespace Balcony.Miracle.Web {

    public class RouteConfig {

        public static void RegisterRoutes(RouteCollection routes) {
            // Old website fallback
            routes.Add("CustomRedirects", new CustomRedirectsRoute());

            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.IgnoreRoute("Juliettes/{*pathInfo}");
            routes.IgnoreRoute("Balustrades/{*pathInfo}");
            routes.IgnoreRoute("CurvedDoors/{*pathInfo}");
            routes.IgnoreRoute("Balconano/{*pathInfo}");
            routes.IgnoreRoute("BalconyViews/{*pathInfo}");
            routes.IgnoreRoute("CaseStudies/{*pathInfo}");
            routes.IgnoreRoute("Decking/{*pathInfo}");

            routes.MapRouteLowercase("Photos",
                "photos/",
                new { controller = "Photos", action = "Index" },
                null,
                new[] { "Balcony.Miracle.Web.Controllers" });


            routes.MapRouteLowercase("Decking",
                "composite-decking/{action}/{id}",
                new { controller = "Decking", action = "_fallback", id = UrlParameter.Optional },
                null,
                new[] { "Balcony.Miracle.Web.Controllers" });

            routes.MapRouteLowercase("BalconyViews",
                "balcony-views/{action}/{id}",
                new { controller = "BalconyViews", action = "_fallback", id = UrlParameter.Optional },
                null,
                new[] { "Balcony.Miracle.Web.Controllers" });

            routes.MapRouteLowercase("Juliettes",
                "juliet-balcony/{action}/{id}",
                new { controller = "Juliettes", action = "_fallback", id = UrlParameter.Optional },
                null,
                new[] { "Balcony.Miracle.Web.Controllers" });

            routes.MapRouteLowercase("Balconano",
                "self-cleaning-glass/{action}/{id}",
                new { controller = "Balconano", action = "_fallback", id = UrlParameter.Optional },
                null,
                new[] { "Balcony.Miracle.Web.Controllers" });
            
            routes.MapRouteLowercase("Balustrades",
                "glass-balustrade/{action}/{id}",
                new { controller = "Balustrades", action = "_fallback", id = UrlParameter.Optional },
                null,
                new[] { "Balcony.Miracle.Web.Controllers" });

            routes.MapRouteLowercase("CurvedDoors",
                "curved-doors/{action}/{id}",
                new { controller = "CurvedDoors", action = "_fallback", id = UrlParameter.Optional },
                null,
                new[] { "Balcony.Miracle.Web.Controllers" });

            routes.MapRouteLowercase("Default", 
                "{controller}/{action}/{id}",
                new { controller = "General", action = "_fallback", id = UrlParameter.Optional },
                null,
                new[] { "Balcony.Miracle.Web.Controllers" });
        }
    }

    public class CustomRedirectsRoute : RouteBase
    {
        public override RouteData GetRouteData(HttpContextBase httpContext)
        {
            if (!"GET".Equals(httpContext.Request.HttpMethod, StringComparison.InvariantCultureIgnoreCase))
                return null;

            var redirect = httpContext.GetDbSession().QueryOver<CmsRedirect>()
                .Where(r => r.Url == httpContext.Request.Url.PathAndQuery)
                .Cacheable()
                .CacheMode(CacheMode.Normal)
                .SingleOrDefault();

            if (redirect != null)
            {
                var result = new RouteData(this, new MvcRouteHandler());
                result.Values.Add("controller", "General");
                result.Values.Add("action", "CmsRedirect");
                result.Values.Add("url", redirect.RedirectUrl);
                result.Values.Add("permanent", redirect.IsPermanent);
                return result;
            }

            return null;
        }

        public override VirtualPathData GetVirtualPath(RequestContext requestContext, RouteValueDictionary values)
        {
            return null;
        }
    }
}