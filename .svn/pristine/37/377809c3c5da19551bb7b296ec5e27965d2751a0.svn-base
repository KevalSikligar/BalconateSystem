using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Core.Services.TemplateService;
using Balcony.Miracle.Web.Cms;
using Balcony.Miracle.Web.Models;
using Balcony.Miracle.Web.Shared;
using NHibernate;

namespace Balcony.Miracle.Web.Controllers {

    public class JuliettesController : BaseController {
        
        private const string QUOTE_CUSTOM_PAGE_ID = "6b7844bb-e492-4e99-9ad9-a2770131938c";
        private const string FIND_SIZE_ID = "0b9dc447-be03-453a-ba60-a2d3011125c3";

        public JuliettesController() :
            base(AreaKind.Juliettes) {
        }

        public override string DefaultAction {
            get {
                return "homepage";
            }
        }

        public ActionResult Homepage() {
            return View(Area);
        }


        [SessionScope]
        public ActionResult Quote() {
            return RedirectToAction("quote-custom");
        }

        [SessionScope]
        [ActionName("juliet-quote-success")]
        public ActionResult JulieteQuoteSuccess(Guid? id)
        {
            return QuoteSuccess(id, "juliet-quote-success");
        }

        [SessionScope]
        [ActionName("quote-custom")]
        public ActionResult QuoteCustom(int? id, int? type, int? color, int? glass) {
            var page = DbSession.Get<StandardPage>(new Guid(QUOTE_CUSTOM_PAGE_ID));
            PageHeader = page;

            var jtype = DbSession.Get<JulietteType>(type.HasValue ? type.Value : 2);

            var viewModel = new CustomJulietteQuoteModel(page, jtype);

            viewModel.Width = id.HasValue ? id.Value : (int?)null;
            viewModel.ColorId = color.HasValue ? color.Value : 1;
            viewModel.GlassId = glass.HasValue ? glass.Value : 1;

            return View(viewModel);
        }


        [HttpPost]
        [SessionScope]
        [ActionName("quote-custom")]
        public ActionResult QuoteCustom(CustomJulietteQuoteModel model)
        {
            var juliette = new Juliette();
            juliette.Color = DbSession.Get<ColorLocal>(model.ColorId);
            juliette.GlassSystem = DbSession.Get<GlassSystemLocal>(model.GlassId);
            juliette.JulietteType = DbSession.Get<JulietteType>(model.TypeId);
            juliette.OpenWidth = model.Width.Value;
            juliette.GlassQuantity = juliette.CalcGlassQuantity();

            var line = new QuoteLine();
            line.Name = juliette.Name;
            line.Price = juliette.SilverSellingPrice;
            line.BronzePrice = juliette.BronzeSellingPrice;
            line.GoldPrice = juliette.GoldSellingPrice;

            line.ProductDetails = juliette;
            Session[SessionKeys.PENDING_QUOTE_LINE] = line;
            return RedirectToAction("create-quote", "customer", new { areas = AreaKind });
        }
        

        [SessionScope]
        [ActionName("amend-quote")]
        public ActionResult AmendQuote(Guid? id) {
            Quote quote;
            if (!id.HasValue ||
                (quote = DbSession.Get<Quote>(id.Value)) == null ||
                quote.FirstLine == null) {
                return HttpNotFound();
            }
            var jul = quote.FirstLine.ProductDetails as Juliette;
            if (jul == null) {
                return HttpNotFound();
            }
            var page = DbSession.Get<StandardPage>(new Guid(QUOTE_CUSTOM_PAGE_ID));
            var viewmodel = new CustomJulietteQuoteModel(page, jul);
            return View("quote-custom", viewmodel);
        }


        [SessionScope]
        [ActionName("standard-models")]
        public ActionResult StandardModels() {
            var page = DbSession.Get<StandardPage>(new Guid("80899b74-84a4-424c-b6e4-a2c501209d2f"));
            ViewBag.Body = page.Body;
            PageHeader = page;

            var jtypes = DbSession.QueryOver<JulietteType>()
                .Where(jt => jt.WebsiteVisible)
                .OrderBy(jt => jt.StandardPriceFactor).Asc
                .Cacheable()
                .CacheMode(CacheMode.Normal)
                .List();
         
            var standards = DbSession.QueryOver<JulietteStandard>()
                .OrderBy(js => js.ID).Asc
                .Cacheable()
                .CacheMode(CacheMode.Normal)
                .List();

         

            var models = standards.Select(std =>
            {
                var jtype = jtypes
                    .Where(jt => jt.MinWidth <= std.ID && std.ID <= jt.MaxWidth)
                    .OrderBy(jt =>
                    {
                        var c1 = jt.Colors
                            .Where(c => c.WebsiteVisible)
                            .OrderBy(c => c.JuliettePrice)
                            .First();

                        var g1 = jt.GlassSystems
                            .Where(c => c.WebsiteVisible)
                            .OrderBy(c => c.JuliettePrice)
                            .First();

                        return jt.StandardPriceFactor * c1.JuliettePrice * g1.JuliettePrice;
                    })
                    .First();

                var color = jtype.Colors
                    .Where(c => c.WebsiteVisible)
                    .OrderBy(c => c.JuliettePrice)
                    .First();

                var glass = jtype.GlassSystems
                    .Where(c => c.WebsiteVisible)
                    .OrderBy(c => c.JuliettePrice)
                    .First();

                return new Juliette
                {
                    JulietteType = jtype,
                    JulietteStandard = std,
                    Color = color,
                    GlassSystem = glass
                };

            }).ToList();

            return View(models);
        }


