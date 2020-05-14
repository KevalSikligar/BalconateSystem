using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Models;
using Balcony.Miracle.Web.Shared;
using NHibernate;

namespace Balcony.Miracle.Web {

    public static class HttpContextExtensions {

        public static Guid? GetCustomerId(this HttpContext context) {
            if (context.User == null || !context.User.Identity.IsAuthenticated || String.IsNullOrEmpty(context.User.Identity.Name)) {
                return null;
            }
            var str = Json.Decode<UserNameModel>(context.User.Identity.Name).CustomerId;
            return !String.IsNullOrWhiteSpace(str) ? new Guid(str) : (Guid?)null;
        }

        public static Guid? GetCustomerId(this HttpContextBase context) {
            return HttpContext.Current.GetCustomerId();
        }

        public static string GetUserId(this HttpContext context) {
            if (context.User == null || !context.User.Identity.IsAuthenticated || String.IsNullOrEmpty(context.User.Identity.Name)) {
                return null;
            }
            return Json.Decode<UserNameModel>(context.User.Identity.Name).UserId;
        }

        public static string GetUserId(this HttpContextBase context) {
            return HttpContext.Current.GetUserId();
        }

        public static ISession GetDbSession(this HttpContext context) {
            SessionScope.Bind();
            return Global.SessionFactory.GetCurrentSession();
        }
        
        public static ISession GetDbSession(this HttpContextBase context) {
            return HttpContext.Current.GetDbSession();
        }

        public static ITransaction GetDbTransaction(this HttpContext context) {
            return context.Items[AppKeys.TRANSACTION_KEY] as ITransaction;
        }

        public static ITransaction GetDbTransaction(this HttpContextBase context) {
            return HttpContext.Current.GetDbTransaction();
        }

        public static bool IsCustomer(this HttpContext context) {
            return context.GetCustomerId() != null;
        }

        public static bool IsCustomer(this HttpContextBase context) {
            return HttpContext.Current.IsCustomer();
        }

        public static Guid? GetQuoteCustomerId(this HttpContext context) {
            if (context.Session[SessionKeys.QUOTE_CUSTOMER_ID] == null) {
                return null;
            }
            return (Guid)context.Session[SessionKeys.QUOTE_CUSTOMER_ID];
        }

        public static Guid? GetQuoteCustomerId(this HttpContextBase context) {
            return HttpContext.Current.GetQuoteCustomerId();
        }

        public static bool IsQuoteCustomer(this HttpContext context) {
            return context.GetQuoteCustomerId().HasValue;
        }

        public static bool IsQuoteCustomer(this HttpContextBase context) {
            return HttpContext.Current.IsQuoteCustomer();
        }

        public static bool IsCustomerOrQuoteCustomer(this HttpContext context) {
            return context.IsCustomer() || context.IsQuoteCustomer();
        }

        public static bool IsCustomerOrQuoteCustomer(this HttpContextBase context) {
            return HttpContext.Current.IsCustomerOrQuoteCustomer();
        }


        public static bool IsAdmin(this HttpContext context) {
            if (!context.Request.IsAuthenticated) return false;
            if (context.Session != null && context.Session[SessionKeys.IS_ADMIN_SESSION_KEY] != null && context.Session[SessionKeys.IS_ADMIN_SESSION_KEY] is bool && (bool)context.Session[SessionKeys.IS_ADMIN_SESSION_KEY]) {
                return true;
            }
            var uid = context.GetUserId();
            if (uid == null) {
                return false;
            }
            var user = context.GetDbSession().Get<User>(uid);
            if (user == null) {
                return false;
            }
            return user.IsInGroup(User.UserGroup.Admins);
        }

        public static bool IsAdmin(this HttpContextBase context) {
            return HttpContext.Current.IsAdmin();
        }

        public static T GetSessionValue<T>(this HttpContext context, string key) {
            var value = context.Session[key];
            if (value is T)
                return (T)value;
            return default(T);
        }

