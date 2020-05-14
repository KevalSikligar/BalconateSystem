using System.Collections.Generic;
using System.Net.Mail;
using System.Text;
using Balcony.Miracle.Core.Services.EmailService;
using Balcony.Miracle.Data;
using EASendMail;
using Quartz;

namespace Balcony.Miracle.Server.Jobs.Reports
{
    public abstract class ReportJobBase<T> : JobBase
    {
        protected abstract string Subject { get; }

        protected abstract string Recipient { get; }

        protected abstract string Header { get; }

        protected abstract IList<T> GetObjects();

        protected abstract IReportFormatter<T> Formatter { get; }

        #region Overrides of JobBase

        protected override void Execute(IJobExecutionContext context)
        {
            var sb = new StringBuilder(10000);
            sb.Append("<div>");
            sb.AppendFormat("<h1>{0}</h1>", Header);

            NHibernateHelper.ClearCache();

            var objects = GetObjects();

            var formatResult = Formatter.Format(objects);
            sb.Append(formatResult);
            sb.Append("</div>");


            var body = sb.ToString();
            var emailManager = new EaEmailService("auth.smtp.1and1.co.uk", 25, "webmaster@balconette.co.uk", "a9215361", SmtpConnectType.ConnectSSLAuto, null);
            emailManager.SendMessage(new MailMessage("system@balconette.co.uk", Recipient, Subject, body)
            {
                IsBodyHtml = true,
            });
        }

        #endregion
    }

    public interface IReportFormatter<T>
    {
        string Format(IList<T> objects);
    }
}
