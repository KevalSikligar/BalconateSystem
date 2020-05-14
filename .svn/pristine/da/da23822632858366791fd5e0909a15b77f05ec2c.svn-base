using System;
using System.ComponentModel.DataAnnotations;
using Balcony.Miracle.Core;
using NHibernate;
  
namespace Balcony.Miracle.Web.Models
{

    public class CustomerDto
    {


        public bool HideAddress { get; set; }
        public bool SingleEmail { get; set; }
        public bool MobileHidden { get; set; }
        public bool FaxHidden { get; set; }

        private string email1;
        private string email2;
        public virtual string Title { get; set; }

        [Required(ErrorMessage = "First name is required")]
        public virtual string FirstName { get; set; }

        [Required(ErrorMessage = "Last name is required")]
        public virtual string LastName { get; set; }

        [Email(ErrorMessage = "Please enter a valid email address")]
        [Required(ErrorMessage = "Email is required")]
        public virtual string Email1
        {
            get { return email1; }
            set { email1 = value != null ? value.ToLower().Trim() : null; }
        }

        [Required(ErrorMessage = "Please retype email")]
        [SameAs("Email1", ErrorMessage = "Please retype email correctly")]
        public virtual string Email2
        {
            get { return email2; }
            set { email2 = value != null ? value.ToLower().Trim() : null; }
        }

        public virtual string CompanyName { get; set; }

        [Required(ErrorMessage = "Please select category")]
        public virtual int? CatalogId { get; set; }

        [Required(ErrorMessage = "House is required")]
        public virtual string House { get; set; }

        [Required(ErrorMessage = "Street is required")]
        public virtual string Street { get; set; }

        public virtual string Town { get; set; }


        [Required(ErrorMessage = "Country is required")]
        public virtual int? CountryId { get; set; }

        [Required(ErrorMessage = "Region is required")]
        public virtual int? RegionId { get; set; }

        [Required(ErrorMessage = "Sub region is required")]
        public virtual int? SubRegionId { get; set; }

        [Required(ErrorMessage = "Postcode is required")]
        public virtual string PostCode { get; set; }

        public virtual string Phone { get; set; }

        public virtual string Mobile { get; set; }

        public virtual string Fax { get; set; }

        public virtual Address ToAddress(ISession session)
        {
            var address = new Address();
            address.House = House;
            address.Street = Street;
            address.City = Town;
            address.Postcode = PostCode;
            if (SubRegionId.HasValue)
            {
                address.SubRegion = session.Get<SubRegion>(SubRegionId.Value);
            }
            return address;
        }

        public virtual void UpdateCustomer(ISession session, Customer customer)
        {

            /* customer.DefaultContact.Title = Title ?? "";
             customer.DefaultContact.FirstName = FirstName;
             customer.DefaultContact.LastName = LastName;
             customer.DefaultContact.Email = Email1;

             if (String.IsNullOrWhiteSpace(customer.CompanyName))
             {
                 customer.CompanyName = CompanyName;
             }
             if (String.IsNullOrWhiteSpace(customer.Name))
             {
                 customer.Name = String.IsNullOrWhiteSpace(customer.CompanyName) ? customer.DefaultContact.FullName : customer.CompanyName;
             }
             if (String.IsNullOrWhiteSpace(customer.DefaultContact.PrimaryPhone))
             {
                 customer.DefaultContact.PrimaryPhone = Mobile;
             }
             if (String.IsNullOrWhiteSpace(customer.DefaultContact.SecondaryPhone))
             {
                 customer.DefaultContact.SecondaryPhone = Phone;
             }
             if (String.IsNullOrWhiteSpace(customer.Fax))
             {
                 customer.Fax = Fax;
             }
             if (CatalogId.HasValue)
             {
                 var catalog = session.Get<CustomerCatalogType>(CatalogId.Value);
                 if (catalog != null && !customer.CustomerCatalogs.Contains(catalog))
                 {
                     customer.CustomerCatalogs.Add(catalog);
                 }
             }
             if (!HideAddress)
             {
                 var address = ToAddress(session);
                 if (customer.PrimaryAddress == null)
                 {
                     customer.PrimaryAddress = address;
                 }
                 else if (customer.SecondaryAddress == null)
                 {
                     customer.SecondaryAddress = address;
                 }
             }*/

            //Alexander 12/2017

            customer.DefaultContact.Title = Title ?? "";
            customer.DefaultContact.FirstName = FirstName;
            customer.DefaultContact.LastName = LastName;
            customer.DefaultContact.Email = Email1;

            if (!String.IsNullOrWhiteSpace(CompanyName))
            {
                customer.CompanyName = CompanyName;
            }
            customer.Name = String.IsNullOrWhiteSpace(customer.CompanyName) ? customer.DefaultContact.FullName : customer.CompanyName;

            if (!String.IsNullOrWhiteSpace(Mobile))
            {
                customer.DefaultContact.PrimaryPhone = Mobile;
            }
            if (!String.IsNullOrWhiteSpace(Phone))
            {
                customer.DefaultContact.SecondaryPhone = Phone;
            }
            if (!String.IsNullOrWhiteSpace(Fax))
            {
                customer.Fax = Fax;
            }
            if (CatalogId.HasValue)
            {
                var catalog = session.Get<CustomerCatalogType>(CatalogId.Value);
                if (catalog != null && !customer.CustomerCatalogs.Contains(catalog))
                {
                    customer.CustomerCatalogs.Add(catalog);
                }
            }
            if (!HideAddress)
            {
                var address = ToAddress(session);

                customer.PrimaryAddress = address;

            }
            
        }
    }
}