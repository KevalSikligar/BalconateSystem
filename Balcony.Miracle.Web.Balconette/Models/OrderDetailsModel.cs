using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Balcony.Miracle.Core;
using NHibernate;
using System.Linq;
  
namespace Balcony.Miracle.Web.Models {

    public class OrderDetailsModel : CustomerDto {

        public enum DeliveryOptionType {
            SameAddress,
            DifferentAddress,
            NoDelivery
        }

        public DeliveryOptionType DeliveryOption { get; set; }

        [Required(ErrorMessage = "House is required")]
        public virtual string DeliveryHouse { get; set; }

        [Required(ErrorMessage = "Street is required")]
        public virtual string DeliveryStreet { get; set; }

        public virtual string DeliveryTown { get; set; }

        [Required(ErrorMessage = "Country is required")]
        public virtual int? DeliveryCountryId { get; set; }

        [Required(ErrorMessage = "Region is required")]
        public virtual int? DeliveryRegionId { get; set; }

        [Required(ErrorMessage = "Sub region is required")]
        public virtual int? DeliverySubRegionId { get; set; }
        
        [Required(ErrorMessage = "Postcode is required")]
        public virtual string DeliveryPostCode { get; set; }

        private string password1;
        [Password(ErrorMessage = "Please enter at least 6 characters")]
        [Required(ErrorMessage = "Password is required")]
        public virtual string Password1 {
            get {
                return password1;
            }
            set {
                password1 = value != null ? value.ToLower().Trim() : null;
            }
        }

        private string password2;
        [Required(ErrorMessage = "Please retype password")]
        [SameAs("Password1", ErrorMessage = "Please retype password correctly")]
        public virtual string Password2 {
            get {
                return password2;
            }
            set {
                password2 = value != null ? value.ToLower().Trim() : null;
            }
        }
        
        public static OrderDetailsModel FromCustomer(Customer cus) {
            var res = new OrderDetailsModel();
            res.Title = cus.DefaultContact.Title;
            res.FirstName = cus.DefaultContact.FirstName;
            res.LastName = cus.DefaultContact.LastName;
            res.Email1 = cus.DefaultEmail;
            res.Email2 = cus.DefaultEmail;
            res.CompanyName = cus.CompanyName;
            res.Phone = cus.DefaultContact.PrimaryPhone;
            res.Mobile = cus.DefaultContact.SecondaryPhone;
            res.Fax = cus.Fax;
            res.CatalogId = cus.CustomerCatalogs.Any() ? cus.CustomerCatalogs.First().ID : (int?)null;            
            if (cus.PrimaryAddress != null) {
                res.House = cus.PrimaryAddress.House;
                res.Street = cus.PrimaryAddress.Street;
                res.Town = cus.PrimaryAddress.City;
                res.PostCode = cus.PrimaryAddress.Postcode;
                res.CountryId = cus.PrimaryAddress.Country.ID;
                res.RegionId = cus.PrimaryAddress.Region.ID;
                res.SubRegionId = cus.PrimaryAddress.SubRegion.ID;
                res.House = cus.PrimaryAddress.House;
            }
            res.Password1 = cus.Password;
            return res;
        }
        public override void UpdateCustomer(ISession session, Customer customer)
        {
            base.UpdateCustomer(session, customer);
            if (Password1 != null)
            {
                customer.Password = Password1;
                customer.LoginEnabled = true;
            }
        }

    }
}