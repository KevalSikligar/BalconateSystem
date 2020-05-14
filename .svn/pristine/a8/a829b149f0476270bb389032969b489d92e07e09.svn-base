using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace Balcony.Miracle.Web {

    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false, Inherited = true)]
    public class MustTickAttribute : ValidationAttribute, IClientValidatable {

        protected override ValidationResult IsValid(object value, ValidationContext validationContext) {
            if (Equals(value, true)) {
                return ValidationResult.Success;
            }
            return new ValidationResult(FormatErrorMessage(validationContext.DisplayName));
        }


        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context) {
            var modelClientValidationRule = new ModelClientValidationRule {
                ValidationType = "musttick",
                ErrorMessage = FormatErrorMessage(metadata.DisplayName)
            };
            yield return modelClientValidationRule;
        }


    }
}