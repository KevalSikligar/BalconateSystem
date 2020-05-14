using System;
using System.ComponentModel.DataAnnotations;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Cms;

namespace Balcony.Miracle.Web.Models {

    public class StandardJulietteModel : IPageHeader {

        public StandardJulietteModel() {
            Quantity = 1;
        }

        public StandardJulietteModel(Juliette juliette, double? vatPercent) : 
            this() {
            TypeId = juliette.JulietteType.ID;
            TypeCode = juliette.JulietteType.NamePrefix + "BAL";
            ColorId = juliette.Color.ID;
            GlassId = juliette.GlassSystem.ID;
            StandardId = juliette.JulietteStandard.ID;
            OpenWidth = juliette.OpenWidth;

            Title = juliette.Title;
            Description = juliette.Description;
            Keywords = juliette.Keywords;
            H1 = juliette.H1;

            Price = juliette.SellingPrice ?? 0D;
            OldPrice = juliette.OnlineOldPrice;
            VATSum = vatPercent.HasValue ? Price * (vatPercent.Value / 100) : (double?)null;
        }

        public int StandardId { get; set; }

        [Range(1, 9)]
        public int TypeId { get; set; }

        public int ColorId { get; set; }
        
        public int GlassId { get; set; }

        public int Quantity { get; set; }

        public string H1 { get; set; }

        public string Title { get; set; }

        public string Description { get; set; }

        public string Keywords { get; set; }

        public int OpenWidth { get; set; }

        public double Price { get; private set; }

        public double OldPrice { get; private set; }

        public double? VATSum { get; private set; }

        public double TotalPrice {
            get { return VATSum.HasValue ? Price + VATSum.Value : Price; }
        }

        public bool CalcPrice { get; set; }

        public string TypeCode { get; set; }

        public Guid? FooterLinksID
        {
            get { return null; }
        }

    }
}