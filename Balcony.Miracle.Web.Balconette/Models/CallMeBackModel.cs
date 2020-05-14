using System.ComponentModel.DataAnnotations;

namespace Balcony.Miracle.Web.Models
{
    public class CallMeBackModel
    {

        [Required(ErrorMessage = "Name is required")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Phone is required")]
        public string Phone { get; set; }
        [Required(ErrorMessage = "Day is required")]
        public string Day { get; set; }

        [Required(ErrorMessage = "Hour is required")]
        public string Time { get; set; }

    
    }
}