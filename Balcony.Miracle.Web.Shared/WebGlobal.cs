using System;
using System.Configuration;
using System.Linq;
using System.Collections.Generic;
using System.IO;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Balcony.Miracle.Core;
using Balcony.Miracle.Core.Services.TemplateService;
using Balcony.Miracle.Data;
using CardinalCommerce;
using com.paypal.sdk.profiles;
using com.paypal.sdk.services;
using com.paypal.soap.api;
using NHibernate;

namespace Balcony.Miracle.Web.Shared {

    public class WebGlobal {

        public static string OurAddress = "Balcony Systems Solutions Limited<br/>Unit 6 Systems House<br />Eastbourne Road<br />Blindley Heath<br />Lingfield, Surrey<br />RH7 6JP<br />Tel: 01342 410411<br />Fax: 01342 410412";
        public static string SalesMail = "sales@balconette.co.uk";
        public static string BrochuresMail = "brochures@balconette.co.uk";
        public static string AmbassadorMail = "ambassador@balconette.co.uk";
        public static string OurVATREG = "975 6213 93";
        public static string SystemMail = "system@balconette.co.uk";

        private static int? appid;
        public static int AppId {
            get {
                if (appid == null) {
                    try {
                        appid = Int32.Parse(ConfigurationManager.AppSettings["AppId"]);                        
                    } catch {
                        appid = 0;
                    }
                }
                return appid.Value;
            }
        }

        private static User websiteUser;
        public static User WebsiteUser {
            get {
                if (websiteUser == null) {
                    var session = NHibernateHelper.OpenSession();
                    websiteUser = session.CurrentUser();
                }
                return websiteUser;
            }
        }

        private static readonly Guid onlineQuoteMailTemplateId = new Guid("905399b2-f371-e111-8c38-58b0358c18e0");
        public static Guid OnlineQuoteMailTemplateId {
            get {
                return onlineQuoteMailTemplateId;
            }
        }

        private static readonly Guid onlineQuoteTemplateId = new Guid("99ac6541-214f-4235-864a-a19600bad880");
        public static Guid OnlineQuoteTemplateId {
            get {
                return onlineQuoteTemplateId;
            }
        }

        private static readonly Guid quoteTemplateId = new Guid("b074004b-ead9-428e-92fe-9f6300c829a0");
        public static Guid QuoteTemplateId {
            get {
                return quoteTemplateId;
            }
        }


        private static readonly Guid onlineQuoteSummaryTemplateId = new Guid("47db5ab0-8e4a-4a24-a60b-9f930107b117");
        public static Guid OnlineQuoteSummaryTemplateId {
            get {
                return onlineQuoteSummaryTemplateId;
            }
        }


        private static readonly Guid onlineOrderTemplateId = new Guid("0bbb03a7-48a5-4f54-86df-a01d00b98f91");
        public static Guid OnlineOrderTemplateId {
            get {
                return onlineOrderTemplateId;
            }
        }

        private static CustomerSource websiteSource;
        public static CustomerSource WebsiteSource {
            get {
                if (websiteSource == null) {
                    var session = NHibernateHelper.OpenSession();
                    websiteSource = session.Get<CustomerSource>(1);
                }
                return websiteSource;
            }
        }

        private static Company companySolutions;
        public static Company CompanySolutions {
            get {
                if (companySolutions == null) {
                    var session = NHibernateHelper.OpenSession();
                    companySolutions = session.Get<Company>("A");
                }
                return companySolutions;
            }
        }
        public static Customer CreateFastCustomer(ISession sess, string email, string firstName, string lastName) {
            return CreateFastCustomer(sess, email, firstName, lastName, null);
        }

        public static Customer CreateFastCustomer(ISession sess, string email, string firstName, string lastName, string phone) {
            var cus = new Customer(sess.CurrentUser());
            cus.Name = firstName + " " + lastName;
            cus.CreatedUser = WebsiteUser;
            cus.CustomerSource = WebsiteSource;
            cus.ACID = DateTime.Now.ToString("%d%H%m%s");

            var contact = cus.RawCustomerContacts[0];
            contact.FirstName = firstName;
            contact.LastName = lastName;
            contact.PrimaryPhone = phone ?? "";
            contact.Email = email;
            cus.RawEmailAddresses.Add(new CustomerEmailAddress { Customer = cus, EmailAddress = email });
            sess.SaveOrUpdate(cus);
            sess.Flush();
            cus.SetNumber();
            sess.Flush();


            var nce = new Event();
            nce.Customer = cus;
            nce.EventType = sess.Get<EventType>(1);
            nce.User = WebsiteUser;
            nce.Name = "New Customer";
            nce.RefID = cus.ID;
            nce.Status = Event.EventStatus.Open;
            sess.SaveOrUpdate(nce);
            sess.Flush();

            return cus;
        }

