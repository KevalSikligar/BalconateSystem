using System;
using System.Collections.Generic;
using Balcony.Miracle.Core;
using Balcony.Miracle.Server.Jobs.Reports.Formatters;
using Quartz;

namespace Balcony.Miracle.Server.Jobs.Reports
{
    public class WeeklyUpcomingCompletionsReportJob : ReportJobBase<OrderBatch>
    {
        #region Overrides of ReportJobBase<OrderBatch>

        protected override string Name { get; } = "Weekly upcoming completions report";

        protected override string Subject { get; } = "Weekly upcoming completions report";

        protected override string Recipient { get; } = "operations@balconette.co.uk";

        protected override string Header { get; } = "Weekly upcoming completions report";

        protected override IReportFormatter<OrderBatch> Formatter { get; } = new BatchReportFormatter();

        protected override IList<OrderBatch> GetObjects()
        {
            var now = DateTime.Now;
            var max = now.AddDays(9).Date;
            var min = now.AddDays(1).Date;
            return this.session.QueryOver<OrderBatch>()
                .Where(ob => min <= ob.StaticMaxSupplyDate && ob.StaticMaxSupplyDate < max)
                .JoinQueryOver(ob => ob.Order)
                .Where(o => o.Company == Company.DefaultCompany && o.Status == Order.OrderStatus.Technical && o.PreDeliverySent == false)
                .List();
        }

        #endregion

        #region Overrides of JobBase

        public override ITrigger GetTrigger()
        {
            return TriggerBuilder.Create()
                .WithSchedule(CronScheduleBuilder
                    .AtHourAndMinuteOnGivenDaysOfWeek(16, 0, DayOfWeek.Thursday))
                .Build();
        }

        #endregion
    }
}