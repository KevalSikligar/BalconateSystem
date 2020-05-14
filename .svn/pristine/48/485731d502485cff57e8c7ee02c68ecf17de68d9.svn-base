using System;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using Balcony.Miracle.Core;
using Balcony.Miracle.Data;
using Balcony.Miracle.Web.Cms;
using Balcony.Miracle.Web.Shared;
using Cobisi.EmailVerify;
using log4net;
using NHibernate;
using NHibernate.Context;
using Org.BouncyCastle.Ocsp;

namespace Balcony.Miracle.Web {
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : HttpApplication {

        public static bool DisableInlineEditing {
            get {
                var val = HttpContext.Current.Session[SessionKeys.DISABLE_INLINE_EDITING];
                return val != null && (bool) val;
            }
            set {
                HttpContext.Current.Session[SessionKeys.DISABLE_INLINE_EDITING] = value;
            }
        }

        protected void Application_PreSendRequestHeaders(object sender, EventArgs e) {
            try {
                Response.Headers.Remove("Server");
            } catch (Exception) {
                return;
            }
        }
        
      

        protected void Application_Start() {
            AreaRegistration.RegisterAllAreas();

            log4net.Config.XmlConfigurator.Configure();
            MvcHandler.DisableMvcResponseHeader = true;

            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            EmailVerifier.RuntimeLicenseKey = "G016NUILAeGgF81JMB03zbbnuDKKCWJhQ9XYfo8HVhhJLA+Uk2l8Jqyqumxb9Pn78MEhaA==";

            DataAnnotationsModelValidatorProvider.RegisterAdapter(typeof(EmailAttribute), typeof(RegularExpressionAttributeAdapter));

            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            Core.User.CurrentUserId = "NewWebsite";
            foreach(var t in  typeof(Area).Assembly.GetTypes().Where(t => t.IsSubclassOf(typeof(MetaBase)))) {
                BaseEntity.MetaTypes.Add(t);
            }

            var config = new NHibernate.Cfg.Configuration();
            config.Configure();
            config.AddAssembly(typeof(NHibernateHelper).Assembly);
            config.AddAssembly(typeof(Page).Assembly);
            Global.SessionFactory = config.BuildSessionFactory();
        }

        protected void Application_BeginRequest(object sender, EventArgs e) {
            var url = Server.UrlDecode(HttpContext.Current.Request.Url.AbsolutePath);
            // remove trailing slash           
            if (Request.HttpMethod.Equals("GET", StringComparison.OrdinalIgnoreCase) && !HttpContext.Current.Request.Url.AbsolutePath.Equals("/") && HttpContext.Current.Request.Url.AbsolutePath.EndsWith("/")) {

                Response.RedirectPermanent(url.Substring(0, url.Length - 1).ToLower() + HttpContext.Current.Request.Url.Query, true);
                return;
            }

            // lower case if needed
            if (Request.HttpMethod.Equals("GET", StringComparison.OrdinalIgnoreCase) && Regex.IsMatch(url, @"[A-Z]")) {
                Response.RedirectPermanent(url.ToLower() + HttpContext.Current.Request.Url.Query, true);
                return;
            }
        }

        void Application_Error(object sender, EventArgs e) {
            try
            {
                var error = Server.GetLastError();

                var httpException = error as HttpException;
                if (httpException != null && httpException.GetHttpCode() == 404)
                {
                    LogManager.GetLogger("NotFoundErrors").WarnFormat("Not Found 404 - {0} - {1}", Request.Url, Request.UserAgent);
                }
                else
                {
                    WebGlobal.HandleException(error, Context);
                }
            }
            catch (Exception ex)
            {
                Global.Logger.Error("Error executing Application_Error", ex);
            }
        }

        protected void Application_EndRequest(object sender, EventArgs e) {
            try 
            {
                if (Response.Cookies.Count > 0 && Request.IsSecureConnection)
                {
                    foreach (string s in Response.Cookies.AllKeys)
                    {
                        if (s == FormsAuthentication.FormsCookieName || s.ToLower() == "asp.net_sessionid")
                        {
                            Response.Cookies[s].Secure = true;
                        }
                    }
                }

                var hasErrors = Server.GetLastError() != null;
                var sess = CurrentSessionContext.Unbind(Global.SessionFactory);
                if (sess != null) 
                {
                    try 
                    {
                        sess.Flush();
                    }
                    catch (Exception ex)
                    {
                        hasErrors = true;
                        Global.Logger.Error("Error flushing db session", ex);
                    }
                }
                var trans = HttpContext.Current.Items[AppKeys.TRANSACTION_KEY] as ITransaction;
                if (trans != null && !trans.WasCommitted && !trans.WasRolledBack) 
                {
                    if (hasErrors && !trans.WasCommitted && !trans.WasRolledBack)
                        trans.Rollback();
                    if (!hasErrors && !trans.WasCommitted && !trans.WasRolledBack)
                        trans.Commit();
                }

                if (trans != null) 
                    trans.Dispose();
                if (sess != null) 
                    sess.Dispose();
            }
            catch (Exception ex)
            {
                Global.Logger.Error("Error executing Application_EndRequest", ex);
            }
        }
    }
}