        public static string GetSessionCookie(HttpContext context) {
            if (context == null || context.Session == null)
                return null;            
            if (context.Request.Cookies["SessionID"] == null) {
                context.Response.Cookies.Add(new HttpCookie("SessionID", context.Session.SessionID) {
                    Expires = DateTime.Now.AddDays(29),
                    Secure = context.Request.IsSecureConnection,
                    HttpOnly = true
                });
                return context.Session.SessionID;
            }
            return context.Request.Cookies["SessionID"].Value;
        }

        public static DoDirectPaymentRequestType PreparePaypalRequest(Invoice invoice,
            Address cardHolderAddress,
            string cardNo,
            CreditCardTypeType cardType,
            string cvv2,
            int expMonth,
            int expYear,
            int strtMonth,
            int strtYear,
            string issueNum,
            bool is3Ds,
            string xid,
            string eci,
            string cavv,
            string mpivendor,
            string authStatus) {

            var sumtopay = invoice.Total;
            var pp_Request = new DoDirectPaymentRequestType();
            //Create the request details object
            pp_Request.DoDirectPaymentRequestDetails = new DoDirectPaymentRequestDetailsType();
            pp_Request.DoDirectPaymentRequestDetails.IPAddress = "87.106.67.20";
            pp_Request.DoDirectPaymentRequestDetails.MerchantSessionId = "1X911810264059055";
            pp_Request.DoDirectPaymentRequestDetails.PaymentAction = PaymentActionCodeType.Sale;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard = new CreditCardDetailsType();
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CreditCardNumber = cardNo;
            //Card Type
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CreditCardType = cardType;
            //CVV and Expirition
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CVV2 = cvv2;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.ExpMonth = expMonth;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.ExpYear = expYear;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.ExpMonthSpecified = true;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.ExpYearSpecified = true;
            //Switch or Solo details
            if (cardType == CreditCardTypeType.Visa || cardType == CreditCardTypeType.Solo) {
                pp_Request.DoDirectPaymentRequestDetails.CreditCard.StartMonth = strtMonth;
                pp_Request.DoDirectPaymentRequestDetails.CreditCard.StartYear = strtYear;
                pp_Request.DoDirectPaymentRequestDetails.CreditCard.StartMonthSpecified = true;
                pp_Request.DoDirectPaymentRequestDetails.CreditCard.StartYearSpecified = true;
                pp_Request.DoDirectPaymentRequestDetails.CreditCard.IssueNumber = issueNum;
            }
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner = new PayerInfoType();
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Payer = "";
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.PayerID = "";
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.ContactPhone = invoice.Customer.DefaultContact.PrimaryPhoneString;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.PayerStatus = PayPalUserStatusCodeType.unverified;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.PayerCountry = CountryCodeType.GB;
            //Card owner address
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Address = new AddressType();
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Address.Street1 = cardHolderAddress.House;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Address.Street2 = cardHolderAddress.Street;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Address.CityName = cardHolderAddress.City;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Address.PostalCode = cardHolderAddress.Postcode;
            
            if (cardHolderAddress.Country != null) {
                pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Address.CountryName = cardHolderAddress.Country.Name_En;
                pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Address.Country = (CountryCodeType) Enum.Parse(typeof(CountryCodeType), cardHolderAddress.Country.ShortName_En, true);
                pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.Address.CountrySpecified = true;
            }

            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.PayerName = new PersonNameType();
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.PayerName.FirstName = invoice.Customer.DefaultContact.FirstName;
            pp_Request.DoDirectPaymentRequestDetails.CreditCard.CardOwner.PayerName.LastName = invoice.Customer.DefaultContact.LastName;
            pp_Request.DoDirectPaymentRequestDetails.PaymentDetails = new PaymentDetailsType();
            pp_Request.DoDirectPaymentRequestDetails.PaymentDetails.OrderTotal = new BasicAmountType();
            pp_Request.DoDirectPaymentRequestDetails.PaymentDetails.OrderTotal.currencyID = CurrencyCodeType.GBP;
            pp_Request.DoDirectPaymentRequestDetails.PaymentDetails.OrderTotal.Value = sumtopay.ToString("0.00");

            if (is3Ds) {
                //3D Secure details
                pp_Request.DoDirectPaymentRequestDetails.CreditCard.ThreeDSecureRequest = new ThreeDSecureRequestType();
                pp_Request.DoDirectPaymentRequestDetails.CreditCard.ThreeDSecureRequest.Xid = xid;
                pp_Request.DoDirectPaymentRequestDetails.CreditCard.ThreeDSecureRequest.Eci3ds = eci;
                pp_Request.DoDirectPaymentRequestDetails.CreditCard.ThreeDSecureRequest.Cavv = cavv;
                pp_Request.DoDirectPaymentRequestDetails.CreditCard.ThreeDSecureRequest.MpiVendor3ds = mpivendor;
                pp_Request.DoDirectPaymentRequestDetails.CreditCard.ThreeDSecureRequest.AuthStatus3ds = authStatus;
            }

            return pp_Request;
        }

