using System.Collections.Generic;
using System.Text;
using Balcony.Miracle.Core;

namespace Balcony.Miracle.Server.Jobs.Reports.Formatters
{
    public class BatchReportFormatter : IReportFormatter<OrderBatch>
    {
        #region Implementation of IReportFormatter<OrderBatch>

        public string Format(IList<OrderBatch> objects)
        {
            var sb = new StringBuilder(10000);

            if (objects.Count == 0)
            {
                sb.Append("<h2>No outstanding batches</h2>");
            }
            else
            {
                sb.Append("<table border=\"1\" cellspacing=\"0\" cellpadding=\"5\">");
                sb.Append("<tr><th>#Batch</th><th>Customer</th><th>Max Supply Date</th></tr>");
                foreach (var orderBatch in objects)
                {
                    sb.AppendFormat("<tr><td>{0}</td><td>{1}</td><td align=\"right\">{2:dd/MM/yyyy}</td></tr>", orderBatch.Code, orderBatch.Order.Customer.Name, orderBatch.StaticMaxSupplyDate);
                }
                sb.Append("</table>");
            }

            var result = sb.ToString();
            return result;
        }

        #endregion
    }
}