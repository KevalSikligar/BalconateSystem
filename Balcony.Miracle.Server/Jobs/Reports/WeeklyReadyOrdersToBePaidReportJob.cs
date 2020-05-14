using System;
using System.Collections.Generic;
using Balcony.Miracle.Core;
using Balcony.Miracle.Server.Jobs.Reports.Formatters;
using Quartz;

namespace Balcony.Miracle.Server.Jobs.Reports
{
    public class WeeklyReadyOrdersToBePaidReportJob : ReportJobBase<OrderBatch>
    {
        #region Overrides of ReportJobBase<OrderBatch>

        protected override string Name { get; } = "Weekly ready orders to be paid report";

        protected override string Subject { get; } = "Weekly ready orders to be paid report";

        protected override string Recipient { get; } = "logistics@balconette.co.uk";

        protected override string Header { get; } = "Weekly ready orders to be paid report";

        protected override IReportFormatter<OrderBatch> Formatter { get; } = new BatchReportFormatter();

        protected override IList<OrderBatch> GetObjects()
        {
            return this.session.QueryOver<OrderBatch>()
                .Where(ob => ob.Status == OrderBatch.BatchStatus.Ready_In_Warehouse)
                .JoinQueryOver(ob => ob.Order)
                .Where(o => o.Company == Company.DefaultCompany && o.Status == Order.OrderStatus.Technical && o.StaticTotal > o.StaticTotalPaid)
                .List();
        }

        #endregion

        #region Overrides of JobBase

        public override ITrigger GetTrigger()
        {
            return TriggerBuilder.Create()
                .WithSchedule(CronScheduleBuilder
                    .AtHourAndMinuteOnGivenDaysOfWeek(16, 0, DayOfWeek.Monday))
                .Build();
        }

        #endregion
    }
}