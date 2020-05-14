using System;
using System.Collections.Generic;
using Balcony.Miracle.Core;
using Balcony.Miracle.Server.Jobs.Reports.Formatters;
using Quartz;

namespace Balcony.Miracle.Server.Jobs.Reports
{
    public class DailyNotCompletedReportJob : ReportJobBase<OrderBatch>
    {
        #region Overrides of ReportJobBase<OrderBatch>

        protected override string Name { get; } = "Daily not completed report";

        protected override string Subject { get; } = "Daily not completed report";

        protected override string Recipient { get; } = "operations@balconette.co.uk";

        protected override string Header { get; } = "Daily not completed report";

        protected override IReportFormatter<OrderBatch> Formatter { get; } = new BatchReportFormatter();

        protected override IList<OrderBatch> GetObjects()
        {
            return this.session.QueryOver<OrderBatch>()
                .Where(ob => ob.StaticMaxSupplyDate <= DateTime.Now)
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
                    .AtHourAndMinuteOnGivenDaysOfWeek(12, 0, DayOfWeek.Monday, DayOfWeek.Tuesday, DayOfWeek.Wednesday, DayOfWeek.Thursday, DayOfWeek.Friday))
                .Build();
        }

        #endregion
    }
}