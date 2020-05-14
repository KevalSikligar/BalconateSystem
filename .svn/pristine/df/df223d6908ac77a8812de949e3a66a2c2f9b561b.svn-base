using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web;
using Balcony.Miracle.Core;
using Balcony.Miracle.Core.Services.TemplateService;
using Balcony.Miracle.Web.Cms;
using Org.BouncyCastle.Bcpg;

namespace Balcony.Miracle.Web.Models {

    public class BalustradeQuoteModel : IPageHeader {

        public BalustradeQuoteModel() {
            Dims = new List<BalustradeQuoteDimension>();
        }

        public BalustradeQuoteModel(BalustradeModel model, Balustrade balustrade, int p = 0, User user = null) : 
            this() {
            TypeId = balustrade.BalustradeSystem.ID;
            ColorId = balustrade.Color.ID;
            GlassId = balustrade.GlassSystem.ID;
            foreach (var section in model.Sections) {
                Dims.Add(new BalustradeQuoteDimension(section));
            }

            for (var i = 0; i < balustrade.RawBalustradeSections.Count; i++)
            {
                Dims[i].Length = (int)balustrade.RawBalustradeSections[i].Length;
                //Dims[i].Depth = (int)balustrade.RawBalustradeSections[i].Depth;
            }

            P = p;
            if (p == 1)
            {
                Price = balustrade.SellingPrice ?? 0D;
            }
            else if (p == 2)
            {
                VATEnabled = true;
                Price = (balustrade.SellingPrice ?? 0D) * (1D + ((user?.DefaultCompany?.VatPercent ?? 0D) / 100D));
            }

            ModelId = model.ID;
            ModelImage = model.Image;
            ModelUrl = model.Url;
            Title = TemplateService.GetText(model.Title, balustrade);
            Keywords = TemplateService.GetText(model.Keywords, balustrade);
            Description = TemplateService.GetText(model.Description, balustrade);
            H1 = TemplateService.GetText(model.H1, balustrade);
            Body = TemplateService.GetText(model.Body, balustrade);
            List<string> imageExist = new List<string>();
            for (int counter = 0; counter < 100; counter++)
            {
                string Imgsrc;

                Imgsrc = string.Empty;
                Imgsrc = "/images/balustrades/thumb/b";
                Imgsrc += TypeId + "/";
                Imgsrc += ModelImage + "/";
                if (counter == 0)
                {
                    Imgsrc += ColorId + ".jpg";
                }
                else
                {
                    Imgsrc += ColorId + "_" + counter + ".jpg";
                }
                if (System.IO.File.Exists(HttpContext.Current.Server.MapPath(Imgsrc)))
                {
                    imageExist.Add(Imgsrc);
                }
            }
            thumbnailimages = imageExist;
        }

        public string ModelUrl { get; set; }
        public string ModelName { get; set; }

        public string ModelImage { get; set; }

        public int TypeId { get; set; }

        public bool VATEnabled { get; set; }

        public double Price { get; set; }

        public int ColorId { get; set; }
        
        public int GlassId { get; set; }

        public int P { get; set; }

        public Guid? ModelId { get; set; }
        public List<string> thumbnailimages{ get; set; }

        public IList<BalustradeQuoteDimension> Dims { get; set; }
        public IList<ColorLocal> Colors { get; set; }

        public string H1 { get; set; }

        public string Keywords { get; set; }

        public string Title { get; set; }
        public string Title1 { get; set; }

        public string Description { get; set; }

        public string Body { get; set; }

        public static string AddToCartText { get; } = "Add to Cart";

        public static string GetQuoteText { get; } = "Save Quote";

        public string Action { get; set; }

        public Guid? FooterLinksID
        {
            get { return null; }
        }


        public class BalustradeQuoteDimension {

            public BalustradeQuoteDimension() {
                
            }

            public BalustradeQuoteDimension(BalustradeModel.ModelSection section) {
                X = section.X;
                Y = section.Y;
                Curved = section.Curved;
            }

            [Range(200, 99999, ErrorMessage = "Between 400 and 10000")]
            [Required(ErrorMessage = "This is required")]
            public int? Length { get; set; }

            //[Range(0, 99999, ErrorMessage = "Between 400 and 10000")]
            //[Required(ErrorMessage = "This is required")]
            //public int? Depth { get; set; }

            public int X { get; set; }

            public int Y { get; set; }

            public bool Curved { get; set; }
        }

    }
}