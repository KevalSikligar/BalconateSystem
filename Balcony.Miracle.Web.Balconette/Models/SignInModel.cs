using System.ComponentModel.DataAnnotations;

namespace Balcony.Miracle.Web.Models {
    public class SignInModel {

        [Required(ErrorMessage = "Email is required")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Password is required")]
        public string Password { get; set; }

        public bool StaySignedIn { get; set; }

        public string Redirect { get; set; }

    }
}