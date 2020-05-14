using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Core.Drawing.Drawing2D;
using Balcony.Miracle.Web.Cms;
using Balcony.Miracle.Web.Models;
using Balcony.Miracle.Web.Shared;
using Newtonsoft.Json;
using NHibernate;
using PdfSharp;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using SvgNet.SvgGdi;
using Color = System.Drawing.Color;
using Margins = System.Drawing.Printing.Margins;

namespace Balcony.Miracle.Web.Controllers {

    public class BalustradesController : BaseController {

        public BalustradesController() :
            base(AreaKind.Balustrades) {
        }


        public override string DefaultAction {
            get {
                return "homepage";
            }
        }

        public ActionResult Homepage() {
            return View(Area);
        }

        [ActionName("glass-balustrade-quote-success")]
        public ActionResult GlassQuoteSuccess(Guid? id)
        {
            return QuoteSuccess(id, "glass-balustrade-quote-success");
        }

        private BalustradeQuoteModel GetModel(string id, int type, int color, int glass, string mes, int price)
        {
            var model = DbSession.QueryOver<BalustradeModel>().Where(bm => bm.Url == id).Cacheable().CacheMode(CacheMode.Normal).SingleOrDefault();
            if (model == null)
                return null;
            var t = DbSession.Get<BalustradeSystemLocal>(type);
            var c = t.Colors.FirstOrDefault(clr => clr.ID == color) ?? t.Colors.FirstOrDefault();
            var g = t.GlassSystems.FirstOrDefault(gl => gl.ID == glass) ?? t.GlassSystems.FirstOrDefault();

            var bal = new Balustrade {
                BalustradeSystem = t,
                Color = c,
                GlassSystem = g
            };
            bal.UpdateSystemDefaults();
            bal.StartType = BalustradeSection.SectionFinishType.Wall;
            bal.EndType = BalustradeSection.SectionFinishType.Wall;
            bal.ModelId = model.ID;

            var mesParts = (mes ?? "").Split(";".ToCharArray())
                .Select(p =>
                {
                    int parsed;
                    return Int32.TryParse(p, out parsed) ? parsed : 0;
                })
                .Where(p => 0 < p && p < 999999)
                .ToArray();

            var angle = mesParts.Length > 1 ? 90D : 0D;
            var i = 0;
            foreach (var dim in mesParts)
            {
                bal.RawBalustradeSections.Add(new BalustradeSection
                {
                    Balustrade = bal,
                    Length = dim,
                    Angle = angle,
                    Depth = (i < model.Sections.Count && model.Sections[i].Curved) ? 10 : 0,
                    CalculatePostsQuantity = true,
                    CalculateHandrailJoints = true,
                    PreferStockGlass = t.PreferStockGlass
                });
                i++;
                angle -= 90;
            }

            var viewModel = new BalustradeQuoteModel(model, bal, price, DbSession.CurrentUser());

            return viewModel;
        }

        [SessionScope]
        [ActionName("model-ajax")]
        public ActionResult ModelAjax(string id, int? type, int? color, int? glass, string mes, int p = 0)
        {
            if (id == null || !type.HasValue || !color.HasValue || !glass.HasValue)
                return RedirectToActionPermanent(DefaultAction);

            var model = GetModel(id, type.Value, color.Value, glass.Value, mes, p);
            if (model == null)
                return HttpNotFound();

            return View("ModelDetails", model);
        }

