using System;
using System.Collections.Generic;
using System.Linq;
using Balcony.Miracle.Core;
using Balcony.Miracle.Server.Jobs.Reports.Formatters;
using Quartz;

namespace Balcony.Miracle.Server.Jobs.Reports
{
    public class WeeklyDrawingFollowUpReportJob : ReportJobBase<OrderBatch>
    {
        #region Overrides of ReportJobBase<OrderBatch>

        protected override string Name { get; } = "Weekly drawings follow up report";

        protected override string Subject { get; } = "Weekly drawings follow up report";

        protected override string Recipient { get; } = "technical@balconette.co.uk";

        protected override string Header { get; } = "Weekly drawings follow up report";

        protected override IReportFormatter<OrderBatch> Formatter { get; } = new BatchReportFormatter();

        protected override IList<OrderBatch> GetObjects()
        {
            var batches = this.session.QueryOver<OrderBatch>()
                .Where(ob => ob.Status == OrderBatch.BatchStatus.Waiting_For_Approval)
                .JoinQueryOver(ob => ob.Order)
                .Where(o => o.Company == Company.DefaultCompany && o.Status == Order.OrderStatus.Technical)
                .List();

            var now = DateTime.Now;
            var min = now.AddDays(-7);

            return batches
                .Where(ob => ob.Order.RawEvents.Count > 0 && ob.Order.RawEvents.Max(e => e.DateCreated) < min)
                .ToList();
        }

        #endregion

        #region Overrides of JobBase

        public override ITrigger GetTrigger()
        {
            return TriggerBuilder.Create()
                .WithSchedule(CronScheduleBuilder
                    .AtHourAndMinuteOnGivenDaysOfWeek(15, 0, DayOfWeek.Wednesday))
                .Build();
        }

        #endregion
    }
}