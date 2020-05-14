using System.ComponentModel.DataAnnotations;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Cms;

namespace Balcony.Miracle.Web.Models {

    public class CustomJulietteQuoteModel {

        public CustomJulietteQuoteModel() {
            
        }

        public CustomJulietteQuoteModel(StandardPage page, JulietteType julietteType) {
            Page = page;
            TypeId = julietteType.ID;
            MinWidth = julietteType.MinWidth;
            MaxWidth = julietteType.MaxWidth - julietteType.AppendToHandrail2;
        }

        public CustomJulietteQuoteModel(StandardPage page, Juliette jul)
            : this(page, jul.JulietteType)
        {
            ColorId = jul.Color.ID;
            GlassId = jul.GlassSystem.ID;
            Width = jul.OpenWidth;
        }

        public int TypeId { get; set; }

        public int ColorId { get; set; }
        
        public int GlassId { get; set; }

        [Required]
        [SpecifiedRange("MinWidth", "MaxWidth")]
        public int? Width { get; set; }

        public StandardPage Page { get; set; }

        public int MinWidth { get; set; }
        public int MaxWidth { get; set; }
    }
}