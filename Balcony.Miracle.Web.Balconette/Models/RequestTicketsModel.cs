using Balcony.Miracle.Core;
using NHibernate;

namespace Balcony.Miracle.Web.Models {

    public class RequestTicketsModel : CustomerDto {

        public RequestTicketsModel()
        {
        }

        public override void UpdateCustomer(ISession session, Customer customer) {
            base.UpdateCustomer(session, customer);
        }
        
    }
}