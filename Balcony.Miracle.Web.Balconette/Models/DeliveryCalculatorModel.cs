using System.ComponentModel.DataAnnotations;

namespace Balcony.Miracle.Web.Models {

    public class DeliveryCalculatorModel {

        [Required(ErrorMessage = "Sub region is required")]
        public int? SubRegionId { get; set; }

        public int? StandardId { get; set; }

        public int? TypeId { get; set; }

        public int? ColorId { get; set; }

        public int? GlassId { get; set; }



    }
}