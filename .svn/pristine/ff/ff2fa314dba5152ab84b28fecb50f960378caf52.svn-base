using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Runtime.Serialization;
using System.Text; 
using System.Web.Mvc;
using System.Web.Security;  
using System.Xml;
using System.Linq;
using System.Net.Http;
using System.Web;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Cms;
using Balcony.Miracle.Web.Models;
using Balcony.Miracle.Web.Shared;
using Google.Apis.Customsearch.v1;
using Google.Apis.Services;
using Newtonsoft.Json;
using Balcony.Miracle.Core.Services.TemplateService;
using NHibernate;

namespace Balcony.Miracle.Web.Controllers {

    public class BaseController : Controller {
        private const string SOURCE_COOKIE_NAME = "msubs";

        private Area area;

        private bool iscatch;

        protected Page PageObj { get; set; }

        public BaseController(AreaKind areaKind) {
            AreaKind = areaKind;
        }

        public BaseController() : this(AreaKind.General) {}

        protected override void OnActionExecuting(ActionExecutingContext filterContext) {
            base.OnActionExecuting(filterContext);
            if (Request.Url == null)
                return;
            
            ViewBag.NoCookiePanel = Request.QueryString["no-cookie-panel"] != null;

            HandleSubSourceCookie();

            var action = filterContext.RouteData.Values["action"] as string;
            var url = action ?? Request.Url.AbsolutePath;

            PageObj = DbSession.QueryOver<Page>()
                .Where(p => p.Area.ID == AreaKind && p.Url == url)
                .Cacheable()
                .CacheMode(CacheMode.Normal)
                .List()
                .FirstOrDefault();

            if (PageObj != null)
            {
                Area = PageObj.Area;
                PageHeader = PageObj;
                ViewBag.FooterID = PageObj.FooterLinksID;

                if (PageObj.Url == "_404_")
                {
                    Response.StatusCode = 404;
                }
                else if (PageObj.Url == "_500_")
                {
                    Response.StatusCode = 500;
                }
            }
            var qstr = Request["areas"];
            AreaKind qsarea;
            if (RouteData != null && !String.IsNullOrEmpty(qstr) && Enum.TryParse(qstr, true, out qsarea)) {
                Area = DbSession.Get<Area>(qsarea);
            }

            if (AreaKind > AreaKind.General && Url != null) {
                ViewBag.AreaUrl = Url.Action(DefaultAction ?? "homepage", Area.ID.ToString());
            } else {
                ViewBag.AreaUrl = "";
            }
        }

        private void HandleSubSourceCookie()
        {
            try
            {
                var cookie = Request.Cookies[SOURCE_COOKIE_NAME];
                if (cookie != null)
                    return;

                var referrer = Request.UrlReferrer != null &&
                               !String.Equals(Request.UrlReferrer.Host, Request.Url.Host, StringComparison.InvariantCultureIgnoreCase) ? (Request.UrlReferrer.Host ?? "") : "";

                var source = 101;
                var subsource = Request.QueryString["subsource"];
                if (String.IsNullOrEmpty(subsource))
                {
                    source = String.IsNullOrEmpty(referrer) ? 103 : 102;
                    subsource = String.IsNullOrEmpty(referrer) ? Request.Url.AbsolutePath : referrer;
                }

                var sourceInfo = new SourceInfo
                {
                    Src = source,
                    Sub = subsource
                };

                cookie = new HttpCookie(SOURCE_COOKIE_NAME, sourceInfo.Encode());

                Response.Cookies.Add(cookie);
            }
            catch (Exception ex)
            {
                Global.Logger.Error("Error setting source cookie", ex);
            }
        }

        protected Tuple<CustomerSource, string> GetSource()
        {
            try
            {
                var cookie = Request.Cookies[SOURCE_COOKIE_NAME];
                if (cookie == null)
                    return Tuple.Create(DbSession.Get<CustomerSource>(1), String.Empty);

                var sourceInfo = SourceInfo.Decode(cookie.Value);
                if(sourceInfo == null)
                    return Tuple.Create(DbSession.Get<CustomerSource>(1), String.Empty);

                return Tuple.Create(DbSession.Get<CustomerSource>(sourceInfo.Src), sourceInfo.Sub);
            }
            catch
            {
                return Tuple.Create(DbSession.Get<CustomerSource>(1), String.Empty);
            }
        }
        
