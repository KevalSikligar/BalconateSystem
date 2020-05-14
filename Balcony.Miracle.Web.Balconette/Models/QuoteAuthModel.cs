using System.ComponentModel.DataAnnotations;
using Cobisi.EmailVerify;

namespace Balcony.Miracle.Web.Models {

    public class QuoteAuthModel {
        private string email;

        [Required(ErrorMessage = "First name is required")]
        public string FirstName { get; set; }
       
        [Required(ErrorMessage = "Last name is required")]
        public string LastName { get; set; }


        [Email(ErrorMessage = "Please enter a valid email address")]
        [Required(ErrorMessage = "Email is required")]
        [VerifyEmail(VerificationLevel.Dns, ErrorMessage = "Please enter a valid email address")]
        public virtual string Email {
            get {
                return email;
            }
            set {
                email = value != null ? value.ToLower().Trim() : null;
            }
        }

        public string Phone { get; set; }

    }
}