        [SessionScope]
        public ActionResult Quote(string id, int? type, int? color, int? glass, string mes = "", int p = 0) {
            if(String.IsNullOrWhiteSpace(id)) {
                var page = DbSession.Get<StandardPage>(new Guid("603a994c-bdbb-4bf6-a8e7-a3d601288995"));
                ViewBag.Body = page.Body;
                PageHeader = page;
                return View(DbSession.QueryOver<BalustradeModel>()
                    .OrderBy(m => m.Inx).Asc
                    .Cacheable()
                    .CacheMode(CacheMode.Normal)
                    .List());
            }

            var balustradeSystem = DbSession.QueryOver<BalustradeSystemLocal>()
                .Where(c => c.OnlineVisible)
                .OrderBy(c => c.Inx)
                .Asc
                .List()
                .First();

            var colorId = balustradeSystem.Colors.OrderBy(c => c.BalustradePrice).First().ID;
            var glassId = balustradeSystem.GlassSystems.First().ID;

            if (type.HasValue)
                balustradeSystem = DbSession.Get<BalustradeSystemLocal>(type.Value);

            if (balustradeSystem == null || !balustradeSystem.OnlineVisible)
                return HttpNotFound();

            if (color.HasValue)
                colorId = DbSession.Get<ColorLocal>(color.Value)?.ID ?? colorId;

            if(balustradeSystem.Colors.All(c => c.ID != colorId))
                return HttpNotFound();

            if (glass.HasValue)
                glassId = DbSession.Get<GlassSystemLocal>(glass.Value)?.ID ?? glassId;

            if (balustradeSystem.GlassSystems.All(g => g.ID != glassId))
                return HttpNotFound();

            var model = GetModel(id, balustradeSystem.ID, colorId, glassId, mes, p);
            if (model == null)
                return HttpNotFound();

            var fromSession = HttpContext.GetSessionValue<BalustradeQuoteModel>(SessionKeys.LAST_QUOTE);
            if (fromSession != null && fromSession.ModelId.HasValue && fromSession.ModelId == model.ModelId) {
                model = fromSession;
            }

            PageHeader = model;

            return View("Model", model);
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
            var bal = quote.FirstLine.ProductDetails as Balustrade;
            if (bal == null || bal.ModelId == null) {
                return HttpNotFound();
            }

            var model = DbSession.Get<BalustradeModel>(bal.ModelId.Value);

            var viewmodel = new BalustradeQuoteModel(model, bal);

            return View("Model", viewmodel);
        }

        [HttpPost]
        [SessionScope]
        public ActionResult Quote(BalustradeQuoteModel model) {
            if (!model.ModelId.HasValue)
                return RedirectToAction("quote");

            var balustrade = new Balustrade();
            balustrade.Color = DbSession.Get<ColorLocal>(model.ColorId);
            balustrade.GlassSystem = DbSession.Get<GlassSystemLocal>(model.GlassId);
            balustrade.BalustradeSystem = DbSession.Get<BalustradeSystemLocal>(model.TypeId);
            balustrade.UpdateSystemDefaults();
            balustrade.StartType = BalustradeSection.SectionFinishType.Wall;
            balustrade.EndType = BalustradeSection.SectionFinishType.Wall;
            balustrade.ModelId = model.ModelId;

            var angle = model.Dims.Count > 1 ? 90D : 0D;
            foreach (var dimension in model.Dims) {
                var section = new BalustradeSection
                {
                    Balustrade = balustrade,
                    Angle = angle,
                    Length = dimension.Length ?? 0,
                    Depth = dimension.Curved ? 10 : 0,
                    CalculatePostsQuantity = true,
                    CalculateHandrailJoints = true,
                    PreferStockGlass = balustrade.BalustradeSystem.PreferStockGlass
                };
                balustrade.RawBalustradeSections.Add(section);
                angle -= 90;
            }

            var modelFromDb = DbSession.Get<BalustradeModel>(model.ModelId.Value);
            Session[SessionKeys.LAST_QUOTE] = new BalustradeQuoteModel(modelFromDb, balustrade, model.P);

            if (model.Action == BalustradeQuoteModel.AddToCartText)
            {
                DbSession.SaveOrUpdate(balustrade);

                AddToCart(balustrade, 1);
                DbSession.Flush();

                return RedirectToAction("cart", "customer", new { areas = AreaKind });
            }

            var line = new QuoteLine();
            line.Name = balustrade.Name;
            line.Price = balustrade.SilverSellingPrice;
            line.BronzePrice = balustrade.BronzeSellingPrice;
            line.GoldPrice = balustrade.GoldSellingPrice;

            line.ProductDetails = balustrade;
            Session[SessionKeys.PENDING_QUOTE_LINE] = line;


            return RedirectToAction("create-quote", "customer", new {areas = AreaKind});
        }

        [NoCache]
        [ActionName("drawing")]
        public ActionResult Drawing()
        {
            return View();
        }