        public static DoDirectPaymentResponseType ProcessRequest(DoDirectPaymentRequestType request) {
            var profile = ProfileFactory.createSignatureAPIProfile();
            profile.APIUsername = CompanySolutions.PayPalApiUsername;
            profile.APIPassword = CompanySolutions.PayPalApiPassword;
            profile.APISignature = CompanySolutions.PayPalApiSignature;
            profile.Environment = "Live";
            profile.Subject = "Online Transaction";
            var caller = new CallerServices();
            caller.APIProfile = profile;
            return (DoDirectPaymentResponseType)caller.Call("DoDirectPayment", request);
        }        

       

        public static void ProcessOrder(HttpContext context, ISession sess, Invoice invoice, Payment.PaymentKind paymentKind, string PP_3DS_CAVV, string PP_3DS_ECI, string PP_3DS_Enrolled, string PP_3DS_Vpas, string PP_3DS_XID, string PP_AVS, string PP_Correlation, string PP_CVV2, string PP_Transaction) {
            sess.SaveOrUpdate(invoice.Order);
            sess.Flush();
            var orderEvent = new Event();
            orderEvent.Customer = invoice.Customer;
            orderEvent.User = WebsiteUser;
            orderEvent.EventType = sess.Get<EventType>(7);
            orderEvent.Name = "Online Order " + invoice.Order.Code;
            orderEvent.RefID = invoice.Order.ID;
            sess.SaveOrUpdate(orderEvent);

            sess.SaveOrUpdate(invoice);
            sess.Flush();
            var invoiceEvent = new Event();
            invoiceEvent.Customer = invoice.Customer;
            invoiceEvent.User = WebsiteUser;
            invoiceEvent.EventType = sess.Get<EventType>(8);
            invoiceEvent.Name = "Online Invoice " + invoice.Code;
            invoiceEvent.RefID = invoice.ID;
            sess.SaveOrUpdate(invoiceEvent);


            var payment = new Payment(invoice, sess.CurrentUser());
            payment.CreatedUser = WebsiteUser;
            payment.PP_3DS_CAVV = PP_3DS_CAVV;
            payment.PP_3DS_ECI = PP_3DS_ECI;
            payment.PP_3DS_Enrolled = PP_3DS_Enrolled;
            payment.PP_3DS_Vpas = PP_3DS_Vpas;
            payment.PP_3DS_XID = PP_3DS_XID;
            payment.PP_AVS = PP_AVS;
            payment.PP_Correlation = PP_Correlation;
            payment.PP_CVV2 = PP_CVV2;
            payment.PP_Transaction = PP_Transaction;
            payment.PaymentType = paymentKind;
            sess.SaveOrUpdate(payment);
            sess.Flush();
            var paymentEvent = new Event();
            paymentEvent.Customer = invoice.Customer;
            paymentEvent.User = WebsiteUser;
            paymentEvent.EventType = sess.Get<EventType>(9);
            paymentEvent.Name = "Online Payment " + payment.Code;
            paymentEvent.RefID = payment.ID;
            sess.SaveOrUpdate(paymentEvent);
            sess.Flush();


            // numbers
            invoice.Order.SetNumber();
            sess.Flush();
            invoice.SetNumber();
            sess.Flush();
            payment.SetNumber();
            sess.Flush();

            try {
                var mBody = MailTemplate(TemplateService.GetText(sess.Get<Template>(OnlineOrderTemplateId).Body, invoice.Order));
                var message = new MailMessage(SalesMail, invoice.Order.Customer.Email, "Balcony Systems Solutions Ltd Online Transaction No. " + invoice.Order.Code, mBody);
                message.IsBodyHtml = true;
                message.Bcc.Add(SalesMail);

                var onlineApprovedBalustrades = 0;
                var fAttachs = new HashSet<string>();
                foreach (var line in invoice.Order.RawOrderLines) {
                    try {
                        var jul = line.ProductDetails as Juliette;
                        string fp;
                        if (jul != null && jul.IsStandard) {

                            fp = context.Server.MapPath("/Products/Juliette/Juliette-technical-and-delivery-appendix.pdf");
                            if (fAttachs.Add(fp))
                                message.Attachments.Add(new Attachment(fp));

                            fp = context.Server.MapPath(String.Format("/products/juliette/elevations/{0}/{1}BAL{2}.pdf", jul.JulietteType.ID, jul.JulietteType.NamePrefix, jul.Width / 10));
                            if (fAttachs.Add(fp))
                                message.Attachments.Add(new Attachment(fp));

                            fp = context.Server.MapPath("/Products/Juliette/A personal message to you from the Managing Director.pdf");
                            if (fAttachs.Add(fp))
                                message.Attachments.Add(new Attachment(fp));

                        }

                        if (line.ProductDetails is Accessory) {
                            fp = context.Server.MapPath("/pdfs/BalcoNano information page.pdf");
                            if (fAttachs.Add(fp)) 
                                message.Attachments.Add(new Attachment(fp));
                            
                        }

                        try
                        {
                            var balustrade = line.ProductDetails as Balustrade;
                            if (balustrade != null && balustrade.OnlineDrawingApproved)
                            {

                                try
                                {
                                    var exporter = new ProductLinesContainerExporter();
                                    var fileName = invoice.Order.Code + "_" + DateTime.Now.ToString("yyyy_MM_dd_HH_mm") + ".tab";
                                    Global.DelimitedExport(exporter.GetExportHeaders(), exporter.GetExportRows(invoice.Order), Path.Combine(@"E:\Www_root\OfficeImport\DWimports", fileName), "\t");
                                }
                                catch (Exception ex)
                                {
                                    HandleException(ex, context);
                                }

                                onlineApprovedBalustrades += 1;

                                var withPosts = balustrade.RawBalustradeSections.Any(s => s.Posts.Count > 0);
                                var noHandrail = balustrade.BalustradeSystem.HandrailSystem.ID == ProfileSystem.NO_PROFILE_ID;

                                // Handrail and Posts Dimensions
                                if (!noHandrail)
                                {
                                    balustrade.CurrentViewIndex = 1;
                                    message.Attachments.Add(CreateBalustradePdfAttachment(balustrade, "Handrail and Posts Dimensions", String.Format("Balustrade {0} Handrail and Posts Dimensions.pdf", onlineApprovedBalustrades)));
                                }

                                // Bottom Rail Dimensions
                                balustrade.CurrentViewIndex = 2;
                                message.Attachments.Add(CreateBalustradePdfAttachment(balustrade, "Bottom Rail Dimensions", String.Format("Balustrade {0} Bottom Rail Dimensions.pdf", onlineApprovedBalustrades)));

                                // Bottom Rail Dimensions
                                balustrade.CurrentViewIndex = 3;
                                message.Attachments.Add(CreateBalustradePdfAttachment(balustrade, "Glass Dimensions", String.Format("Balustrade {0} Glass Dimensions.pdf", onlineApprovedBalustrades)));

                                // Height and Section
                                fp = context.Server.MapPath(String.Format("/pdfs/balustrade-drawing/system-sections/{0}.pdf", balustrade.BalustradeSystem.ID));
                                if (fAttachs.Add(fp))
                                {
                                    message.Attachments.Add(new Attachment(fp)
                                    {
                                        Name = String.Format("{0} Height and Section.pdf", balustrade.BalustradeSystem.Name_En)
                                    });
                                }

                                // Post Section
                                if (withPosts)
                                {
                                    fp = context.Server.MapPath(String.Format("/pdfs/balustrade-drawing/post-sections/{0}.pdf", balustrade.BalustradeSystem.ID));
                                    if (fAttachs.Add(fp))
                                    {
                                        message.Attachments.Add(new Attachment(fp)
                                        {
                                            Name = String.Format("{0} Post Section.pdf", balustrade.BalustradeSystem.Name_En)
                                        });
                                    }
                                }

                                fp = context.Server.MapPath(String.Format("/pdfs/balustrade-drawing/{0}/{1}.pdf", GetBalustradeStartFinishPdfName(balustrade), balustrade.BalustradeSystem.ID));
                                message.Attachments.Add(new Attachment(fp)
                                {
                                    Name = String.Format("Balustrade {0} End Detail - Left.pdf", onlineApprovedBalustrades)
                                });

                                fp = context.Server.MapPath(String.Format("/pdfs/balustrade-drawing/{0}/{1}.pdf", GetBalustradeEndFinishPdfName(balustrade), balustrade.BalustradeSystem.ID));
                                message.Attachments.Add(new Attachment(fp)
                                {
                                    Name = String.Format("Balustrade {0} End Detail - Right.pdf", onlineApprovedBalustrades)
                                });

                                if (onlineApprovedBalustrades == 1)
                                {
                                    fp = context.Server.MapPath("/pdfs/balustrade-drawing/technical-and-delivery-appendix.pdf");
                                    message.Attachments.Add(new Attachment(fp)
                                    {
                                        Name = "Technical and Delivery Appendix.pdf"
                                    });
                                }
                            }
                        }
                        catch (Exception ex2)
                        {
                            HandleException(ex2, context);
                        }

                    } catch (Exception ex) {
                        HandleException(ex, context);
                    }
                }

                new MailManager().SendMail(message);
            } catch (Exception ex) {
                HandleException(ex, context);
            }
        }

