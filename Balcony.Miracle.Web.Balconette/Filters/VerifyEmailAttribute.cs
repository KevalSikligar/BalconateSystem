using System.ComponentModel.DataAnnotations;
using System.Net;
using Cobisi.EmailVerify;

namespace Balcony.Miracle.Web {
   
    public class VerifyEmailAttribute : ValidationAttribute {

        public VerificationLevel VerificationLevel { get; set; }

        public VerifyEmailAttribute() : 
            this(VerificationLevel.Mailbox) {
        }

        public VerifyEmailAttribute(VerificationLevel level) {
            VerificationLevel = level;
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext) {
            var email = value as string;
            if (email != null) {
               
                if (Dns.GetHostName().ToUpper() != "DSVR017757")
                    return ValidationResult.Success;

                var verifier = new EmailVerifier();
                var result =  verifier.Verify(email, VerificationLevel);
                if (result.IsSuccess) {
                    return ValidationResult.Success;
                }
            }
            return new ValidationResult(FormatErrorMessage(validationContext.DisplayName));
        }
    }
}