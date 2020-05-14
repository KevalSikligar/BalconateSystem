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

    
    public class CurvedDoorsController : BaseController {

        public const int DEFAULT_SYSTEM_ID = 3;
        
        public CurvedDoorsController() :
            base(AreaKind.CurvedDoors) {
        }

        public override string DefaultAction {
            get {
                return "homepage";
            }
        }

        public ActionResult Homepage() {
            return View(Area);
        }

        [ActionName("curved-patio-door-quote-success")]
        public ActionResult CurvedDoorQuoteSuccess(Guid? id)
        {
            return QuoteSuccess(id, "curved-patio-door-quote-success");
        }

        [SessionScope]
        public ActionResult Quote(string id) {
            if (String.IsNullOrWhiteSpace(id)) {
                var page = DbSession.Get<StandardPage>(new Guid("5e518d44-d714-46c3-a1fb-a2e700d785e7"));
                ViewBag.Body = page.Body;
                ViewBag.Name = page.Name;
                PageHeader = page;
                return View(DbSession.QueryOver<CurvedDoorModelLocal>()
                    .Where(m => m.CurvedDoorSystem.ID == DEFAULT_SYSTEM_ID)
                    .OrderBy(m => m.SType1)
                    .Asc
                    .Cacheable()
                    .CacheMode(CacheMode.Normal)
                    .List());
            }


            CurvedDoorQuoteModel viewModel;

            var fromSession = HttpContext.GetSessionValue<CurvedDoorQuoteModel>(SessionKeys.LAST_QUOTE);
            if (fromSession != null && String.Equals(fromSession.CurvedDoorModelShortName, id.Trim(), StringComparison.OrdinalIgnoreCase)) {
                viewModel = fromSession;
            } else {
                var model = DbSession.QueryOver<CurvedDoorModelLocal>()
                    .Where(m => m.CurvedDoorSystem.ID == DEFAULT_SYSTEM_ID && m.ShortName_En == id)
                    .Cacheable()
                    .CacheMode(CacheMode.Normal)
                    .SingleOrDefault();

                if (model == null) {
                    return HttpNotFound();
                }

                viewModel = new CurvedDoorQuoteModel(model);
            }

            PageHeader = viewModel;

            return View("Model", viewModel);
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
            var cpd = quote.FirstLine.ProductDetails as CurvedDoor;
            if (cpd == null || cpd.CurvedDoorModel == null) {
                return HttpNotFound();
            }
            var viewmodel = new CurvedDoorQuoteModel(cpd);
            return View("Model", viewmodel);
        }

        [HttpPost]
        [SessionScope]
        public ActionResult Quote(CurvedDoorQuoteModel model) {
            var curvedDoor = new CurvedDoor();
            curvedDoor.Color = DbSession.Get<ColorLocal>(model.ColorId);
            curvedDoor.GlassSystem = DbSession.Get<GlassSystemLocal>(model.GlassId);
            curvedDoor.CurvedDoorModel = DbSession.Get<CurvedDoorModelLocal>(model.TypeId);

            if (curvedDoor.Color == null || curvedDoor.GlassSystem == null || curvedDoor.CurvedDoorModel == null)
                return RedirectToAction("quote");

            curvedDoor.Length = model.Length ?? 0;
            curvedDoor.Height = model.Height ?? 0;
            curvedDoor.Width = model.Width ?? 0;
            curvedDoor.Depth = model.Depth ?? 0;
            
            Session[SessionKeys.LAST_QUOTE] = new CurvedDoorQuoteModel(curvedDoor);

            var line = new QuoteLine();
            line.Name = curvedDoor.Name;
            line.Price = curvedDoor.SilverSellingPrice;
            line.BronzePrice = curvedDoor.BronzeSellingPrice;
            line.GoldPrice = curvedDoor.GoldSellingPrice;

            line.ProductDetails = curvedDoor;
            Session[SessionKeys.PENDING_QUOTE_LINE] = line;
            return RedirectToAction("create-quote", "customer", new { areas = AreaKind });
        }















        [Jsonp]
        public ActionResult GetColors() {
            var list = DbSession.QueryOver<ColorLocal>()
                .Where(c => c.CurvedDoor && c.WebsiteVisible)
                .OrderBy(c => c.Inx).Asc
                .Cacheable()
                .CacheMode(CacheMode.Normal)
                .List()
                .Select(r => new { r.ID, Name = r.Name_En })
                .ToList();
            return JsonDataSet(list, JsonRequestBehavior.AllowGet);
        }

        [Jsonp]
        public ActionResult GetGlasses() {
            var filter = "bla eq " + DEFAULT_SYSTEM_ID;//Request.QueryString["$filter"];
            var strs = filter.Split("eq".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
            int cdsid;
            IList<GlassSystemLocal> list;
            CurvedDoorSystemLocal cds;
            if (strs.Length > 1 && Int32.TryParse(strs[1], out cdsid) &&
                (cds = DbSession.Get<CurvedDoorSystemLocal>(cdsid)) != null) {
                list = cds.GlassSystems;
            } else {
                list = DbSession.QueryOver<GlassSystemLocal>().OrderBy(c => c.Inx).Asc.List();
            }
            return JsonDataSet(list.Where(c => c.WebsiteVisible).Select(r => new { r.ID, Name = r.Name_En }).ToList(), JsonRequestBehavior.AllowGet);
        }
    }
}