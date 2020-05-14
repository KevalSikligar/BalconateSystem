using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Runtime.Serialization;
using System.ServiceProcess;
using System.Text;
using System.Threading;
using System.Timers;
using System.Xml;
using Balcony.Miracle.Core;
using Balcony.Miracle.Core.Services.EmailService;
using Balcony.Miracle.Core.Services.TemplateService;
using Balcony.Miracle.Data;
using Balcony.Miracle.Server.Jobs;
using Balcony.Miracle.Server.Jobs.Reports;
using EASendMail;
using NHibernate;
using NHibernate.Context;
using log4net;
using Microsoft.Exchange.WebServices.Data;
using OfficeOpenXml;
using Quartz;
using Quartz.Impl;
using Attachment = System.Net.Mail.Attachment;
using MailAddress = System.Net.Mail.MailAddress;
using Timer = System.Timers.Timer;

namespace Balcony.Miracle.Server {

    public partial class MainService : ServiceBase {

        private ILog logger;
        private string exchangeServiceUrl;
        private string exchangeServiceUsername;
        private string exchangeServicePassword;
        private string exchangeServiceDomain;

        private Timer tmrFetchSystemActions;
        private volatile int tmrFetchSystemActionsSync;
        private Timer tmrFetchDistributionLists;
        private volatile int tmrFetchDistributionListsSync;
        private Timer tmrAutomation;
        private volatile int tmrAutomationSync;
        private static readonly Guid[] specialCampaigns = {
            new Guid("390f0d37-6fd8-e311-b145-001999ef05d8"), 
            new Guid("1eedc773-e8dd-e311-b145-001999ef05d8"),
            new Guid("cedecdf6-c55e-4fcb-8dd8-a4b601405746")
        };

        private IScheduler scheduler;

        public MainService() {
            InitializeComponent();
        }

        public ISession Session {
            get {
                if (Global.SessionFactory == null)
                    throw new InvalidOperationException("SessionFactory is null. Probably cannot connect to SQL Server.");
                lock (Global.SessionFactory) {
                    if (!CurrentSessionContext.HasBind(Global.SessionFactory)) {
                        var sess = Global.SessionFactory.OpenSession();
                        CurrentSessionContext.Bind(sess);
                    }
                    return Global.CurrentSession;
                }
            }
        }

        public void StartService() {

            try {
                log4net.Config.XmlConfigurator.Configure();

                logger = LogManager.GetLogger("root");
                AppDomain.CurrentDomain.UnhandledException += CurrentDomainOnUnhandledException;

                logger.Info("Balcony Server Started.");

                User.CurrentUserId = "system";

                do {
                    try {
                        var config = new NHibernate.Cfg.Configuration();
                        config.Configure();
                        config.AddAssembly(typeof(NHibernateHelper).Assembly);
                        Global.SessionFactory = config.BuildSessionFactory();
                    } catch(Exception ex) {
                        logger.Error("BuildSessionFactory", ex);
                        Thread.Sleep(1000);
                    }
                } while (Global.SessionFactory == null);

                this.scheduler = StdSchedulerFactory.GetDefaultScheduler();
                this.scheduler.Start();

                ConfigureJobs();

                exchangeServiceUrl = Global.GetConfigValue("ExchangeServiceUrl", "https://remote.balconette.co.uk/EWS/Exchange.asmx");
                exchangeServiceUsername = Global.GetConfigValue("ExchangeServiceUsername", "journal");
                exchangeServicePassword = Global.GetConfigValue("ExchangeServicePassword", "a9215361");
                exchangeServiceDomain = Global.GetConfigValue("ExchangeServiceDomain", "BALCONY");

                Thread.Sleep(2000);

                tmrFetchSystemActions = new Timer(Global.GetConfigValue("ActionsFetchInterval", 60000));
                tmrFetchSystemActions.Elapsed += tmrFetchSystemActions_Elapsed;
                tmrFetchSystemActions.Start();

                tmrFetchDistributionLists = new Timer(Global.GetConfigValue("DistributionListsFetchInterval", 60000));
                tmrFetchDistributionLists.Elapsed += tmrFetchDistributionLists_Elapsed;
                tmrFetchDistributionLists.Start();

                tmrAutomation = new Timer(Global.GetConfigValue("AutomationInterval", 18000));
                tmrAutomation.Elapsed += tmrAutomation_Elapsed;
                tmrAutomation.Start();
            } catch (Exception ex) {
                logger.Error("OnStart", ex);
                Stop();
            }
        }

