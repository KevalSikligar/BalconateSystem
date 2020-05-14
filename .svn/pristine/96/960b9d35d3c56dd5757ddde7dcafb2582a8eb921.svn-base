using System.Collections.Generic;
using System.Text;
using Balcony.Miracle.Core;

namespace Balcony.Miracle.Server.Jobs.Reports.Formatters
{
    public class OrderReportFormatter : IReportFormatter<Order>
    {
        #region Implementation of IReportFormatter<OrderBatch>

        public string Format(IList<Order> objects)
        {
            var sb = new StringBuilder(10000);

            if (objects.Count == 0)
            {
                sb.Append("<h2>No outstanding orders</h2>");
            }
            else
            {
                sb.Append("<table border=\"1\" cellspacing=\"0\" cellpadding=\"5\">");
                sb.Append("<tr><th>#Order</th><th>Date Created</th><th>Customer</th><th>User</th></tr>");
                foreach (var order in objects)
                {
                    sb.AppendFormat("<tr><td>{0}</td><td align=\"right\">{1:dd/MM/yyyy}</td><td>{2}</td><td>{3}</td></tr>", order.Code, order.DateCreated, order.Customer.Name, order.CreatedUser.FullName);
                }
                sb.Append("</table>");
            }

            var result = sb.ToString();
            return result;
        }

        #endregion
    }
}