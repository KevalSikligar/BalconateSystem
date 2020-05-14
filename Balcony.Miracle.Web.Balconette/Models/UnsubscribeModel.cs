using System.ComponentModel.DataAnnotations;

namespace Balcony.Miracle.Web.Models
{
    public class UnsubscribeModel
    {
        [Email(ErrorMessage = "Invalid Email")]
        [Required]
        public string Email { get; set; }
    }
}