        private static Attachment CreateBalustradePdfAttachment(Balustrade balustrade, string title, string fileName)
        {
            var memStream = new MemoryStream();
            using (var doc = balustrade.CreatePdf())
            {
                doc.Info.Title = title;
                doc.Save(memStream);
            }
            return new Attachment(memStream, fileName);
        }

        private static string GetBalustradeStartFinishPdfName(Balustrade balustrade)
        {
            var endType = balustrade.StartType == BalustradeSection.SectionFinishType.Wall ? "wall" : "endpost";
            var angleType = balustrade.WSAR ? "90" : "other";
            return endType + "-start-" + angleType;
        }

        private static string GetBalustradeEndFinishPdfName(Balustrade balustrade)
        {
            var endType = balustrade.EndType == BalustradeSection.SectionFinishType.Wall ? "wall" : "endpost";
            var angleType = balustrade.WEAR ? "90" : "other";
            return endType + "-end-" + angleType;
        }

        public static void SendQuote(ISession session, Quote quote) {
            try {
                quote.OnlineDisplay = false;
                var mailBody = MailTemplate(TemplateService.GetText(session.Get<Template>(OnlineQuoteMailTemplateId).Body, quote));
                var pdfBody = Global.CreateHtmlDocument(TemplateService.GetText(session.Get<Template>(QuoteTemplateId).Body, quote));
                var pdfPath = session.CurrentCompany().CreatePdf(pdfBody, "Quote " + quote.Code);

                var message = new MailMessage(SalesMail, quote.Customer.Email, "Balcony Systems Online Quote " + quote.Code, mailBody);
                message.IsBodyHtml = true;
                message.Bcc.Add("onlineshop@balconette.co.uk");


                message.Attachments.Add(new Attachment(pdfPath));
                var ql = quote.RawQuoteLines.FirstOrDefault();
                var context = HttpContext.Current;
                if (ql != null && ql.ProductDetails != null && context != null) {
                    if (ql.ProductDetails is Juliette) {
                        message.Attachments.Add(new Attachment(context.Server.MapPath("/pdfs/Glass Juliet Balconies Information Sheet.pdf")));
                        message.Attachments.Add(new Attachment(context.Server.MapPath("/pdfs/Composite Decking Information Sheet.pdf")));
                    }
                    if (ql.ProductDetails is Balustrade) {
                        message.Attachments.Add(new Attachment(context.Server.MapPath("/pdfs/Glass Balustrades Information Sheet.pdf")));
                        message.Attachments.Add(new Attachment(context.Server.MapPath("/pdfs/Composite Decking Information Sheet.pdf")));
                    }
                    if (ql.ProductDetails is CurvedDoor) {
                        message.Attachments.Add(new Attachment(context.Server.MapPath("/pdfs/Curved Patio Doors Information Sheet.pdf")));    
                    }
                    message.Attachments.Add(new Attachment(context.Server.MapPath("/pdfs/Self Cleaning Glass - BalcoNano - Information Sheet.pdf")));  
                }

                new MailManager().SendMail(message);
            } catch (Exception ex) {
                HandleException(ex, HttpContext.Current);
            }
        }

