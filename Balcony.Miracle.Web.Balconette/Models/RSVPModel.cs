using System.Collections.Generic;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Cms;
using NHibernate;

namespace Balcony.Miracle.Web.Models {

    public class RSVPModel : CustomerDto {

        public RSVPModel() {
            Subscription = true;
        }

        public IList<int> Products { get; set; }

        public Area SelectedProduct { get; set; }

        public string Notes { get; set; }

        public bool Subscription { get; set; }

        public override void UpdateCustomer(ISession session, Customer customer) {
            base.UpdateCustomer(session, customer);
            customer.Subscription = Subscription;
        }
        
    }
}