        private StandardJulietteModel GetStandardModel(int id, int type, int? color, int? glass, bool vat) {
            var t = DbSession.Get<JulietteType>(type);
            var standards = DbSession.QueryOver<JulietteStandard>().OrderBy(s => s.ID).Asc.List();
            var standard = standards.FirstOrDefault(s => s.ID == id && t.MinWidth <= s.ID && s.ID <= t.MaxWidth) ?? standards.FirstOrDefault(s => t.MinWidth <= s.ID && s.ID <= t.MaxWidth);
            var c = t.Colors.FirstOrDefault(cl => cl.ID == color && cl.WebsiteVisible) ?? t.Colors.FirstOrDefault(cl => cl.WebsiteVisible);
            var g = t.GlassSystems.FirstOrDefault(gl => gl.ID == glass && gl.WebsiteVisible) ?? t.GlassSystems.FirstOrDefault(gl => gl.WebsiteVisible);

            if (standard == null || c == null)
                return null;

            var jul = new Juliette {
                JulietteType = t,
                JulietteStandard = standard,
                Color = c,
                GlassSystem = g
            };

            var vatPercent = vat ? DbSession.CurrentCompany().VatPercent : (double?) null;
            return new StandardJulietteModel(jul, vatPercent);
        }


        [SessionScope]
        [ActionName("standard-model-ajax")]
        public ActionResult StandardModelAjax(int? id, int? type, int? color, int? glass, bool vat = false)
        {
            if (!id.HasValue || !type.HasValue || !color.HasValue || !glass.HasValue)
                return RedirectToActionPermanent(DefaultAction);

            var model = GetStandardModel(id.Value, type.Value, color.Value, glass.Value, vat);
            if (model == null)
                return HttpNotFound();

            return View("StandardDetails", model);
        }


        [SessionScope]
        [ActionName("standard-model")]
        public ActionResult StandardModel(int id, int type, int color, int? glass, bool vat = false) {
            var model = GetStandardModel(id, type, color, glass, vat);
            if (model == null)
                return HttpNotFound();

            PageHeader = model;

            return View(model);
        }


        [HttpPost]
        [TransactionScope]
        [ActionName("standard-model")]
        public ActionResult StandardModel(StandardJulietteModel model) {
            var standard = DbSession.Get<JulietteStandard>(model.StandardId);
            var type = DbSession.Get<JulietteType>(model.TypeId);
            var color = DbSession.Get<ColorLocal>(model.ColorId);
            var glass = DbSession.Get<GlassSystemLocal>(model.GlassId);
            
            var juliette = new Juliette();
            juliette.Color = color;
            juliette.GlassSystem = glass;
            juliette.JulietteType = type;
            juliette.JulietteStandard = standard;
            DbSession.SaveOrUpdate(juliette);

            AddToCart(juliette, model.Quantity);

            DbSession.Flush();

            return RedirectToAction("cart", "customer");
        }


        [SessionScope]
        [ActionName("find-size")]
        public ActionResult FindSize() {
            var page = DbSession.Get<StandardPage>(new Guid(FIND_SIZE_ID));
            PageHeader = page;
            ViewBag.Body = page.Body;
            ViewBag.Types = FetchTypes();

            ViewBag.Standards = DbSession.QueryOver<JulietteStandard>()
                .OrderBy(js => js.ID).Asc
                .Cacheable()
                .CacheMode(CacheMode.Normal)
                .List()
                .Select(s => s.ID);

            var jtype = DbSession.Get<JulietteType>(1);

            var viewModel = new CustomJulietteQuoteModel(page, jtype);
            viewModel.ColorId = jtype.Colors.First().ID;
            viewModel.MinWidth = (int)Config.One.Jul_CustomMinWidth;
            viewModel.MaxWidth = (int)Config.One.Jul_CustomMaxWidth;
            
            return View(viewModel);
        }