        private static void InitializeViews(Balustrade balustrade)
        {
            var noHandrail = balustrade.BalustradeSystem.HandrailSystem.ID == ProfileSystem.NO_PROFILE_ID;

            balustrade.BalustradeViews.Clear();
            balustrade.BalustradeViews.Add(new BalustradeView
            {
                Name = "Overview",
                DrawBaseVectors = true,
                DrawBaseVectorsAngles = true,
                DrawBaseVectorsMes = true,
                BaseVectorsMesDistance = 1000,
                BaseVectorsAnglesRadius = 500,

                DrawHandrail = !noHandrail,
                DrawHandrailInMes = false,
                DrawHandrailOutMes = false,
                DrawHandrailAngles = false,

                DrawBottomrail = true,
                DrawBottomrailInMes = false,
                DrawBottomrailOutMes = false,
                DrawBottomrailAngles = false,

                DrawPosts = true,
                DrawPostsMes = false,
                PostsMesDistance = 1000,

                DrawGlassPanels = true,
                DrawGlassPanelsMes = false,
                GlassPanelsMesDistance = 1000,

                DrawJoints = false,
                DrawOutsideText = true,
                OutsideTextDistance = 500,

                MesFontSize = 100
            });
            balustrade.BalustradeViews.Add(new BalustradeView
            {
                Name = "Handrail dimensions",
                DrawBaseVectors = true,
                DrawBaseVectorsAngles = true,
                DrawBaseVectorsMes = true,
                BaseVectorsMesDistance = 1000,
                BaseVectorsAnglesRadius = 400,

                DrawHandrail = true,
                DrawHandrailInMes = false,
                DrawHandrailOutMes = true,
                HandrailOutMesDistance = 600,
                DrawHandrailAngles = false,

                DrawBottomrail = true,
                DrawBottomrailInMes = false,
                DrawBottomrailOutMes = false,
                DrawBottomrailAngles = false,

                DrawPosts = true,
                DrawPostsMes = true,
                PostsMesDistance = 200,

                DrawGlassPanels = true,
                DrawGlassPanelsMes = false,
                GlassPanelsMesDistance = 1000,

                DrawJoints = false,
                DrawOutsideText = true,
                OutsideTextDistance = 1400,

                MesFontSize = 80
            });

            balustrade.BalustradeViews.Add(new BalustradeView
            {
                Name = "Bottomrail dimensions",
                DrawBaseVectors = true,
                DrawBaseVectorsAngles = true,
                DrawBaseVectorsMes = true,
                BaseVectorsMesDistance = 500,
                BaseVectorsAnglesRadius = 450,

                DrawHandrail = false,
                DrawHandrailInMes = false,
                DrawHandrailOutMes = false,
                DrawHandrailAngles = false,

                DrawBottomrail = true,
                DrawBottomrailInMes = false,
                DrawBottomrailOutMes = true,
                BottomrailOutMesDistance = 250,
                DrawBottomrailAngles = false,

                DrawPosts = false,
                DrawPostsMes = false,

                DrawGlassPanels = false,
                DrawGlassPanelsMes = false,

                DrawJoints = false,
                DrawOutsideText = true,
                OutsideTextDistance = 900,

                MesFontSize = 80
            });

            balustrade.BalustradeViews.Add(new BalustradeView
            {
                Name = "Glass dimensions",
                DrawBaseVectors = true,
                DrawBaseVectorsAngles = false,
                DrawBaseVectorsMes = true,
                BaseVectorsMesDistance = 500,

                DrawHandrail = !noHandrail,
                DrawHandrailInMes = false,
                DrawHandrailOutMes = false,
                DrawHandrailAngles = false,

                DrawBottomrail = true,
                DrawBottomrailInMes = false,
                DrawBottomrailOutMes = false,
                DrawBottomrailAngles = false,

                DrawPosts = true,
                DrawPostsMes = false,

                DrawGlassPanels = true,
                DrawGlassPanelsMes = true,
                GlassPanelsMesDistance = 300,

                DrawJoints = false,
                DrawOutsideText = true,
                OutsideTextDistance = 900,

                MesFontSize = 80
            });
        }

