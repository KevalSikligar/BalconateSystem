using System;
using System.Collections.Generic;
using Balcony.Miracle.Core;
using Balcony.Miracle.Server.Jobs.Reports.Formatters;
using Quartz;

namespace Balcony.Miracle.Server.Jobs.Reports
{
    public class DailyUnhandledOrdersReportJob : ReportJobBase<OrderBatch>
    {
        #region Overrides of ReportJobBase<OrderBatch>

        protected override string Name { get; } = "Daily unhandled orders report";

        protected override string Subject { get; } = "Daily unhandled orders report";

        protected override string Recipient { get; } = "technical@balconette.co.uk";

        protected override string Header { get; } = "Daily unhandled orders report";

        protected override IReportFormatter<OrderBatch> Formatter { get; } = new BatchReportFormatter();

        protected override IList<OrderBatch> GetObjects()
        {
            var now = DateTime.Now;
            var min = now.AddDays(-3);
            return this.session.QueryOver<OrderBatch>()
                .Where(ob => ob.Status == OrderBatch.BatchStatus.Technical_Reception && ob.TechnicalReceptionEnter <= min)
                .JoinQueryOver(ob => ob.Order)
                .Where(o => o.Company == Company.DefaultCompany && o.Status == Order.OrderStatus.Technical)
                .List();
        }

        #endregion

        #region Overrides of JobBase

        public override ITrigger GetTrigger()
        {
            return TriggerBuilder.Create()
                .WithSchedule(CronScheduleBuilder
                    .AtHourAndMinuteOnGivenDaysOfWeek(14, 0, DayOfWeek.Monday, DayOfWeek.Tuesday, DayOfWeek.Wednesday, DayOfWeek.Thursday, DayOfWeek.Friday))
                .Build();
        }

        #endregion
    }
}