        public static string MailTemplate(string body) {
            return Global.CreateHtmlDocument(String.Format(@"                            
                <div style=""font-family: Arial; font-size: 10pt;"">
                    {0}<br />
                    <strong>Balcony Systems Solutions Ltd</strong>
                    <br />
                    Email: <a href=""sales@balconette.co.uk"">sales@balconette.co.uk</a>
                    <br /><br />
                    Main Line: <strong>01342 410411</strong>
                    <br />
                    Fax Line: <strong>01342 410412</strong>
                    <br /><br />
                    <a href=""http://www.balconette.co.uk"">www.balconette.co.uk</a>
                    <br />
                    <p style=""font-weight: bold;"">
                        Office and showroom open Monday to Friday 9:00am to 5:30pm at:<br />
                        Unit 6, Systems House, <br />
                        Eastbourne Road, Blindley Heath<br />
                        Lingfield, Surrey RH7 6JP 
                    </p>
                    <br /><br />
                    <div align=""center"" style=""font-size: 10pt; color: #969696;"">
                        This e-mail is intended for the addressee only.<br />
                        It may contain information which is privileged and/or confidential.<br />
                        If you are not the addressee, any use, distribution or copying of the contents of this message is strictly forbidden and may render you liable to pay compensation for unlawful use, distribution or copying.<br />
                        If you have received this message in error please let us know immediately by telephoning 01342 410411.<br /><br />
                        Although this email and any attachments are believed to be free of any virus, or any other defect which might affect any computer or IT system into which they are received and opened, it is the responsibility of the recipient to ensure that they are virus free and no responsibility is accepted by <strong>Balcony Systems Solutions Ltd</strong> for any loss or damage arising in any way from receipt or use.<br /><br />
                        <span style=""color: #000000;"">Balcony Systems Solutions Limited, registered in England under company registration no. 06937600. Registered office: Unit 6 Systems House, Eastbourne Road, Blindley Heath, RH7 6JP</span>
                    </div>
                </div>", body));
        }

        public static CentinelRequest PrepareCentinelRequest(string cardNum, double sum, int expMonth, int expYear) {
            var centinelRequest = new CentinelRequest();
            centinelRequest.add("MsgType", "cmpi_lookup");
            centinelRequest.add("Version", "1.7");
            centinelRequest.add("ProcessorId", "134-01");
            centinelRequest.add("MerchantId", "effi@balconette.co.uk");
            centinelRequest.add("TransactionPwd", "a9215361");
            centinelRequest.add("TransactionType", "C");
            centinelRequest.add("Amount", Math.Round(sum * 100, 0).ToString());
            centinelRequest.add("CurrencyCode", "826");
            centinelRequest.add("CardNumber", cardNum);
            centinelRequest.add("CardExpMonth", expMonth.ToString("00"));
            centinelRequest.add("CardExpYear", expYear.ToString());
            centinelRequest.add("OrderNumber", "50000");
            return centinelRequest;
        }
         
        public static IList<CartItem> GetCartItems(HttpContext context, ISession session) {
            var cusid = context.Request.IsAuthenticated ? new Guid(context.User.Identity.Name) : Guid.Empty;
            var si = GetSessionCookie(context);
            return session.CreateQuery(@"select distinct ci 
                                         from CartItem as ci 
                                         left join fetch ci.ProductDetails 
                                         where ci.AppId = :appid and (ci.Customer.ID = :cusid or ci.SessionID = :si) 
                                         order by ci.DateCreated")
                .SetParameter("appid", AppId)
                .SetParameter("si", si)
                .SetParameter("cusid", cusid)
                .SetCacheable(true)
                .SetCacheMode(CacheMode.Normal)
                .List<CartItem>();
        }       

        public static void ClearCart(HttpContext context, ISession session) {
            using (var trans = session.BeginTransaction()) {
                try {
                    foreach (var cartItem in GetCartItems(context, session)) {
                        session.Delete(cartItem);
                    }
                    session.Flush();
                    trans.Commit();
                } catch {
                    trans.Rollback();
                    throw;
                }
            }
        }

        public static CartItem AddToCart(HttpContext context, ISession session, ProductDetails product, double quantity) {
            var items = GetCartItems(context, session);
            var res = items.ToLookup(ci => ci.ProductDetails, ci => ci, ProductDetails.PhysicalComparer)[product];
            if (res.Any()) {
                var item = res.FirstOrDefault();
                item.Quantity += quantity;
                session.SaveOrUpdate(item);
                return item;
            } else {
                var item = new CartItem();
                item.AppId = AppId;
                item.SessionID = GetSessionCookie(context);
                item.Name = product.Name;
                item.Price = product.SellingPrice ?? 0D;
                item.Quantity = quantity;
                item.ProductDetails = product;
                session.SaveOrUpdate(item);
                return item;
            }            
        }

        public static void HandleException(Exception ex, HttpContext context) {
            var str = new StringBuilder(1000);

            str.AppendLine("<h1>Exception occured</h1>");
            str.AppendLine("<strong>Time:</strong> " + DateTime.Now);
            str.AppendLine("<br /><hr />");
            str.AppendLine("<strong>Source:</strong> " + ex.Source);
            str.AppendLine("<br /><hr />");
            str.AppendLine("<strong>Message:</strong> " + ex.FullMessage().Replace("\n", "<br />"));
            str.AppendLine("<br /><hr />");
            str.AppendLine("<strong>Stack trace:</strong> " + ex.StackTrace);
            str.AppendLine("<br /><hr />");
            var host = "WebGlobal";
            if (context != null) {

                str.AppendLine("<strong>URL: </strong>" + context.Request.Url.OriginalString);
                
                if (context.Request.UrlReferrer != null) {
                    str.AppendLine("<br /><hr />");
                    str.AppendLine("<strong>Ref URL:</strong> " + context.Request.UrlReferrer.OriginalString);
                }
                if (context.User != null && !String.IsNullOrEmpty(context.User.Identity.Name)) {
                    str.AppendLine("<br /><hr />");
                    str.AppendLine("<strong>User: </strong> " + context.User.Identity.Name);
                }
                str.AppendLine("<br /><hr />");
                str.AppendLine("<strong>User Agent:</strong> " + context.Request.UserAgent);
                str.AppendLine("<br /><hr />");
                str.AppendLine("<strong>User Host Address:</strong> " + context.Request.UserHostAddress);
                str.AppendLine("<br /><hr />");
                str.AppendLine("<strong>Session:</strong><br />");
                if (context.Session != null) {
                    for (var i = 0; i < context.Session.Count; i++) {
                        str.AppendLine(context.Session.Keys[i] + ": " + context.Session[i] + "<br />");
                    }
                }
                str.AppendLine("<hr />");
                str.AppendLine("<strong>Form:</strong><br />");
                for (var i = 0; i < context.Request.Form.Count; i++) {
                    str.AppendLine(context.Request.Form.Keys[i] + ": " + context.Request.Form[i] + "<br />");
                }
                str.AppendLine("<hr />");
                str.AppendLine("<strong>Cookies:</strong><br />");
                for (var i = 0; i < context.Request.Cookies.Count; i++) {
                    str.AppendLine(context.Request.Cookies.Keys[i] + ": " + context.Request.Cookies[i].Value + "<br />");
                }
                host = context.Request.Url.Host;
            }
            var body = str.ToString();

            Global.Log(body, ex);
        }
    }
}