        private Balustrade CreateBalustradeFromDrawingModel(BalustradeDrawingModel model)
        {
            var balustrade = new Balustrade
            {
                Color = DbSession.Get<ColorLocal>(model.ColorId),
                GlassSystem = DbSession.Get<GlassSystemLocal>(model.GlassId),
                BalustradeSystem = DbSession.Get<BalustradeSystemLocal>(model.SystemId)
            };

            balustrade.UpdateSystemDefaults();
            InitializeViews(balustrade);


            balustrade.StartType = model.StartType;
            balustrade.EndType = model.EndType;

            balustrade.AluminumSpacers = true;

            if (model.HRBR.HasValue && model.HRBR.Value > 0)
            {
                balustrade.HRBR = model.HRBR.Value;
                balustrade.HRBRC = true;
            }

            if (model.BRHR.HasValue && model.BRHR.Value > 0)
            {
                balustrade.BRHR = model.BRHR.Value;
                balustrade.BRHRC = true;
            }

            balustrade.DrawBlack = false;
            balustrade.CurrentViewIndex = model.ViewIndex % balustrade.BalustradeViews.Count;

            if (model.StartWallAngle.HasValue)
            {
                balustrade.WSA = model.StartWallAngle.Value;
                balustrade.WSAR = false;
            }

            if (model.EndWallAngle.HasValue)
            {
                balustrade.WEA = model.EndWallAngle.Value;
                balustrade.WEAR = false;
            }
           
            var i = 0;
            foreach (var section in model.Sections)
            {
                var balSection = new BalustradeSection
                {
                    Balustrade = balustrade,
                    Length = section.Length,
                    Angle = section.Angle,
                    Ofst = section.Ofst ?? 0,
                    CalculatePostsQuantity = true,
                    CalculateHandrailJoints = true,
                    PreferStockGlass = balustrade.BalustradeSystem.PreferStockGlass
                };

                if (i == 0 && model.WG.HasValue)
                {
                    balSection.PreferStockGlass = false;
                    balustrade.WG = model.WG.Value;
                }

                if (i == model.Sections.Count - 1 && model.GW.HasValue)
                {
                    balSection.PreferStockGlass = false;
                    balustrade.GW = model.GW.Value;
                }

                balustrade.RawBalustradeSections.Add(balSection);
                i += 1;
            }

            return balustrade;
        }

        [HttpPost]
        [SessionScope]
        [ActionName("create-quote-from-drawing")]
        public ActionResult CreateQuoteFromDrawing(BalustradeDrawingModel model)
        {
            var balustrade = CreateBalustradeFromDrawingModel(model);

            var line = new QuoteLine();
            line.Name = balustrade.Name;
            line.Price = balustrade.SilverSellingPrice;
            line.BronzePrice = balustrade.BronzeSellingPrice;
            line.GoldPrice = balustrade.GoldSellingPrice;

            line.ProductDetails = balustrade;
            Session[SessionKeys.PENDING_QUOTE_LINE] = line;

            return Json(new { });
        }

        [HttpPost]
        [SessionScope]
        [ActionName("add-drawing-to-cart")]
        public ActionResult AddDrawingToCart(BalustradeDrawingModel model)
        {
            var balustrade = CreateBalustradeFromDrawingModel(model);

            double price;
            if (model.CartType == BalustradeDrawingModelCartType.Full)
            {
                price = (balustrade.SellingPrice ?? 0D) * (1D - (balustrade.BalustradeSystem.OnlineDrawingDiscount / 100D));
                balustrade.Locked = true;
                balustrade.OnlineDrawingApproved = true;
            }
            else
            {
                price = balustrade.SellingPrice ?? 0D;
            }

            DbSession.SaveOrUpdate(balustrade);
            AddToCart(balustrade, Math.Max(model.Quantity ?? 1, 1), price);
            DbSession.Flush();

            return Json(new { });
        }