        [HttpPost]
        [SessionScope]
        [ActionName("find-size")]
        public ActionResult FindSize(CustomJulietteQuoteModel model, string cmd) {
            if (ModelState.IsValid && model.Width.HasValue) {
                if (cmd != null && cmd.IndexOf("standard", StringComparison.OrdinalIgnoreCase) >= 0) {
                    var type = DbSession.Get<JulietteType>(model.TypeId);

                    int w;
                    if (model.Width <= type.WidthStep - type.AppendToHandrail1)
                    {
                        w = model.Width.Value + type.AppendToHandrail1;
                    }
                    else
                    {
                        w = model.Width.Value + type.AppendToHandrail2;
                    }

                    var standard = DbSession.QueryOver<JulietteStandard>()
                        .Where(js => w <= js.ID && js.ID <= type.MaxWidth)
                        .OrderBy(js => js.ID).Asc
                        .Cacheable()
                        .CacheMode(CacheMode.Normal)
                        .List()
                        .FirstOrDefault();

                    if (standard != null)
                    {
                        return RedirectToAction("standard-model", new { id = standard.ID, type = model.TypeId, color = model.ColorId });
                    }
                }
                return RedirectToAction("quote-custom", new { id = model.Width, type = model.TypeId, color = model.ColorId });                
            }
            return RedirectToAction("find-size");
        }











        [Jsonp]
        public ActionResult GetStandards() {
            var filter = Request.QueryString["$filter"];
            var strs = filter != null ? filter.Split("eq".ToCharArray(), StringSplitOptions.RemoveEmptyEntries) : new string[0];
            
            int jtid;
            IList<JulietteStandard> list;
            JulietteType jt;

            if (strs.Length > 1 && Int32.TryParse(strs[1], out jtid) &&
                    (jt = DbSession.Get<JulietteType>(jtid)) != null) {
                list = DbSession.QueryOver<JulietteStandard>().Where(s => jt.MinWidth <= s.ID && s.ID <= jt.MaxWidth).OrderBy(c => c.ID).Asc.List();
            } else {
                list = DbSession.QueryOver<JulietteStandard>().OrderBy(c => c.ID).Asc.List();
            }
            return JsonDataSet(list.Select(r => new { r.ID, Name = r.ID }).ToList(), JsonRequestBehavior.AllowGet);
        }

        private IEnumerable<JulietteType> FetchTypes() {
            return DbSession.QueryOver<JulietteType>()
                .Where(c => c.WebsiteVisible)
                .OrderBy(c => c.Inx)
                .Asc
                .Cacheable()
                .CacheMode(CacheMode.Normal)
                .List();
        }

        [Jsonp]
        public ActionResult GetTypes() {
            var res = FetchTypes()
                .Select(bs => new { bs.ID, bs.Name, bs.MinWidth, MaxWidth = bs.MaxWidth - bs.AppendToHandrail2 })
                .ToList();
            return JsonDataSet(res, JsonRequestBehavior.AllowGet);
        }

        [Jsonp]
        public ActionResult GetStandardGlasses() {
            var filter = Request.QueryString["$filter"];
            var strs = filter?.Split("eq".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
            int bsid;
            IList<GlassSystemLocal> list;
            JulietteType jt;
            if (strs != null && strs.Length > 1 && Int32.TryParse(strs[1], out bsid) &&
                (jt = DbSession.Get<JulietteType>(bsid)) != null)
            {
                list = jt.GlassSystems;
            }
            else
            {
                list = DbSession.QueryOver<GlassSystemLocal>().OrderBy(c => c.Inx).Asc.List();
            }

            return JsonDataSet(list.Where(c => c.WebsiteVisible).Select(r => new { r.ID, Name = r.Name_En }).ToList(), JsonRequestBehavior.AllowGet);
        }

        [Jsonp]
        public ActionResult GetColors()
        {
            var filter = Request.QueryString["$filter"];
            var strs = filter?.Split("eq".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
            int bsid;
            IList<ColorLocal> list;
            JulietteType jt;
            if (strs != null && strs.Length > 1 && Int32.TryParse(strs[1], out bsid) &&
                (jt = DbSession.Get<JulietteType>(bsid)) != null)
            {
                list = jt.Colors;
            }
            else
            {
                list = DbSession.QueryOver<ColorLocal>().OrderBy(c => c.Inx).Asc.List();
            }

            return JsonDataSet(list.Where(c => c.WebsiteVisible).Select(r => new { r.ID, Name = r.Name_En }).ToList(), JsonRequestBehavior.AllowGet);
        }

        [Jsonp]
        public ActionResult GetCustomGlasses() {
            var filter = Request.QueryString["$filter"];
            var strs = filter?.Split("eq".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
            int bsid;
            IList<GlassSystemLocal> list;
            JulietteType jt;
            if (strs != null && strs.Length > 1 && Int32.TryParse(strs[1], out bsid) &&
                (jt = DbSession.Get<JulietteType>(bsid)) != null)
            {
                list = jt.CustomGlassSystems;
            }
            else
            {
                list = DbSession.QueryOver<GlassSystemLocal>().OrderBy(c => c.Inx).Asc.List();
            }

            return JsonDataSet(list.Where(c => c.WebsiteVisible).Select(r => new { r.ID, Name = r.Name_En }).ToList(), JsonRequestBehavior.AllowGet);
        }
    }
}