        public static T GetSessionValue<T>(this HttpContextBase context, string key)
        {
            return HttpContext.Current.GetSessionValue<T>(key);
        }

        public static Customer GetCachedCustomer(this HttpContext context) {
            var cid = context.GetCustomerId();
            if (!cid.HasValue) return null;
            Customer res = null;
            if (context.Session[SessionKeys.CACHED_CUSTOMER] != null) {
                res = context.Session[SessionKeys.CACHED_CUSTOMER] as Customer;
            }
            if (res != null && Equals(cid, res.ID)) {
                return res;
            }
            res = context.GetDbSession().Get<Customer>(cid);
            res.Initialize();
            context.Session[SessionKeys.CACHED_CUSTOMER] = res;
            return res;
        }

        public static Customer GetCachedCustomer(this HttpContextBase context) {
            return HttpContext.Current.GetCachedCustomer();
        }

        public static bool IsAdmin(this ViewPage page) {
            return page.ViewContext.RequestContext.HttpContext.IsAdmin();
        }

        public static bool IsCustomer(this ViewPage page) {
            return page.ViewContext.RequestContext.HttpContext.IsCustomer();
        }

        public static bool IsCustomerOrQuoteCustomer(this ViewPage page) {
            return page.ViewContext.RequestContext.HttpContext.IsCustomerOrQuoteCustomer();
        }

        public static bool IsAdmin(this ViewMasterPage master) {
            return HttpContext.Current.IsAdmin();
        }

        public static bool IsCookiesAllowed(this HttpContext context) {
            if (context.Session[SessionKeys.ALLOW_COOKIES] != null) {
                return true;
            }
            return context.Request.Cookies[CookieKeys.ALLOW_COOKIES] != null;
        }


        public static IList<CartItem> GetCartItems(this HttpContextBase context) {
            return HttpContext.Current.GetCartItems();
        }

        public static IList<CartItem> GetCartItems(this HttpContext context) {
            var cusid = context.GetCustomerId() ?? Guid.Empty;
            var si = WebGlobal.GetSessionCookie(context);
            return context.GetDbSession()
                .CreateQuery(@"select distinct ci 
                               from CartItem as ci 
                               left join fetch ci.ProductDetails 
                               where ci.AppId = :appid and (ci.Customer.ID = :cusid or ci.SessionID = :si) 
                               order by ci.DateCreated")
                .SetParameter("appid", WebGlobal.AppId)
                .SetParameter("si", si)
                .SetParameter("cusid", cusid)
                .SetCacheable(true)
                .SetCacheMode(CacheMode.Normal)
                .List<CartItem>();
        }

        public static int CartCount(this HttpContextBase context)
        {
            return HttpContext.Current.CartCount();
        }

        public static int CartCount(this HttpContext context) {
            if (context.Session[SessionKeys.CART_COUNT] != null)
                return (int) context.Session[SessionKeys.CART_COUNT];
            var count = (int)context.GetCartItems().Sum(ci => ci.Quantity);
            context.Session[SessionKeys.CART_COUNT] = count;
            return count;
        }

        public static void ResetCartCount(this HttpContextBase context)
        {
            HttpContext.Current.ResetCartCount();
        }

        public static void ResetCartCount(this HttpContext context) {
            context.Session[SessionKeys.CART_COUNT] = null;
        }

        public static void ClearCartItems(this HttpContextBase context) {
            HttpContext.Current.ClearCartItems();
        }

        public static void ClearCartItems(this HttpContext context) {
            var session = context.GetDbSession();
            using (var trans = session.BeginTransaction()) {
                try {
                    foreach (var cartItem in context.GetCartItems()) {
                        session.Delete(cartItem);
                    }
                    session.Flush();
                    trans.Commit();
                } catch {
                    trans.Rollback();
                    throw;
                }
            }
        }       


    }
}