        [SessionScope]
        [ActionName("draw")]
        public ActionResult Draw(string m, string f)
        {
            var str = Encoding.UTF8.GetString(Convert.FromBase64String(m));
            var model = JsonConvert.DeserializeObject<BalustradeDrawingModel>(str);

            var balustrade = CreateBalustradeFromDrawingModel(model);

            if (f == "pdf")
            {
                var fileName = "Drawing_" + balustrade.BalustradeViews[balustrade.CurrentViewIndex].Name;

                var memStream = new MemoryStream();

                using (var doc = balustrade.CreatePdf())
                {
                    doc.Info.Title = fileName;
                    doc.Save(memStream);
                }

                Response.AddHeader("content-disposition", String.Format("inline; filename={0}.pdf; size={1}", fileName, memStream.Length));

                return new FileStreamResult(memStream, "application/pdf");
            }


            var svgGraphics = new SvgGraphics();
            svgGraphics.Clear(Color.White);
            balustrade.Paint(svgGraphics);

            return Json(new
            {
                svg = svgGraphics.WriteSVGString(),
                price = balustrade.SellingPrice,
                onlineDrawingDiscount = balustrade.BalustradeSystem.OnlineDrawingDiscount,
                vatPercent = DbSession.CurrentUser()?.DefaultCompany?.VatPercent ?? 0D,
                withPosts = balustrade.RawBalustradeSections.Any(s => s.Posts.Count > 0)
            }, JsonRequestBehavior.AllowGet);
        }

        [SessionScope]
        [ActionName("get-systems")]
        public ActionResult GetSystems()
        {
            var res = DbSession.QueryOver<BalustradeSystemLocal>()
                .Where(c => c.OnlineDrawingVisible)
                .OrderBy(c => c.Inx)
                .Asc
                .Cacheable()
                .CacheMode(CacheMode.Normal)
                .List()
                .Select(bs => new
                {
                    id = bs.ID,
                    name = bs.Name_En,
                    defaultHeight = bs.DefaultHeight,
                    handrailSystemWidth = bs.HandrailSystem.Width,
                    noHandrail = bs.HandrailSystem.ID == ProfileSystem.NO_PROFILE_ID,
                    drawingDiscount = bs.OnlineDrawingDiscount,

                    glasses = bs.GlassSystems.Where(c => c.WebsiteVisible).Select(g => new
                    {
                        id = g.ID,
                        name = g.Name_En
                    }).ToArray(),
                    colors = bs.Colors.Where(c => c.WebsiteVisible).Select(g => new
                    {
                        id = g.ID,
                        name = g.Name_En
                    }).ToArray(),



                })
                .ToList();
            return Json(res, JsonRequestBehavior.AllowGet);
        }


        [Jsonp]
        public ActionResult GetTypes() {
            var res = DbSession.QueryOver<BalustradeSystemLocal>()
                .Where(c => c.OnlineVisible)
                .OrderBy(c => c.Inx)
                .Asc
                .Cacheable()
                .CacheMode(CacheMode.Normal)
                .List()
                .Select(bs => new { bs.ID, Name = bs.Name_En })
                .ToList();
            return JsonDataSet(res, JsonRequestBehavior.AllowGet);
        }        

        [Jsonp]
        public ActionResult GetColors() {
            var filter = Request.QueryString["$filter"];
            var strs = filter?.Split("eq".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
            int bsid;
            IList<ColorLocal> list;
            BalustradeSystemLocal bs;
            if (strs != null && strs.Length > 1 && Int32.TryParse(strs[1], out bsid) && 
                (bs = DbSession.Get<BalustradeSystemLocal>(bsid)) != null) {
                list = bs.Colors;
            } else {
                list = DbSession.QueryOver<ColorLocal>().OrderBy(c => c.Inx).Asc.List();
            }
            return JsonDataSet(list.Where(c => c.WebsiteVisible).OrderBy(c => c.BalustradePrice).Select(r => new { r.ID, Name = r.Name_En }).ToList(), JsonRequestBehavior.AllowGet);
        }

        [Jsonp]
        public ActionResult GetGlasses() {
            var filter = Request.QueryString["$filter"];
            var strs = filter?.Split("eq".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
            int bsid;
            IList<GlassSystemLocal> list;
            BalustradeSystemLocal bs;
            if (strs != null && strs.Length > 1 && Int32.TryParse(strs[1], out bsid) &&
                (bs = DbSession.Get<BalustradeSystemLocal>(bsid)) != null) {
                list = bs.GlassSystems;
            } else {
                list = DbSession.QueryOver<GlassSystemLocal>().OrderBy(c => c.Inx).Asc.List();
            }
            return JsonDataSet(list.Where(c => c.WebsiteVisible).Select(r => new { r.ID, Name = r.Name_En }).ToList(), JsonRequestBehavior.AllowGet);
        }
        public ActionResult View3DModal()
        {

            return PartialView();
        }
    }
}