        public class SourceInfo
        {
            public int Src { get; set; }     

            public string Sub { get; set; }

            public string Encode()
            {
                return Convert.ToBase64String(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(this)));
            }

            public static SourceInfo Decode(string encoded)
            {
                try
                {
                    if(String.IsNullOrEmpty(encoded))
                        return new SourceInfo();

                    return JsonConvert.DeserializeObject<SourceInfo>(Encoding.UTF8.GetString(Convert.FromBase64String(encoded)));
                }
                catch
                {
                    return null;
                }
            }
        }

        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            if (!Request.IsAjaxRequest()) return;
            var r1 = filterContext.Result as RedirectResult;
            var r2 = filterContext.Result as RedirectToRouteResult;
            if (r1 != null || r2 != null)
            {
                filterContext.Result.ExecuteResult(filterContext.Controller.ControllerContext);

                filterContext.Result = Json(new { __kind__ = 302, location = Response.RedirectLocation });
                Response.Headers.Remove("Location");
                Response.Clear();
                Response.StatusCode = 200;
                Response.Status = "200 OK";
                Response.RedirectLocation = null;
            }
        }

        protected override void HandleUnknownAction(string actionName)
        {
            iscatch = true;
            ActionInvoker.InvokeAction(ControllerContext, "_catch");
        }
        protected ActionResult QuoteSuccess(Guid? id, string action)
        {
            Quote quote;
            if (!id.HasValue || (quote = DbSession.Get<Quote>(id.Value)) == null)
            {
                return HttpNotFound();
            }
            var line = quote.RawQuoteLines.FirstOrDefault();
            if (line == null || line.ProductDetails == null)
            {
                return HttpNotFound();
            }
            AreaKind = Area.ProductToAreaKind(line.ProductDetails);
            var page = FindStandardPage(action);

            if (page == null)
                return HttpNotFound();
            if (AreaKind != page.Area.ID)
                return HttpNotFound();
            PageHeader = page;
            ViewBag.NoCookiePanel = !page.UseTemplate;
            TempData["QuoteID"] = quote.ID.ToString();
            ViewBag.FooterID = page.FooterLinksID;
            page.Body = TemplateService.GetText(DbSession.Get<Template>(WebGlobal.OnlineQuoteTemplateId).Body, quote);
             return View("QuotePage", page.UseTemplate ? "~/Views/Shared/Site.Master" : "~/Views/Shared/Main.Master", new StandardPageModel(page, HttpContext));
            

        }
        public ActionResult _catch(string action)
        {
            if (!iscatch)
                return HttpNotFound();
            if (String.IsNullOrWhiteSpace(action))
                return HttpNotFound();
            var page = FindStandardPage(action);
            if (page == null)
                return HttpNotFound();
            if (AreaKind != page.Area.ID)
                return HttpNotFound();
            PageHeader = page;
            ViewBag.NoCookiePanel = !page.UseTemplate;
            ViewBag.FooterID = page.FooterLinksID;

            switch (page.IndexType)
            {
                case IndexType.Gallery:
                    return GetIndexView<GalleryImage>(page, "Photos");
                case IndexType.Articles:
                    return GetIndexView<Article>(page, "Articles");
                case IndexType.CaseStudies:
                    return GetIndexView<CaseStudy>(page, "CaseStudies");
                case IndexType.CustomerReviews:
                    return GetIndexView<CustomerReview>(page, "CustomerReviewsIndex");
                case IndexType.Downloads:
                    return GetIndexView<UploadedFile>(page, "Downloads");
                
                default:
                    return View("Page", page.UseTemplate ? "~/Views/Shared/Site.Master" : "~/Views/Shared/Main.Master", new StandardPageModel(page, HttpContext));
            }
        }

        private ActionResult GetIndexView<T>(StandardPage page, string viewName)
        {
            var model = new IndexModel<T>();
            model.AreaKind = AreaKind;
            model.HideFilterBar = true;
            model.Tags = page.Tags;
            model.Body = page.Body;
            model.TagCategories = DbSession.Get<Area>(AreaKind)
                .GetTagsForIndexType(page.IndexType)
                .OrderBy(tag => tag.Inx)
                .GroupBy(tag => tag.TagCategory)
                .OrderBy(g => g.Key.Inx);

            model.Results = CreateTagsQuery<T>(model.Tags).List<T>();

            ViewBag.Body = page.Body ?? "";

            return View(viewName, model);
        }

        protected Area Area
        {
            get { return area; }
            set
            {
                area = value;
                ViewBag.Area = area.ID;
                PageHeader = area;
                ViewBag.AreaName = area.Name;
                if (AreaKind > AreaKind.General && Url != null)
                {
                    ViewBag.AreaUrl = Url.Action("homepage", area.ID.ToString());
                }
                else
                {
                    ViewBag.AreaUrl = "";
                }
            }
        }

        private IPageHeader pageHeader;

        protected StandardPage StandardPageObj
        {
            get { return PageObj as StandardPage; }
        }

        public IPageHeader PageHeader
        {
            get { return pageHeader; }
            set
            {
                pageHeader = value;
                if (pageHeader != null)
                {
                    ViewBag.Title = pageHeader.Title ?? "";
                    ViewBag.Keywords = pageHeader.Keywords ?? "";
                    ViewBag.Description = pageHeader.Description ?? "";
                    ViewBag.FooterID = pageHeader.FooterLinksID;
                }
            }
        }

        protected AreaKind AreaKind
        {
            get { return Area.ID; }
            set
            {
                Area = DbSession.Get<Area>(value);
                ViewBag.FooterID = Area.FooterLinksID;
            }
        }

        public ActionResult Search(string q)
        {
            const string apiKey = "AIzaSyClPcof_cL9nwRWDCgbCntJA5t1PPEwWzY";
            const string cx = "012086554440813063826:svstp_wt1ea";
            var model = new SearchModel { Query = q };

            if (!String.IsNullOrWhiteSpace(q))
            {
                try
                {
                    var svc = new CustomsearchService(new BaseClientService.Initializer { ApiKey = apiKey });
                    var listRequest = svc.Cse.List(q);
                    listRequest.Cx = cx;

                    model.Results = listRequest.Execute();
                }
                catch (Exception ex)
                {
                    Global.Logger.Error("Error in custom search for q='" + q + "'", ex);
                }
            }

            return View(model);
        }

        public ISession DbSession
        {
            get { return HttpContext.GetDbSession(); }
        }

        public ITransaction DbTransaction
        {
            get { return HttpContext.GetDbTransaction(); }
        }

        public ActionResult Xml(object obj)
        {
            var serializer = new DataContractSerializer(obj.GetType());
            var sb = new StringBuilder();
            using (var stream = new StringWriter(sb))
            {
                using (var writer = XmlWriter.Create(stream))
                {
                    serializer.WriteObject(writer, obj);
                }
            }
            return Content(sb.ToString(), "text/xml");
        }

        public bool IsAdmin
        {
            get { return HttpContext.IsAdmin(); }
        }

        public bool IsCustomer
        {
            get { return CustomerId != null; }
        }

        public Guid? CustomerId
        {
            get { return HttpContext.GetCustomerId(); }
        }

        public string UserId
        {
            get { return HttpContext.GetUserId(); }
        }

        public void SetAuthCookie(Guid customerId, bool persistant)
        {
            var model = new UserNameModel();
            model.UserId = UserId;
            model.CustomerId = customerId.ToString();
            FormsAuthentication.SetAuthCookie(System.Web.Helpers.Json.Encode(model), persistant);
        }

        public void SetAuthCookie(string userid, bool persistant)
        {
            var model = new UserNameModel();
            model.UserId = userid;
            model.CustomerId = CustomerId.ToString();
            FormsAuthentication.SetAuthCookie(System.Web.Helpers.Json.Encode(model), persistant);
        }

        public void SignOutCustomer()
        {
            if (UserId != null)
            {
                var model = new UserNameModel();
                model.UserId = UserId;
                model.CustomerId = null;
                FormsAuthentication.SetAuthCookie(System.Web.Helpers.Json.Encode(model), false);
            }
            else
            {
                FormsAuthentication.SignOut();
            }
        }

        public void SignOutUser()
        {
            if (CustomerId.HasValue)
            {
                var model = new UserNameModel();
                model.UserId = null;
                model.CustomerId = CustomerId.ToString();
                FormsAuthentication.SetAuthCookie(System.Web.Helpers.Json.Encode(model), false);
            }
            else
            {
                FormsAuthentication.SignOut();
            }
        }

        public IList<TagCategory> TagCategories
        {
            get { return DbSession.QueryOver<TagCategory>().OrderBy(tc => tc.Inx).Asc.Cacheable().CacheMode(CacheMode.Normal).CacheRegion("tags").List(); }
        }

        public virtual string DefaultAction
        {
            get { return null; }
        }

        public virtual ActionResult _fallback(string id)
        {
            if (DefaultAction == null)
            {
                return HttpNotFound();
            }
            RouteData.Values["action"] = DefaultAction;
            return new RedirectToRouteResult(null, RouteData.Values, true);
        }

        protected StandardPage FindStandardPage(string url)
        {
            return DbSession.QueryOver<Page>().Where(p => p.Url == url && (p.Area.ID == AreaKind.General || p.Area.ID == AreaKind)).Cacheable().CacheMode(CacheMode.Normal).SingleOrDefault() as StandardPage;
        }

        public ActionResult JsonDataSet(ICollection collection)
        {
            return JsonDataSet(collection, JsonRequestBehavior.DenyGet);
        }

        public ActionResult JsonDataSet(ICollection collection, JsonRequestBehavior jsonRequestBehavior)
        {
            return Json(new { d = new { results = collection, __count = collection.Count } }, jsonRequestBehavior);
        }

        public ActionResult Dialog(string body)
        {
            return Dialog(body, true);
        }

        public ActionResult Dialog(string body, bool closeable)
        {
            return Json(new { __kind__ = 1, body, closeable });
        }
		 public ActionResult DialogRedirect(string body, bool closeable, string location)
        {
            return Json(new { __kind__ = 1302, body, closeable, location });
        }
        public ActionResult ValidationErrors()
        {
            var dict = new Dictionary<string, List<string>>();
            var general = new List<string>();
            foreach (var state in ModelState)
            {
                if (String.IsNullOrWhiteSpace(state.Key))
                {
                    general.AddRange(state.Value.Errors.Select(e => e.ErrorMessage));
                }
                else
                {
                    foreach (var error in state.Value.Errors)
                    {
                        if (dict.ContainsKey(state.Key))
                        {
                            dict[state.Key].Add(error.ErrorMessage);
                        }
                        else
                        {
                            dict.Add(state.Key, new List<string>(new[] { error.ErrorMessage }));
                        }
                    }
                }
            }
            return Json(new { __kind__ = 11, errors = dict, general });
        }

        protected IQuery CreateTagsQuery<T>(IEnumerable<Tag> tags)
        {
            var tagProperty = typeof(T).Name;
            var sb = new StringBuilder(1000);
            var dict = new Dictionary<int, object>();
            var f1 = true;
            foreach (var gs in tags.GroupBy(t => t.TagCategory))
            {
                var lsb = new StringBuilder(100);
                lsb.AppendFormat("exists(from {0} p1 join p1.Tags t where (p1 = p and (", tagProperty);
                var f2 = true;
                foreach (var tag in gs)
                {
                    lsb.AppendFormat("{1}t.ID = :p{0}", dict.Count, f2 ? "" : " or ");
                    dict.Add(dict.Count, tag.ID);
                    f2 = false;
                }

                lsb.Append(")))");

                if (!f2)
                {
                    sb.AppendFormat("{1} ({0})", lsb, f1 ? "" : " and ");
                }
                f1 = false;
            }

            if (typeof(Page).IsAssignableFrom(typeof(T)))
            {
                // Pages, Articles, etc - limit by area
                if (AreaKind > AreaKind.General)
                {
                    sb.AppendFormat("{0} (p.Area.ID = :p{1})", f1 ? "" : " and ", dict.Count);
                    dict.Add(dict.Count, AreaKind);
                }
            }
            else
            {
                // Gallery images only if has any tags
                sb.AppendFormat("{0} (exists(from {1} p1 join p1.Tags t where p1 = p))", f1 ? "" : " and ", tagProperty);
            }

            const string HQL = @"select distinct p
                                 from {0} p
                                 where {1}";

            var q = String.Format(HQL, tagProperty, sb);
            var query = DbSession.CreateQuery(q);
            foreach (var kv in dict)
            {
                query = query.SetParameter("p" + kv.Key, kv.Value);
            }
            return query.SetCacheable(true).SetCacheMode(CacheMode.Normal);
        }

        protected Tag AreaKindToTag(AreaKind areaKind)
        {
            switch (areaKind)
            {
                case AreaKind.Juliettes:
                    return DbSession.Get<Tag>(new Guid("ef95489c-09c7-41f2-be1a-a211012b2d9a"));
                case AreaKind.Balustrades:
                    return DbSession.Get<Tag>(new Guid("a2b2b9a5-6c85-49e1-94fb-a211012b42f4"));
                case AreaKind.CurvedDoors:
                    return DbSession.Get<Tag>(new Guid("53c8fe3f-46c1-4c13-9543-a211012b562b"));
                case AreaKind.Balconano:
                    return DbSession.Get<Tag>(new Guid("b0796cd9-941f-4c4d-999a-a211012b6dc8"));
                case AreaKind.Decking:
                    return DbSession.Get<Tag>(new Guid("cdd6dbba-be39-4c01-9bfe-a211012b88d7"));
                case AreaKind.BalconyViews:
                    return DbSession.Get<Tag>(new Guid("fd2f543a-fa91-4791-bc27-a211012ba1ca"));
                default:
                    return null;
            }
        }

        public Tag AreaTag
        {
            get { return AreaKindToTag(AreaKind); }
        }

        protected CartItem AddToCart(ProductDetails product, double quantity, double? price = null)
        {
            var cartItems = HttpContext.GetCartItems();
            var res = cartItems.ToLookup(ci => ci.ProductDetails, ci => ci, ProductDetails.PhysicalComparer)[product].ToList();
            if (res.Count > 0)
            {
                var item = res[0];
                item.Quantity += quantity;
                DbSession.SaveOrUpdate(item);
                return item;
            }
            else
            {
                var item = new CartItem();
                item.AppId = WebGlobal.AppId;
                item.SessionID = WebGlobal.GetSessionCookie(System.Web.HttpContext.Current);
                item.Name = product.Name;
                item.Price = price ?? product.SellingPrice ?? 0D;
                item.ProductDetails = product;
                item.Quantity = quantity;
                DbSession.SaveOrUpdate(item);
                HttpContext.ResetCartCount();
                return item;
            }
        }

        [NoCache]
        public ActionResult Photos(string t, string tc)
        {
            var model = new IndexModel<GalleryImage>();
            model.AreaKind = AreaKind;
            model.HideFilterBar = GetHideTop();
            model.Tags = GetTags(t, tc);
            model.TagCategories = DbSession.Get<Area>(AreaKind).PhotoTags.OrderBy(tag => tag.Inx).GroupBy(tag => tag.TagCategory).OrderBy(g => g.Key.Inx);

            model.Results = CreateTagsQuery<GalleryImage>(model.Tags).List<GalleryImage>();

            PageHeader = Area.PhotosPageHeader;
            model.Body = Area.PhotosBody;

            return View("Photos", model);
        }

        [HttpPost]
        public ActionResult GetPhotos(AreaKind? area)
        {
            var tags = GetTags(area);
            IList<GalleryImage> results = new List<GalleryImage>();
            if (tags.Any())
                results = CreateTagsQuery<GalleryImage>(tags).List<GalleryImage>();
            return Json(results);
        }

        [NoCache]
        public ActionResult Downloads(string t, string tc)
        {
            var model = new IndexModel<UploadedFile>();
            model.AreaKind = AreaKind;
            model.HideFilterBar = GetHideTop();
            model.Tags = GetTags(t, tc);
            model.TagCategories = DbSession.Get<Area>(AreaKind).DownloadTags.OrderBy(tag => tag.Inx).GroupBy(tag => tag.TagCategory).OrderBy(g => g.Key.Inx);

            model.Results = CreateTagsQuery<UploadedFile>(model.Tags).List<UploadedFile>();

            PageHeader = Area.DownloadsPageHeader;
            ViewBag.Body = Area.DownloadsBody ?? "";

            return View("Downloads", model);
        }

        [HttpPost]
        public ActionResult GetDownloads(AreaKind? area)
        {
            var tags = GetTags(area);
            IList<UploadedFile> results = new List<UploadedFile>();
            if (tags.Any())
                results = CreateTagsQuery<UploadedFile>(tags).List<UploadedFile>();
            return Json(results);
        }

        [NoCache]
        public ActionResult Articles(string id, string t, string tc)
        {
            if (String.IsNullOrEmpty(id))
            {
                var model = new IndexModel<Article>();
                model.AreaKind = AreaKind;
                model.HideFilterBar = GetHideTop();
                model.Tags = GetTags(t, tc);
                model.TagCategories = DbSession.Get<Area>(AreaKind).ArticleTags.OrderBy(tag => tag.Inx).GroupBy(tag => tag.TagCategory).OrderBy(g => g.Key.Inx);
                model.Results = CreateTagsQuery<Article>(model.Tags).List<Article>().OrderByDescending(p => p.Inx);

                PageHeader = Area.ArticlesPageHeader;
                ViewBag.Body = Area.ArticlesBody ?? "";

                return View("Articles", model);
            }

            var page = DbSession.QueryOver<Article>().Where(p => p.Url == id && p.Area.ID == AreaKind).Cacheable().CacheMode(CacheMode.Normal).SingleOrDefault();
            if (page == null)
                return HttpNotFound();

            PageHeader = page;

            return View("Article", page);
        }

        [HttpPost]
        public ActionResult GetArticles()
        {
            var tags = GetTags();
            var results = CreateTagsQuery<Article>(tags).List<Article>().OrderByDescending(p => p.Inx);
            var urlHelper = new UrlHelper(Request.RequestContext);
            return Json(results.Select(a => new
            {
                a.ID, a.Image, 
                a.ThumbTitleDisplay, 
                a.ThumbDescriptionDisplay, 
                Url = urlHelper.Action("articles", a.Area.ID.ToString(), new { id = a.Url })
            }));
        }

        [NoCache]
        [ActionName("case-studies")]
        public ActionResult CaseStudies(string id, string t, string tc)
        {
            if (String.IsNullOrEmpty(id))
            {
                var model = new IndexModel<CaseStudy>();
                model.AreaKind = AreaKind;
                model.HideFilterBar = GetHideTop();
                model.Tags = GetTags(t, tc);
                model.TagCategories = DbSession.Get<Area>(AreaKind).CaseStudyTags.OrderBy(tag => tag.Inx).GroupBy(tag => tag.TagCategory).OrderBy(g => g.Key.Inx);
                model.Results = CreateTagsQuery<CaseStudy>(model.Tags).List<CaseStudy>().OrderByDescending(p => p.Inx);

                PageHeader = Area.CaseStudiesPageHeader;
                ViewBag.Body = Area.CaseStudiesBody ?? "";

                return View("CaseStudies", model);
            }
            var page = DbSession.QueryOver<CaseStudy>().Where(p => p.Url == id && p.Area.ID == AreaKind).Cacheable().CacheMode(CacheMode.Normal).SingleOrDefault();

            if (page == null)
                return HttpNotFound();

            PageHeader = page;

            return View("CaseStudy", page);
        }

        [HttpPost]
        public ActionResult GetCaseStudies()
        {
            var tags = GetTags();
            var results = CreateTagsQuery<CaseStudy>(tags).List<CaseStudy>().OrderByDescending(p => p.Inx);
            var urlHelper = new UrlHelper(Request.RequestContext);
            return Json(results.Select(a => new
            {
                a.ID, 
                a.Image, 
                a.ThumbTitleDisplay, 
                a.ThumbDescriptionDisplay,
                Url = urlHelper.Action("case-studies", a.Area.ID.ToString(), new { id = a.Url })
            }));
        }

        [NoCache]
        [ActionName("customer-reviews")]
        public ActionResult CustomerReviews(string id, string t, string tc)
        {
            if (String.IsNullOrEmpty(id))
            {
                var model = new IndexModel<CustomerReview>();
                model.AreaKind = AreaKind;
                model.HideFilterBar = GetHideTop();
                model.Tags = GetTags(t, tc);
                model.TagCategories = DbSession.Get<Area>(AreaKind).CustomerReviewTags.OrderBy(tag => tag.Inx).GroupBy(tag => tag.TagCategory).OrderBy(g => g.Key.Inx);

                model.Results = CreateTagsQuery<CustomerReview>(model.Tags).List<CustomerReview>().OrderByDescending(p => p.Inx);

                PageHeader = Area.CustomerReviewsPageHeader;
                ViewBag.Body = Area.CustomerReviewsBody ?? "";

                return View("CustomerReviewsIndex", model);
            }

            var page = DbSession.QueryOver<CustomerReview>().Where(p => p.Url == id && p.Area.ID == AreaKind).Cacheable().CacheMode(CacheMode.Normal).SingleOrDefault();

            if (page == null)
                return HttpNotFound();

            PageHeader = page;

            return View("CustomerReview", page);
        }

        [HttpPost]
        public ActionResult GetCustomerReviews()
        {
            var tags = GetTags();
            var results = CreateTagsQuery<CustomerReview>(tags).List<CustomerReview>().OrderByDescending(p => p.Inx);
            var urlHelper = new UrlHelper(Request.RequestContext);
            return Json(results.Select(a => new
            {
                a.ID, 
                a.Image, 
                a.ThumbTitleDisplay, 
                a.ThumbDescriptionDisplay,
                Url = urlHelper.Action("customer-reviews", a.Area.ID.ToString(), new { id = a.Url })
            }));
        }

        protected bool GetHideTop()
        {
            return Request.Url != null && Request.Url.Query.IndexOf("hidetop", StringComparison.OrdinalIgnoreCase) >= 0;
            ;
        }

        protected ICollection<Tag> GetTags(AreaKind? area = null)
        {
            var tags = new List<Tag>();
            var keys = Request.Form.AllKeys.Where(k => k.StartsWith("chb_"));
            foreach (var key in keys)
            {
                var strs = key.Split(new[] { '_' }, StringSplitOptions.RemoveEmptyEntries);
                Guid tagid;
                if (strs.Length < 2 || !Guid.TryParse(strs[1], out tagid)) continue;
                var tag = DbSession.Get<Tag>(tagid);
                if (tag == null) continue;
                tags.Add(tag);
            }
            if (area.HasValue)
            {
                var areatag = AreaKindToTag(area.Value);
                if (areatag != null && !tags.Contains(areatag))
                {
                    tags.Add(areatag);
                }
            }
            return tags;
        }

        protected ICollection<Tag> GetTags(string t, string tc)
        {
            var results = new HashSet<Tag>();
            var tags = new HashSet<Guid>(DbSession.GetAll<Tag>(true).Select(tg => tg.ID));

            if (t != null)
            {
                var strs = t.Split(";".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
                foreach (var str in strs)
                {
                    Guid tagId;
                    if (!Guid.TryParse(str, out tagId)) continue;
                    if (!tags.Contains(tagId)) continue;
                    results.Add(DbSession.Get<Tag>(tagId));
                }
            }
            if (tc != null)
            {
                var strs = tc.Split(";".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
                foreach (var str in strs)
                {
                    Guid tcId;
                    if (!Guid.TryParse(str, out tcId)) continue;
                    var cat = DbSession.Get<TagCategory>(tcId);
                    if (cat == null) continue;
                    foreach (var tag in cat.Tags)
                    {
                        if (results.Contains(tag)) continue;
                        results.Add(tag);
                    }
                }
            }

            var areatag = AreaTag;
            if (areatag != null && !results.Contains(areatag))
            {
                results.Add(areatag);
            }

            return results;
        }

        protected string AccessoryKindId = null;

        public ActionResult Shop()
        {
            if (AccessoryKindId == null)
                return HttpNotFound();

            var products = DbSession.QueryOver<AccessoryTypeLocal>().Where(at => at.AccessoryKind.ID == AccessoryKindId && at.OnlineVisible).OrderBy(at => at.Inx).Asc.Cacheable().CacheMode(CacheMode.Normal).List();

            ViewBag.Body = StandardPageObj != null ? StandardPageObj.Body : "";

            return View("Shop", products);
        }

        [TransactionScope]
        [ActionName("add-to-cart")]
        [HttpPost]
        public ActionResult AddToCart(string id, int quantity = 1)
        {
            var acc = new Accessory();
            acc.AccessoryType = DbSession.Get<AccessoryTypeLocal>(id);
            if (acc.AccessoryType == null)
                return HttpNotFound();

            acc.Color = DbSession.Get<ColorLocal>(0);
            DbSession.SaveOrUpdate(acc);

            AddToCart(acc, quantity);

            DbSession.Flush();

            return RedirectToAction("cart", "customer", new { areas = AreaKind });
        }

        protected ActionResult GetCustomerDto(string pageId, CustomerDto model)
        {
            var page = DbSession.Get<StandardPage>(new Guid(pageId));
            ViewBag.Body = page.Body ?? "";
            ViewBag.Name = page.Name ?? "";
            PageHeader = page;
            return View(model);
        }

        protected Customer CreateNewCustomer()
        {
            var customer = new Customer(DbSession.CurrentUser());

            var source = GetSource();
            customer.CustomerSource = source.Item1;
            customer.CustomerSubSource = source.Item2;

            return customer;
        }

        protected Customer SaveCustomerDto(CustomerDto model, string subject, int eventTypeId, string notes = "", Event.EventStatus eventStatus = Event.EventStatus.Open, bool validateModel = true)
        {
            
            var customer = DbSession.GetCustomerByEmail(model.Email1);
            var newcustomer = customer == null;
            if (customer == null)
            {
                customer = CreateNewCustomer();

                customer.EmailAddresses.Add(new CustomerEmailAddress { EmailAddress = model.Email1, Customer = customer });

                customer.DefaultContact.Title = model.Title ?? "";
                customer.DefaultContact.FirstName = model.FirstName;
                customer.DefaultContact.LastName = model.LastName;
                customer.DefaultContact.Email = model.Email1;

                customer.Name = String.IsNullOrWhiteSpace(model.CompanyName) ? customer.DefaultContact.FullName : model.CompanyName;

                DbSession.SaveOrUpdate(customer);

                DbSession.SaveOrUpdate(new Event
                {
                    EventType = DbSession.Get<EventType>(1), Name = "New Customer", Status = Event.EventStatus.Final, Customer = customer, User = DbSession.CurrentUser(), RefID = customer.ID
                });
            }

            model.UpdateCustomer(DbSession, customer);


            DbSession.SaveOrUpdate(new Event
            {
                EventType = DbSession.Get<EventType>(eventTypeId), Name = subject, Status = eventStatus, Customer = customer, User = DbSession.CurrentUser(), RefID = customer.ID, Notes = notes
            });

            DbSession.Flush();
            if (newcustomer)
            {
                customer.SetNumber();
                DbSession.Flush();
            }
            return customer;
        }

        protected Customer CreateFastCustomer(ISession sess, string email, string firstName, string lastName, string phone = null)
        {
            var cus = CreateNewCustomer();
            cus.Name = firstName + " " + lastName;

            var contact = cus.RawCustomerContacts[0];
            contact.FirstName = firstName;
            contact.LastName = lastName;
            contact.PrimaryPhone = phone ?? "";
            contact.Email = email;
            cus.RawEmailAddresses.Add(new CustomerEmailAddress { Customer = cus, EmailAddress = email });
            sess.SaveOrUpdate(cus);
            sess.Flush();
            cus.SetNumber();
            sess.Flush();

            var nce = new Event();
            nce.Customer = cus;
            nce.EventType = sess.Get<EventType>(1);
            nce.User = DbSession.CurrentUser();
            nce.Name = "New Customer";
            nce.RefID = cus.ID;
            nce.Status = Event.EventStatus.Open;
            sess.SaveOrUpdate(nce);
            sess.Flush();

            return cus;
        }

        protected bool ValidateCaptcha()
        {
            using (var client = new HttpClient())
            {
                using (var form = new FormUrlEncodedContent(new Dictionary<string, string>
                {
                    { "secret", "6LcTgyMTAAAAALZfig5GfrTJmM-jvsVtuSyLRGPf" },
                    { "response", Request.Form["g-recaptcha-response"] }
                }))
                {
                    var response = client.PostAsync("https://www.google.com/recaptcha/api/siteverify", form).Result;
                    if (response.IsSuccessStatusCode)
                    {

                        var body = response.Content.ReadAsStringAsync().Result;
                        var result = JsonConvert.DeserializeObject<Dictionary<string, object>>(body);
                        if (Convert.ToBoolean(result["success"]))
                        {
                            return true;
                        }

                    }
                }
                return false;
            }
        }
    }
}