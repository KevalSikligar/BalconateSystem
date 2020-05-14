using System;
using System.Web.Mvc;
using System.Web.Routing;

namespace Balcony.Miracle.Web {

    public static class RouteExtensions {

        public static Route MapRouteLowercase(this AreaRegistrationContext context, string name, string url) {
            return context.MapRouteLowercase(name, url, null);            
        }

        public static Route MapRouteLowercase(this AreaRegistrationContext context, string name, string url, object defaults) {
            return context.MapRouteLowercase(name, url, defaults, null);
        }

        public static Route MapRouteLowercase(this AreaRegistrationContext context, string name, string url, object defaults, object constraints) {
            return context.MapRouteLowercase(name, url, defaults, constraints, null);           
        }

        public static Route MapRouteLowercase(this AreaRegistrationContext context, string name, string url, object defaults, object constraints, string[] namespaces) {
            var route = context.Routes.MapRouteLowercase(name, url, defaults, constraints, namespaces);
            route.DataTokens["area"] = context.AreaName;
            return route;
        }

        public static Route MapRouteLowercase(this RouteCollection routes, string name, string url) {
            return routes.MapRouteLowercase(name, url, null);
        }

        public static Route MapRouteLowercase(this RouteCollection routes, string name, string url, object defaults) {
            return routes.MapRouteLowercase(name, url, defaults, null);
        }

        public static Route MapRouteLowercase(this RouteCollection routes, string name, string url, object defaults, object constraints) {
            return routes.MapRouteLowercase(name, url, defaults, constraints, null);
        }

        public static Route MapRouteLowercase(this RouteCollection routes, string name, string url, object defaults, object constraints, string[] namespaces) {
            if (routes == null)
                throw new ArgumentNullException("routes");
            if (url == null)
                throw new ArgumentNullException("url");

            var route = new LowercaseRoute(url, new MvcRouteHandler()) {
                Defaults = new RouteValueDictionary(defaults),
                Constraints = new RouteValueDictionary(constraints)
            };
            route.DataTokens = new RouteValueDictionary();
            if ((namespaces != null) && (namespaces.Length > 0)) {
                route.DataTokens["Namespaces"] = namespaces;
            }

            if (String.IsNullOrEmpty(name))
                routes.Add(route);
            else
                routes.Add(name, route);
            return route;
        }
    }

    public class LowercaseRoute : Route {
        public LowercaseRoute(string url, IRouteHandler routeHandler)
            : base(url, routeHandler) { }
        public LowercaseRoute(string url, RouteValueDictionary defaults, IRouteHandler routeHandler)
            : base(url, defaults, routeHandler) { }
        public LowercaseRoute(string url, RouteValueDictionary defaults, RouteValueDictionary constraints, IRouteHandler routeHandler)
            : base(url, defaults, constraints, routeHandler) { }
        public LowercaseRoute(string url, RouteValueDictionary defaults, RouteValueDictionary constraints, RouteValueDictionary dataTokens, IRouteHandler routeHandler)
            : base(url, defaults, constraints, dataTokens, routeHandler) { }

        public override VirtualPathData GetVirtualPath(RequestContext requestContext, RouteValueDictionary values) {
            var path = base.GetVirtualPath(requestContext, values);
            if (path != null)
                path.VirtualPath = path.VirtualPath.ToLowerInvariant();
            return path;
        }
    }
}

