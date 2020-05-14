using System;
using System.Collections.Generic;
using Balcony.Miracle.Core;
using Balcony.Miracle.Server.Jobs.Reports.Formatters;
using Quartz;

namespace Balcony.Miracle.Server.Jobs.Reports
{
    public class WeeklyDepositPaidNoConfirmationReportJob : ReportJobBase<Order>
    {
        #region Overrides of ReportJobBase<OrderBatch>

        protected override string Name { get; } = "Weekly deposit paid OC not signed report";

        protected override string Subject { get; } = "Weekly deposit paid OC not signed report";

        protected override string Recipient { get; } = "sales@balconette.co.uk";

        protected override string Header { get; } = "Weekly deposit paid OC not signed report";

        protected override IReportFormatter<Order> Formatter { get; } = new OrderReportFormatter();

        protected override IList<Order> GetObjects()
        {
            return this.session.QueryOver<Order>()
                .Where(o => o.Company == Company.DefaultCompany && o.Status == Order.OrderStatus.New_Order && o.DepositPaidOrPo == true && o.ConfirmationSigned == false)
                .JoinQueryOver(o => o.CreatedUser)
                .OrderBy(cu => cu.FullName).Asc
                .List();
        }

        #endregion

        #region Overrides of JobBase

        public override ITrigger GetTrigger()
        {
            return TriggerBuilder.Create()
                .WithSchedule(CronScheduleBuilder
                    .AtHourAndMinuteOnGivenDaysOfWeek(10, 0, DayOfWeek.Tuesday))
                .Build();
        }

        #endregion
    }
}