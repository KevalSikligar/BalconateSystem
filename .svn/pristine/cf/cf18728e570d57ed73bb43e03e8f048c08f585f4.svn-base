using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using Balcony.Miracle.Core;
using NHibernate;

namespace Balcony.Miracle.Web.Models {

    public class OrderPaymentModel {

        public OrderPaymentModel() {
            Items = new List<CartItem>();
        }

        public OrderPaymentModel(IList<CartItem> items, Order order) {
            Items = items;
            DeliveryPrice = order.DeliveryPrice;
            IncludesDelivery = order.IncludesDelivery;
            if (IncludesDelivery) {
                DeliveryTo = order.DeliveryAddress.Postcode;
            }

            DiscountPercent = order.DiscountPercent;
            VatPercent = order.VATPercent;
            var invoice = order.CreateInvoice(order.CreatedUser);
            Deposit = invoice.Total;
            CreditHouse = order.BillingAddress.House;
            CreditStreet = order.BillingAddress.Street;
            CreditPostCode = order.BillingAddress.Postcode;
            CreditTown = order.BillingAddress.City;
            CreditCountryId = order.BillingAddress.SubRegion.Country.ID;
        }

        public enum BillingOptionType {
            SameAddress,
            DifferentAddress
        }

        public BillingOptionType BillingOption { get; set; }

        [Required(ErrorMessage = "House is required")]
        public string CreditHouse { get; set; }

        [Required(ErrorMessage = "Street is required")]
        public string CreditStreet { get; set; }

        public string CreditTown { get; set; }

        [Required(ErrorMessage = "Please select country")]
        public int? CreditCountryId { get; set; }

        [Required(ErrorMessage = "Postcode is required")]
        public string CreditPostCode { get; set; }
        public IList<CartItem> Items { get; private set; }

        public double SubTotal {
            get {
                return Items.Sum(ci => ci.Total);
            }
        }

        public double DiscountPercent { get; set; }

        public double DiscountSum {
            get {
                return SubTotal * (DiscountPercent / -100D);
            }
        }

        public double SubTotalWithDiscount {
            get {
                return SubTotal + DiscountSum;
            }
        }

        public bool IncludesDelivery { get; set; }

        public string DeliveryTo { get; set; }

        public double DeliveryPrice { get; set; }

        public double SubTotalWithDelivery {
            get {
                return SubTotalWithDiscount + DeliveryPrice;
            }
        }

        public double VatPercent { get; set; }

        public double VatSum {
            get {
                return SubTotalWithDelivery * (VatPercent / 100D);
            }
        }

        public double Total {
            get {
                return SubTotalWithDelivery + VatSum;
            }
        }

        public double Deposit { get; set; }

        [MustTick]
        public bool AuthorizeOrder { get; set; }

        [MustTick]
        public bool AcceptTerms { get; set; }

        public int CreditCardType { get; set; }
        
        [Required(ErrorMessage = "Card number is required")]
        public string CreditCardNumber { get; set; }
        
        [Required(ErrorMessage = "CVV is required")]
        public string Cvv { get; set; }

        public int ExpYear { get; set; }

        public int ExpMonth { get; set; }

        public int StartYear { get; set; }

        public int StartMonth { get; set; }

        public string IssueNumber { get; set; }

        public string Iframe { get; set; }




        private static IList<ComboItem> cardTypes;
        public static IList<ComboItem> CardTypes {
            get {
                if (cardTypes == null) {
                    cardTypes = new List<ComboItem>();
                    cardTypes.Add(new ComboItem(1, "MasterCard / EuroCard"));
                    cardTypes.Add(new ComboItem(0, "Visa / Delta / Electron"));
                    cardTypes.Add(new ComboItem(4, "Switch / Maestro"));
                    cardTypes.Add(new ComboItem(5, "Solo"));
                }
                return cardTypes;
            }
        }

        private static IList<int> months;
        public static IList<int> Months {
            get {
                if (months == null) {
                    months = new List<int>();
                    for (var i = 1; i <= 12; i++) {                        
                        months.Add(i);
                    }
                }
                return months;
            }
        }

        private static IList<int> expYears;
        public static IList<int> ExpYears {
            get {
                if (expYears == null) {
                    expYears = new List<int>();
                    for (var i = DateTime.Now.Year; i <= DateTime.Now.Year + 10; i++) {
                        expYears.Add(i);
                    }
                }
                return expYears;
            }
        }

        private static IList<int> startYears;
        public static IList<int> StartYears {
            get {
                if (startYears == null) {
                    startYears = new List<int>();
                    for (var i = DateTime.Now.Year - 10; i <= DateTime.Now.Year; i++) {
                        startYears.Add(i);
                    }
                }
                return startYears;
            }
        }

        public Address GetCardHolderAddress(ISession session) {
            var result = new Address();
            result.House = CreditHouse;
            result.Street = CreditStreet;
            result.City = CreditTown;
            result.Postcode = CreditPostCode;
            if (CreditCountryId.HasValue) {
                var country = session.Get<Country>(CreditCountryId.Value);
                if (country != null && country.Regions.Count > 0 && country.Regions[0].SubRegions.Count > 0) {
                    result.SubRegion = country.Regions[0].SubRegions[0];
                }
            }
            return result;
        }
    }
}