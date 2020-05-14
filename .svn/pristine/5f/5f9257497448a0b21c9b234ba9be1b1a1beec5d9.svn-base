using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace Balcony.Miracle.Web
{

    [AttributeUsage(AttributeTargets.Property, AllowMultiple = true, Inherited = true)]
    public class SameAsAttribute : ValidationAttribute, IClientValidatable
    {

        public string OtherPropertyName { get; private set; }

        public SameAsAttribute(string otherPropertyName)
        {
            OtherPropertyName = otherPropertyName;
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            var otherval = validationContext.ObjectType
                .GetProperty(OtherPropertyName)
                .GetValue(validationContext.ObjectInstance, null);
            return Equals(value, otherval) ? ValidationResult.Success : new ValidationResult(FormatErrorMessage(validationContext.DisplayName));
        }

        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context)
        {
            var modelClientValidationRule = new ModelClientValidationRule
            {
                ValidationType = "sameas",
                ErrorMessage = FormatErrorMessage(metadata.DisplayName)
            };
            modelClientValidationRule.ValidationParameters.Add("otherprop", OtherPropertyName);
            yield return modelClientValidationRule;
        }


    }
}
