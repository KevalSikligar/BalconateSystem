using System.ComponentModel.DataAnnotations;

namespace Balcony.Miracle.Web {
   
    public class PasswordAttribute : ValidationAttribute {

        public PasswordAttribute() {


            
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext) {
            var str = value as string;
            if (str != null) {                
                if (str.Length >= 6) {
                    return ValidationResult.Success;
                }
            }
            return new ValidationResult(FormatErrorMessage(validationContext.DisplayName));
        }

    }
}