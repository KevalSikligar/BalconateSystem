using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;
using Balcony.Miracle.Core;

namespace Balcony.Miracle.Web {

    [AttributeUsage(AttributeTargets.Property, AllowMultiple = true, Inherited = true)]
    public class SpecifiedRangeAttribute : ValidationAttribute, IClientValidatable {

        public string MinPropertyName { get; private set; }

        public string MaxPropertyName { get; private set; }

        private const string FORMAT = "Enter a value between {0} and {1}";

        public SpecifiedRangeAttribute(string minPropertyName, string maxPropertyName) {
            MinPropertyName = minPropertyName;
            MaxPropertyName = maxPropertyName;
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext) {
            var minProp = validationContext.ObjectType.GetProperty(MinPropertyName);
            var maxProp = validationContext.ObjectType.GetProperty(MaxPropertyName);
            var minVal = Convert.ToDouble(minProp.GetValue(validationContext.ObjectInstance, null));
            var maxVal = Convert.ToDouble(maxProp.GetValue(validationContext.ObjectInstance, null));
            if (value.GetType().IsNumeric() && minProp.PropertyType.IsNumeric() && maxProp.PropertyType.IsNumeric()) {
                var val = Convert.ToDouble(value);
                if (minVal <= val && val <= maxVal) {
                    return ValidationResult.Success;
                }
            }
            return new ValidationResult(String.Format(FORMAT, minVal, maxVal));
        }

        public IEnumerable<ModelClientValidationRule> GetClientValidationRules(ModelMetadata metadata, ControllerContext context) {
            var modelClientValidationRule = new ModelClientValidationRule {
                ValidationType = "specrange",
                ErrorMessage = FORMAT
            };
            modelClientValidationRule.ValidationParameters.Add("minprop", MinPropertyName);
            modelClientValidationRule.ValidationParameters.Add("maxprop", MaxPropertyName);
            yield return modelClientValidationRule;
        }


    }
}