        private void CurrentDomainOnUnhandledException(object sender, UnhandledExceptionEventArgs unhandledExceptionEventArgs)
        {
            logger.Error("General AppDomain Exception", unhandledExceptionEventArgs.ExceptionObject as Exception);
        }

        private void ConfigureJobs()
        {
            /*
            scheduler.ScheduleJob(
                JobBuilder.Create<WeeklyNoDepositPaidConfirmationReportJob>().Build(),
                TriggerBuilder.Create().StartNow().Build());

            return;
            */

            var jobTypes = typeof(JobBase).Assembly.GetTypes()
                .Where(t => !t.IsAbstract && !t.IsInterface && typeof(JobBase).IsAssignableFrom(t))
                .ToArray();

            foreach (var jobType in jobTypes)
            {
                try
                {
                    var instance = (JobBase) Activator.CreateInstance(jobType);
                    var trigger = instance.GetTrigger();

                    scheduler.ScheduleJob(
                        JobBuilder.Create(jobType).Build(),
                        trigger);
                }
                catch (Exception ex)
                {
                    this.logger.Error("Error scheduling job " + jobType.Name, ex);
                }
            }
        }

        protected override void OnStart(string[] args) {
            StartService();
        }

        void tmrFetchDistributionLists_Elapsed(object sender, ElapsedEventArgs e) {
            // ReSharper disable once CSharpWarnings::CS0420
            if (Interlocked.CompareExchange(ref tmrFetchDistributionListsSync, 1, 0) == 0) {
                try {
                    NHibernateHelper.ClearCache();

                    var emailManager = new EaEmailService(
                        Global.GetConfigValue("MARKETING_SMTP_HOST", "beeride.co.uk"),
                        Global.GetConfigValue("MARKETING_SMTP_PORT", 25),
                        Global.GetConfigValue("MARKETING_SMTP_USERNAME", "sales"),
                        Global.GetConfigValue("MARKETING_SMTP_PASSWORD", "RrBee2012ridE"),
                        Global.GetConfigValue("MARKETING_SMTP_CONNECT_TYPE", SmtpConnectType.ConnectSSLAuto),
                        Global.GetConfigValue("MARKETING_SMTP_DK_FILE", "D:\\DomainKeys\\CabmaniaMarketingDK.txt"));

                    var testEndPointAddr =
                        IPAddress.Parse(Global.GetConfigValue("MARKETING_TEST_IP_ADDRESS", "77.68.54.85"));
                    var testEndPoint = new IPEndPoint(testEndPointAddr, 0);
                    var sendEndPointAddr =
                        IPAddress.Parse(Global.GetConfigValue("MARKETING_SEND_IP_ADDRESS", "77.68.54.85"));
                    if (!Debugger.IsAttached) {
                        var sendEndPoint = new IPEndPoint(sendEndPointAddr, 0);
                        emailManager.BindEndPoint = sendEndPoint;
                    }

                    IList<EmailCampaign> newCampaigns;
                    using (Session.BeginTransaction()) {
                        newCampaigns =
                            Session.CreateQuery(
                                "select distinct c from EmailCampaign as c where c.Started = false and c.StartOn <= :now")
                                .SetParameter("now", DateTime.Now)
                                .List<EmailCampaign>();
                    }
                    if (newCampaigns.Any()) {
                        var unsubscribers = new HashSet<string>(Session.GetAll<Unsubscriber>().Select(us => us.Email),
                            StringComparer.OrdinalIgnoreCase);
                        foreach (var campaign in newCampaigns) {
                            try {
                                if (specialCampaigns.Contains(campaign.ID)) continue;
                                logger.Info("Starting " + campaign.Name);
                                int sent = 0, failed = 0;
                                var strBody = new StringBuilder(1000);
                                strBody.AppendLine("<div dir=\"ltr\">");
                                strBody.AppendLine(campaign.Body);
                                strBody.AppendLine("</div>");
                                var bodyTemplate = strBody.ToString();
                                var sentAddrs = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
                                if (campaign.IsExcel) {
                                    if (campaign.ExcelFile == null) {
                                        throw new Exception("Excel file is null");
                                    }
                                    using (var stream = new MemoryStream(campaign.ExcelFile.Data)) {
                                        using (var ep = new ExcelPackage(stream)) {
                                            if (ep.Workbook.Worksheets.Count < 1) return;
                                            var ws = ep.Workbook.Worksheets[1];
                                            if (!ws.Cells.Any()) return;
                                            var colDict = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
                                            for (var col = 1; col <= ws.Dimension.End.Column; col++) {
                                                var name = ws.Cells[1, col].Text.Replace(" ", "_");
                                                if (!colDict.ContainsKey(name)) {
                                                    colDict.Add(name, col);
                                                }
                                            }
                                            using (var trans = Session.BeginTransaction()) {
                                                try {
                                                    campaign.Total = ws.Dimension.End.Row - 1;
                                                    campaign.Started = true;
                                                    Session.SaveOrUpdate(campaign);
                                                    Session.Flush();
                                                    trans.Commit();
                                                } catch {
                                                    trans.Rollback();
                                                    throw;
                                                }
                                            }

                                            for (var row = 2; row <= ws.Dimension.End.Row; row++) {
                                                try {
                                                    var addr = ws.Cells[row, colDict["email"]].Text.Trim().ToLower();
                                                    if (String.IsNullOrEmpty(addr) || sentAddrs.Contains(addr) ||
                                                        unsubscribers.Contains(addr))
                                                        continue;
                                                    sentAddrs.Add(addr);
                                                    var props = new Dictionary<string, object>();
                                                    foreach (var kv in colDict) {
                                                        props.Add(kv.Key, ws.Cells[row, kv.Value].Value);
                                                    }
                                                    using (var mm = new MailMessage()) {
                                                        mm.From = new MailAddress(campaign.Sender, campaign.SenderName);
                                                        mm.To.Add(new MailAddress(addr));
                                                        mm.Subject = campaign.Subject;
                                                        mm.IsBodyHtml = true;
                                                        mm.Body = TemplateService.GetText(bodyTemplate, props);
                                                        foreach (var sf in campaign.Files) {
                                                            var ms = new MemoryStream(sf.Data.Length);
                                                            ms.Write(sf.Data, 0, sf.Data.Length);
                                                            ms.Seek(0, SeekOrigin.Begin);
                                                            mm.Attachments.Add(new Attachment(ms, sf.FileName));
                                                        }
                                                        bool canSend;
                                                        if (!campaign.Quick) {
                                                            try {
                                                                canSend = emailManager.CheckMailBoxExists(mm,
                                                                    testEndPoint);
                                                            } catch (Exception ex) {
                                                                logger.Error(ex.Message, ex);
                                                                canSend = true;
                                                            }
                                                        } else {
                                                            canSend = true;
                                                        }
                                                        if (canSend) {
                                                            emailManager.SendMessage(mm);
                                                            sent++;
                                                        } else {
                                                            failed++;
                                                        }
                                                    }
                                                    Thread.Sleep(100);
                                                } catch (Exception ex) {
                                                    logger.Error(ex.Message, ex);
                                                    failed++;
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    var sr = new StringReader(campaign.Params);
                                    var reader = XmlReader.Create(sr);
                                    var deserializer = new DataContractSerializer(typeof (Dictionary<string, object>));
                                    var dic = (Dictionary<string, object>) deserializer.ReadObject(reader);
                                    reader.Close();
                                    var q = Session.CreateQuery(campaign.HQL + " and (cnt.Unsubscribed = false)");
                                    foreach (var d in dic) {
                                        q.SetParameter(d.Key, d.Value);
                                    }
                                    IList<Customer> customers;
                                    using (Session.BeginTransaction()) {
                                        customers = q.List<Customer>();
                                    }
                                    var list = new HashSet<CustomerContact>(CustomerContact.EmailComparator);
                                    using (Session.BeginTransaction()) {
                                        foreach (var customer in customers) {
                                            list.UnionWith(customer.CustomerContacts);
                                        }
                                    }
                                    using (var trans = Session.BeginTransaction()) {
                                        try {
                                            campaign.Total = list.Count;
                                            campaign.Started = true;
                                            Session.SaveOrUpdate(campaign);
                                            Session.Flush();
                                            trans.Commit();
                                        } catch {
                                            trans.Rollback();
                                            throw;
                                        }
                                    }
                                    foreach (var contact in list) {
                                        try {
                                            var addr = contact.DefaultEmail ?? "";
                                            addr = addr.Trim().ToLower();
                                            if (String.IsNullOrEmpty(addr) || sentAddrs.Contains(addr) ||
                                                unsubscribers.Contains(addr))
                                                continue;
                                            sentAddrs.Add(addr);
                                            using (var mm = new MailMessage()) {
                                                mm.From = new MailAddress(campaign.Sender, campaign.SenderName);
                                                mm.To.Add(new MailAddress(addr));
                                                mm.Subject = campaign.Subject;
                                                mm.IsBodyHtml = true;
                                                mm.Body = TemplateService.GetText(bodyTemplate, contact);
                                                foreach (var sf in campaign.Files) {
                                                    var ms = new MemoryStream(sf.Data.Length);
                                                    ms.Write(sf.Data, 0, sf.Data.Length);
                                                    ms.Seek(0, SeekOrigin.Begin);
                                                    mm.Attachments.Add(new Attachment(ms, sf.FileName));
                                                }
                                                bool canSend;
                                                if (!campaign.Quick) {
                                                    try {
                                                        canSend = emailManager.CheckMailBoxExists(mm, testEndPoint);
                                                    } catch (Exception ex) {
                                                        logger.Error(ex.Message, ex);
                                                        canSend = true;
                                                    }
                                                } else {
                                                    canSend = true;
                                                }
                                                if (canSend) {
                                                    logger.InfoFormat("Email to {0}", addr);
                                                    emailManager.SendMessage(mm);
                                                    logger.Info("Email done");
                                                    sent++;
                                                } else {
                                                    failed++;
                                                }
                                            }
                                            Thread.Sleep(100);
                                        } catch (Exception ex) {
                                            logger.Error(ex.Message, ex);
                                            failed++;
                                        }
                                    }
                                }

                                using (var trans = Session.BeginTransaction()) {
                                    try {
                                        Session.Refresh(campaign);
                                        campaign.Sent = sent;
                                        campaign.Failed = failed;
                                        Session.SaveOrUpdate(campaign);
                                        Session.Flush();
                                        trans.Commit();
                                    } catch {
                                        trans.Rollback();
                                        throw;
                                    }
                                }
                            } catch (Exception ex) {
                                logger.Error("campaign " + campaign.Name + " error", ex);
                            }
                        }
                    }
                } catch (Exception ex) {
                    logger.Error("tmrFetchDistributionLists_Elapsed", ex);
                } finally {
                    DisposeSession();
                    tmrFetchDistributionListsSync = 0;
                }
            }
        }

        void tmrAutomation_Elapsed(object sender, ElapsedEventArgs e) {
            // ReSharper disable once CSharpWarnings::CS0420
            if (Interlocked.CompareExchange(ref tmrAutomationSync, 1, 0) == 0) {
                try {
                    NHibernateHelper.ClearCache();

                    var emailManager = new EaEmailService("auth.smtp.1and1.co.uk", 25, "webmaster@balconette.co.uk", "a9215361", SmtpConnectType.ConnectSSLAuto, null);

                    // changes batch status
                    using (var trans = Session.BeginTransaction()) {
                        try {
                            var batches = Session.CreateQuery(@"select distinct ob 
                                                            from OrderBatch as ob 
                                                            where ob.Status = :bst and ob.Order.Status = :ost")
                                .SetParameter("bst", OrderBatch.BatchStatus.Purchasing)
                                .SetParameter("ost", Order.OrderStatus.Technical)
                                .List<OrderBatch>();
                            var lst = new List<OrderBatch>();
                            foreach (var batch in batches) {
                                if (batch.IsReadyInWarehouse) {
                                    logger.InfoFormat("tmrAutomation_Elapsed: Changing batch #{0} to 'Ready In Warehouse'", batch.Code);
                                    batch.Status = OrderBatch.BatchStatus.Ready_In_Warehouse;
                                    Session.SaveOrUpdate(batch);
                                    lst.Add(batch);
                                }
                            }

                            Session.Flush();
                            trans.Commit();

                            if (lst.Count > 0) {
                                // send email
                                var sb = new StringBuilder(5000);
                                sb.AppendFormat("<html>");
                                sb.AppendFormat("<body>");
                                sb.AppendFormat("<div dir=\"ltr\">");
                                sb.AppendFormat(
                                    "<h1>The following batches were changed to status: Ready In Warehouse</h1>");
                                sb.AppendFormat("<ul>");
                                foreach (var batch in lst) {
                                    sb.AppendFormat("<li>#{0} - {1}</li>", batch.Code, batch.Order.CustomerName);
                                }
                                sb.AppendFormat("</ul>");
                                sb.AppendFormat("</div>");
                                sb.AppendFormat("</body>");
                                sb.AppendFormat("</html>");

                                using (var mm = new MailMessage()) {
                                    mm.From = new MailAddress("system@balconette.co.uk", "Miracle System");
                                    mm.To.Add(new MailAddress("logistics@balconette.co.uk"));
                                    mm.Subject = "Batches changed their status";
                                    mm.IsBodyHtml = true;
                                    mm.Body = sb.ToString();
                                    emailManager.SendMessage(mm);
                                }
                            }
                        } catch (Exception ex) {
                            if (!trans.WasCommitted) {
                                trans.Rollback();
                            }
                            logger.Error("tmrAutomation_Elapsed - batch status chaging", ex);
                        }
                    }                    

                    var now = DateTime.Now;
                    if (now.Hour == 12 && 0 <= now.Minute && now.Minute < 5 && now.DayOfWeek != DayOfWeek.Sunday && now.DayOfWeek != DayOfWeek.Saturday) {
                        var unsubscribers = new HashSet<string>(Session.GetAll<Unsubscriber>().Select(us => us.Email), StringComparer.OrdinalIgnoreCase);

                        var campaigns = new EmailCampaign[specialCampaigns.Length];
                        var lists = new IList<Customer>[specialCampaigns.Length];
                        for (var i = 0; i < specialCampaigns.Length; i++) {
                            campaigns[i] = Session.Get<EmailCampaign>(specialCampaigns[i]);
                            lists[i] = new List<Customer>();
                        }                        
                        
                        // Web Quotes Campaign
                        if (campaigns[0].Started) {
                            using (var trans = Session.BeginTransaction()) {
                                try {
                                    var minDate = DateTime.Now.AddDays(-14).Date;
                                    var maxDate = DateTime.Now.AddDays(-1).DayEnd();
                                    var quotes = Session.QueryOver<Quote>()
                                        .Where(q => q.Company.ID == "A" && minDate <= q.DateCreated && q.DateCreated < maxDate && q.EFollowUpCheck == false)
                                        .JoinQueryOver(q => q.CreatedUser)
                                        .Where(u => u.IsWebsite)                                        
                                        .List();
                                    foreach (var quote in quotes) {
                                        // check if customer was already emailed in the last 48 hours
                                        if (quote.Customer.LastAutoEmail == null || quote.Customer.LastAutoEmail.Value < now.AddDays(-2).Date) {
                                            var q = quote;
                                            if (!quote.Customer.Orders.Any(o => o.DateCreated >= q.DateCreated) && !quote.Customer.Invoices.Any(i => i.DateCreated >= q.DateCreated)) {
                                                quote.Customer.LastAutoEmail = now;
                                                Session.SaveOrUpdate(quote.Customer);
                                                lists[0].Add(quote.Customer);
                                            } else {
                                                logger.WarnFormat("WebQuotes campaign - Customer: '{0}' Rejected due to existance of future orders or invoices", quote.Customer.Code);
                                            }
                                        } else {
                                            logger.WarnFormat("WebQuotes campaign - Customer: '{0}' Rejected due to LastAutoEmail: '{1}'", quote.Customer.Code, quote.Customer.LastAutoEmail);
                                        }
                                        quote.EFollowUpCheck = true;
                                        Session.SaveOrUpdate(quote);
                                        Session.Flush();
                                    }
                                    trans.Commit();
                                } catch (Exception ex) {
                                    trans.Rollback();
                                    lists[0] = new List<Customer>();
                                    logger.Error("tmrAutomation_Elapsed - web quotes follow up", ex);
                                }
                            }
                        }

                        // Request Brochures Campaign
                        if (campaigns[1].Started) {
                            using (var trans = Session.BeginTransaction()) {
                                try {
                                    var minDate = DateTime.Now.AddDays(-18).Date;
                                    var maxDate = DateTime.Now.AddDays(-9).DayEnd();
                                    var events = Session.QueryOver<Event>().Where(ev => ev.EventType.ID == 2 && minDate <= ev.DateCreated && ev.DateCreated < maxDate && ev.EFollowUpCheck == false).List();
                                    foreach (var evnt in events) {
                                        // check if customer was already emailed in the last 48 hours
                                        if (evnt.Customer.LastAutoEmail == null || evnt.Customer.LastAutoEmail.Value < now.AddDays(-2).Date) {
                                            var ev = evnt;
                                            if (!evnt.Customer.Quotes.Any(q => q.DateCreated >= ev.DateCreated && q.CreatedUser.IsWebsite) && !evnt.Customer.Orders.Any(o => o.DateCreated >= ev.DateCreated) && !evnt.Customer.Invoices.Any(i => i.DateCreated >= ev.DateCreated)) {
                                                evnt.Customer.LastAutoEmail = now;
                                                Session.SaveOrUpdate(evnt.Customer);
                                                lists[1].Add(evnt.Customer);
                                            } else {
                                                logger.WarnFormat("Brochure Requests campaign - Customer: '{0}' Rejected due to existance of future web-quotes, orders or invoices", evnt.Customer.Code);
                                            }
                                        } else {
                                            logger.WarnFormat("Brochure Requests campaign - : '{0}' Rejected due to LastAutoEmail: '{1}'", evnt.Customer.Code, evnt.Customer.LastAutoEmail);
                                        }
                                        evnt.EFollowUpCheck = true;
                                        Session.SaveOrUpdate(evnt);
                                        Session.Flush();
                                    }
                                    trans.Commit();
                                } catch (Exception ex) {
                                    trans.Rollback();
                                    lists[1] = new List<Customer>();
                                    logger.Error("tmrAutomation_Elapsed - brochure requests follow up", ex);
                                }
                            }
                        }

                        // Digital Request Brochures Campaign
                        if (campaigns[2].Started) {
                            using (var trans = Session.BeginTransaction()) {
                                try {
                                    var minDate = DateTime.Now.AddDays(-14).Date;
                                    var maxDate = DateTime.Now.AddDays(-1).DayEnd();
                                    var events = Session.QueryOver<Event>().Where(ev => ev.EventType.ID == 42 && minDate <= ev.DateCreated && ev.DateCreated < maxDate && ev.EFollowUpCheck == false).List();
                                    foreach (var evnt in events) {
                                        // check if customer was already emailed in the last 48 hours
                                        if (evnt.Customer.LastAutoEmail == null || evnt.Customer.LastAutoEmail.Value < now.AddDays(-2).Date) {
                                            var ev = evnt;
                                            if (!evnt.Customer.Quotes.Any(q => q.DateCreated >= ev.DateCreated && q.CreatedUser.IsWebsite) && 
                                                !evnt.Customer.Orders.Any(o => o.DateCreated >= ev.DateCreated) && 
                                                !evnt.Customer.Invoices.Any(i => i.DateCreated >= ev.DateCreated) && 
                                                !evnt.Customer.RawCustomerEvents.Any(ce => ce.DateCreated >= ev.DateCreated && ce.EventType.ID == 2)) {
                                                
                                                evnt.Customer.LastAutoEmail = now;
                                                Session.SaveOrUpdate(evnt.Customer);
                                                lists[2].Add(evnt.Customer);
                                            } else {
                                                logger.WarnFormat("Digital Brochure Requests campaign - Customer: '{0}' Rejected due to existance of future web-quotes, orders or invoices", evnt.Customer.Code);
                                            }
                                        } else {
                                            logger.WarnFormat("Digital Brochure Requests campaign - Customer: '{0}' Rejected due to LastAutoEmail: '{1}'", evnt.Customer.Code, evnt.Customer.LastAutoEmail);
                                        }
                                        evnt.EFollowUpCheck = true;
                                        Session.SaveOrUpdate(evnt);
                                        Session.Flush();
                                    }
                                    trans.Commit();
                                } catch (Exception ex) {
                                    trans.Rollback();
                                    lists[2] = new List<Customer>();
                                    logger.Error("tmrAutomation_Elapsed - digital brochure requests follow up", ex);
                                }
                            }
                        }













                        for (var i = 0; i < campaigns.Length; i++) {
                            var campaign = campaigns[i];
                            var list = lists[i];
                            if (campaign != null) {
                                var sentAddrs = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
                                var strBody = new StringBuilder(1000);
                                strBody.AppendLine("<div dir=\"ltr\">");
                                strBody.AppendLine(campaign.Body);
                                strBody.AppendLine("</div>");
                                var bodyTemplate = strBody.ToString();
                                // send emails
                                foreach (var customer in list) {
                                    try {
                                        var addr = customer.DefaultEmail ?? "";
                                        addr = addr.Trim().ToLower();
                                        if (String.IsNullOrEmpty(addr) || sentAddrs.Contains(addr) || unsubscribers.Contains(addr)) {
                                            logger.WarnFormat("Address: '{0}' is invalid or unsubscribed.", addr);
                                            continue;
                                        }
                                        sentAddrs.Add(addr);
                                        using (var mm = new MailMessage()) {
                                            mm.From = new MailAddress(campaign.Sender, campaign.SenderName);
                                            mm.To.Add(new MailAddress(addr));
                                            mm.Bcc.Add("information@balconette.co.uk");
                                            mm.Subject = campaign.Subject;
                                            mm.IsBodyHtml = true;
                                            mm.Body = TemplateService.GetText(bodyTemplate, customer.DefaultContact);
                                            foreach (var sf in campaign.Files) {
                                                var ms = new MemoryStream(sf.Data.Length);
                                                ms.Write(sf.Data, 0, sf.Data.Length);
                                                ms.Seek(0, SeekOrigin.Begin);
                                                mm.Attachments.Add(new Attachment(ms, sf.FileName));
                                            }
                                            emailManager.SendMessage(mm);
                                        }
                                    } catch (Exception ex) {
                                        logger.Warn("tmrAutomation_Elapsed - error sending campaign email " + ex.Message + "\n" + ex.StackTrace);
                                    }
                                }
                            } else {
                                logger.Warn("tmrAutomation_Elapsed - campaign " + i + " not found");
                            }
                        }
                    }
                } catch (Exception ex) {
                    logger.Error("tmrAutomation_Elapsed", ex);
                } finally {
                    DisposeSession();
                    tmrAutomationSync = 0;
                }
            }
        }

        void tmrFetchSystemActions_Elapsed(object sender, ElapsedEventArgs e) {
            // ReSharper disable once CSharpWarnings::CS0420
            if (Interlocked.CompareExchange(ref tmrFetchSystemActionsSync, 1, 0) == 0) {
                try {
                    NHibernateHelper.ClearCache();

                    var service = new ExchangeService(ExchangeVersion.Exchange2007_SP1);
                    service.Credentials = new NetworkCredential(exchangeServiceUsername, exchangeServicePassword,
                        exchangeServiceDomain);
                    service.Url = new Uri(exchangeServiceUrl);
                    service.AcceptGzipEncoding = true;

                    using (var trans = Session.BeginTransaction()) {
                        try {
                            var actions = Session.CreateQuery(@"select distinct act 
                                                                from SystemAction as act 
                                                                where act.Done = false and act.CommitOn <= :now")
                                .SetParameter("now", DateTime.UtcNow)
                                .List<SystemAction>();
                            foreach (var action in actions) {
                                if (action.ItemType == ActionItemType.System_Email ||
                                    action.ItemType == ActionItemType.System_Task) {
                                    try {
                                        var m = new EmailMessage(service);
                                        m.Body = new MessageBody(BodyType.HTML, action.Body);
                                        m.Subject = "Task: " + action.Subject;
                                        m.ToRecipients.AddRange(action.Recipients.Split(";".ToCharArray(),
                                            StringSplitOptions.RemoveEmptyEntries));
                                        if (action.ItemType == ActionItemType.System_Task) {
                                            m.Importance = Importance.High;
                                            var attachment = m.Attachments.AddItemAttachment<Task>();
                                            attachment.Name = "Task";
                                            attachment.Item.Subject = action.Subject;
                                            attachment.Item.Body = new MessageBody(BodyType.HTML, action.Body);
                                        }
                                        m.Send();
                                        action.Done = true;
                                    } catch (Exception ex) {
                                        if (action.Retries > 3) {
                                            action.ErrorMsg = ex.Message;
                                            action.Done = true;
                                        } else {
                                            action.Retries = action.Retries + 1;
                                        }
                                    }
                                }
                            }
                            Session.Flush();
                            trans.Commit();
                        } catch (Exception) {
                            trans.Rollback();
                            throw;
                        }
                    }
                } catch (Exception ex) {
                    logger.Error("tmrFetchSystemActions_Elapsed", ex);
                } finally {
                    DisposeSession();
                    tmrFetchSystemActionsSync = 0;
                }
            }
        }

        protected void DisposeSession() {
            Session.Dispose();
            CurrentSessionContext.Unbind(Global.SessionFactory);
        }

        protected override void OnStop() {
            try
            {
                this.scheduler.Shutdown(waitForJobsToComplete: true);

                tmrFetchSystemActions.Stop();
                tmrFetchDistributionLists.Stop();
                tmrAutomation.Stop();

                // ReSharper disable CSharpWarnings::CS0420
                while (Interlocked.CompareExchange(ref tmrFetchSystemActionsSync, -1, 0) != 0)
                {
                    Thread.Sleep(200);
                }
                while (Interlocked.CompareExchange(ref tmrFetchDistributionListsSync, -1, 0) != 0)
                {
                    Thread.Sleep(200);
                }
                while (Interlocked.CompareExchange(ref tmrAutomationSync, -1, 0) != 0)
                {
                    Thread.Sleep(200);
                }
                // ReSharper restore CSharpWarnings::CS0420

                tmrFetchSystemActions.Dispose();
                tmrFetchDistributionLists.Dispose();
                tmrAutomation.Dispose();

                logger.Info("Balcony Server Stopped.");
            }
            catch (Exception ex)
            {
                this.logger.Error("Error stopping service", ex);
            }
        }

        public void Start() {
            OnStart(null);
        }

        public void StopService() {
            OnStop();
        }

    }
}
