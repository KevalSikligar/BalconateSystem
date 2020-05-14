using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO; 
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Text;
using System.Web;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Core.Services.TemplateService;
using Balcony.Miracle.Data;
using Balcony.Miracle.Web.Cms;
using Balcony.Miracle.Web.Models;
using Balcony.Miracle.Web.Shared;
using CardinalCommerce;
using com.paypal.sdk.profiles;
using com.paypal.sdk.services;
using com.paypal.soap.api;
using NHibernate;
using Region = Balcony.Miracle.Core.Region;

namespace Balcony.Miracle.Web.Controllers
{

    public class CustomerController : BaseController
    {

        private const int ZEROID = 99999999;

        public ActionResult ClearCache()
        {
            NHibernateHelper.ClearCache();
            NHibernateHelper.ClearCache("normal");
            return Content("ok");
        }

        [SessionScope]
        [ActionName("sign-in")]
        public ActionResult SignIn(string redirect)
        {
            if (IsCustomer)
            {
                return Redirect("/");
            }
            var model = new SignInModel();
            model.Redirect = redirect;
            return View(model);
        }

        [HttpPost]
        [SessionScope]
        [ActionName("sign-in")]
        public ActionResult SignIn(SignInModel model)
        {
            if (IsCustomer)
            {
                return Redirect("/");
            }
            if (ModelState.IsValid)
            {
                var customer = DbSession.GetCustomerByEmail(model.Email);
                if (customer != null && customer.ValidateLogin(model.Password))
                {
                    SetAuthCookie(customer.ID, false);
                    if (String.IsNullOrEmpty(model.Redirect))
                    {
                        if (AreaKind > AreaKind.General) return RedirectToAction("homepage", AreaKind.ToString());
                        return Redirect("/");
                    }
                    return Redirect(model.Redirect);
                }
                ModelState.AddModelError("", "User - Password combination is invalid");
            }
            if (Request.IsAjaxRequest())
            {
                return ValidationErrors();
            }
            return View(model);
        }

        [SessionScope]
        [ActionName("sign-out")]
        public ActionResult SignOut(string redirect)
        {
            redirect = String.IsNullOrWhiteSpace(redirect) ? "/" : redirect;
            if (IsCustomer)
            {
                SignOutCustomer();
            }
            return Redirect(redirect);
        }

        [HttpPost]
        [SessionScope]
        [ActionName("forgot-password")]
        public ActionResult ForgotPassword(string email)
        {
            if (String.IsNullOrWhiteSpace(email))
            {
                return Dialog("Please enter an email address");
            }
            var customer = DbSession.GetCustomerByEmail(email);
            if (customer != null)
            {
               if(String.IsNullOrWhiteSpace(customer.Password ))
                {
                    TempData["cusID"] = customer.ID.ToString();
                    TempData["Referrer"] = Request.UrlReferrer;
                    return RedirectToAction("fill-details","customer");
                } else { 
                var body = "<html><body><h3>Thank you for signing in to Balcony Systems</h3><br />Your password is: " + customer.Password + "</body></html>";
                var client = new MailManager();
                client.SendMail(WebGlobal.SalesMail, email, "Balcony Systems Password Restore", body);
                return Dialog("Password was sent to your email.", true);
                }
            } else
            {
                return Dialog("This email is not registered on our website.");
            }
           
        }
        //[UseSsl]
        [NoCache]
        [SessionScope]
        [ActionName("fill-details")]
        public ActionResult FillDetails()
        {
            
            
                Customer cus = null;
                if (TempData["cusID"]!=null)
                {
                    cus = DbSession.Get<Customer>(new Guid(TempData["cusID"].ToString()));
                
                }
              var  model = cus != null ? OrderDetailsModel.FromCustomer(cus) : new OrderDetailsModel();
            
            return View(model);
        }
        [NoCache]
        [HttpPost]
        [TransactionScope]
        [ActionName("fill-details")]
        public ActionResult FillDetails(OrderDetailsModel model)
        {
            
            using (var trans = DbSession.BeginTransaction())
            {
                Customer customer;
                try
                {
                    if (CustomerId.HasValue)
                    {
                        customer = DbSession.Get<Customer>(CustomerId.Value);
                        model.UpdateCustomer(DbSession, customer);
                        DbSession.Flush();
                    }
                    else
                    {
                        customer = DbSession.GetCustomerByEmail(model.Email1);
                        if (customer != null)
                        {
                            if (!String.IsNullOrWhiteSpace(customer.Password))
                            {
                                ModelState.AddModelError("", "This account is already taken. Please select a different email address or sign in.");
                                return ValidationErrors();
                            }
                            model.UpdateCustomer(DbSession, customer);
                            DbSession.Flush();
                        }
                        
                    }
                    DbSession.SaveOrUpdate(new Event
                    {
                        EventType = DbSession.Get<EventType>(24),
                        Name = "Password Reset",
                        Status = Event.EventStatus.Final,
                        Customer = customer,
                        User = DbSession.CurrentUser(),
                        RefID = customer.ID
                    });
                    SendNotificationMail(customer);
                    SetAuthCookie(customer.ID, false);
                    Session[SessionKeys.ORDER_DETAILS] = null;
                    trans.Commit();
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    ModelState.AddModelError("", ex.Message);
                    WebGlobal.HandleException(ex, System.Web.HttpContext.Current);
                    return ValidationErrors();
                }            
               
                
                    return DialogRedirect("Thank you for updating your password, you are now signed in.", true, TempData["Referrer"].ToString());
                
            }
        }
        protected Quote SaveQuote(QuoteLine line, Customer customer)
        {
            using (var trans = DbSession.BeginTransaction())
            {
                try
                {
                    var quotenum = Session[SessionKeys.CURRENT_QUOTE_NUMBER] != null ? (int)Session[SessionKeys.CURRENT_QUOTE_NUMBER] : -1;

                    var quote = new Quote(DbSession.CurrentUser());
                    var isnew = quotenum == -1;
                    if (!isnew)
                    {
                        quote.QuoteNumber = quotenum;
                        quote.QuoteNumberParam = quotenum;
                    }
                    quote.Customer = customer;
                    quote.CustomerContact = customer.DefaultContact;
                    if (line.ProductDetails != null)
                    {
                        quote.DiscountPercent = line.ProductDetails.WebDiscount;
                        line.ProductDetails.Parent = quote;
                    }

                    var source = GetSource();
                    quote.Source = source.Item1;
                    quote.SubSource = source.Item2;

                    line.Quote = quote;
                    quote.RawQuoteLines.Add(line);

                    var genericTypes = GenericProductType.GetCachedList(DbSession);
                    foreach (var genericProductType in genericTypes)
                    {
                        var genericProduct = new GenericProduct();
                        genericProduct.GenericProductType = genericProductType;
                        genericProduct.Parent = quote;

                        var genericLine = new QuoteLine
                        {
                            Price = genericProduct.SilverSellingPrice,
                            BronzePrice = genericProduct.BronzeSellingPrice,
                            GoldPrice = genericProduct.GoldSellingPrice,
                            Name = genericProduct.Name,
                            ProductDetails = genericProduct,
                            Quote = quote,
                            Quantity = genericProduct.Quantity
                        };

                        quote.RawQuoteLines.Add(genericLine);
                    }

                    DbSession.SaveOrUpdate(quote);
                    DbSession.Flush();

                    var evnt = new Event();
                    evnt.Name = "New WebQuote " + quote.Code;
                    evnt.User = DbSession.CurrentUser();
                    evnt.EventType = DbSession.Get<EventType>(11);
                    evnt.Customer = customer;
                    evnt.RefID = quote.ID;
                    DbSession.SaveOrUpdate(evnt);
                    DbSession.Flush();

                    if (isnew)
                    {
                        quote.SetNumber();
                        DbSession.Flush();
                    }
                    trans.Commit();
                    Session[SessionKeys.CURRENT_QUOTE_NUMBER] = quote.QuoteNumber;
                    Session[SessionKeys.PENDING_QUOTE_LINE] = null;
                    //send mail
                    try
                    {
                        quote.OnlineDisplay = false;
                        var mailBody = WebGlobal.MailTemplate(TemplateService.GetText(DbSession.Get<Template>(WebGlobal.OnlineQuoteMailTemplateId).Body, quote));
                        var pdfBody = Global.CreateHtmlDocument(TemplateService.GetText(DbSession.Get<Template>(WebGlobal.QuoteTemplateId).Body, quote));
                        var pdfPath = DbSession.CurrentCompany().CreatePdf(pdfBody, "Quote " + quote.Code);

                        var message = new MailMessage(WebGlobal.SalesMail, quote.Customer.Email, "Balcony Systems Online Quote " + quote.Code, mailBody);
                        message.IsBodyHtml = true;
                        message.Bcc.Add("onlineshop@balconette.co.uk");

                        message.Attachments.Add(new Attachment(pdfPath));

                        var area = DbSession.Get<Area>(Area.ProductToAreaKind(line.ProductDetails));
                        if (!String.IsNullOrWhiteSpace(area.QuoteAttachment1))
                        {
                            message.Attachments.Add(new Attachment(Server.MapPath(area.QuoteAttachment1)));
                        }
                        if (!String.IsNullOrWhiteSpace(area.QuoteAttachment2))
                        {
                            message.Attachments.Add(new Attachment(Server.MapPath(area.QuoteAttachment2)));
                        }
                        if (!String.IsNullOrWhiteSpace(area.QuoteAttachment3))
                        {
                            message.Attachments.Add(new Attachment(Server.MapPath(area.QuoteAttachment3)));
                        }
                        if (!String.IsNullOrWhiteSpace(area.QuoteAttachment4))
                        {
                            message.Attachments.Add(new Attachment(Server.MapPath(area.QuoteAttachment4)));
                        }

                        new MailManager().SendMail(message);
                    }
                    catch (Exception ex)
                    {
                        WebGlobal.HandleException(ex, System.Web.HttpContext.Current);
                    }
                    return quote;
                }
                catch
                {
                    trans.Rollback();
                    throw;
                }
            }
        }
        private ActionResult RedirectQuote(Quote quote)
        {
            AreaKind = Area.ProductToAreaKind(quote.RawQuoteLines.FirstOrDefault().ProductDetails);

            switch (AreaKind)
            {
                case AreaKind.Juliettes:
                    return RedirectToAction("juliet-quote-success", "juliet-balcony", new { id = quote.ID });
                case AreaKind.Balustrades:
                    return RedirectToAction("glass-balustrade-quote-success", "glass-balustrade", new { id = quote.ID });
                case AreaKind.CurvedDoors:
                    return RedirectToAction("curved-patio-door-quote-success", "curved-doors", new { id = quote.ID });
              
                default:
                    return HttpNotFound();
            }
            
        }


        [TransactionScope]
        [ActionName("create-quote")]
        public ActionResult CreateQuote()
        {
            var line = Session[SessionKeys.PENDING_QUOTE_LINE] as QuoteLine;
            if (line == null)
            {
                return Redirect("/");
            }
            Customer customer;
            var cid = CustomerId;
            if (cid == null && HttpContext.IsQuoteCustomer())
            {
                cid = HttpContext.GetQuoteCustomerId();
            }
            if (cid.HasValue && (customer = DbSession.Get<Customer>(cid.Value)) != null)
            {
                var quote = SaveQuote(line, customer);
                //return RedirectToAction("quote", new { id = quote.ID });
                return RedirectQuote(quote);
            }
            AreaKind = Area.ProductToAreaKind(line.ProductDetails);
            //todo: setp page header
            return View();
        }

        [HttpPost]
        [TransactionScope]
        [ActionName("create-quote")]
        public ActionResult CreateQuote(QuoteAuthModel model)
        {
            var line = Session[SessionKeys.PENDING_QUOTE_LINE] as QuoteLine;
            if (line == null)
            {
                return Redirect("/");
            }
            Customer cus;
            if (!HttpContext.IsQuoteCustomer())
            {
                if (ModelState.IsValid)
                {
                    cus = DbSession.GetCustomerByEmail(model.Email) ??
                          CreateFastCustomer(DbSession, model.Email, model.FirstName, model.LastName, model.Phone);
                    Session[SessionKeys.QUOTE_CUSTOMER_ID] = cus.ID;
                }
                else
                {
                    return ValidationErrors();
                }
            }
            else
            {
                // ReSharper disable PossibleInvalidOperationException
                cus = DbSession.Get<Customer>(HttpContext.GetQuoteCustomerId().Value);
                // ReSharper restore PossibleInvalidOperationException
            }
            var quote = SaveQuote(line, cus);
            
             line = quote.RawQuoteLines.FirstOrDefault();
            if (line == null || line.ProductDetails == null)
            {
                return HttpNotFound();
            }

            AreaKind = Area.ProductToAreaKind(line.ProductDetails);
            //todo: setp page header

            quote.OnlineDisplay = true;
            return RedirectQuote(quote);
        }

        [SessionScope]
        public ActionResult Quote(Guid? id)
        {
            Quote quote;
            if (!id.HasValue || (quote = DbSession.Get<Quote>(id.Value)) == null)
            {
                return HttpNotFound();
            }
            var line = quote.RawQuoteLines.FirstOrDefault();
            if (line == null || line.ProductDetails == null)
            {
                return HttpNotFound();
            }

            AreaKind = Area.ProductToAreaKind(line.ProductDetails);
            //todo: setp page header

            quote.OnlineDisplay = true;
            

             return View(quote);            
        }

        [HttpPost]
        [TransactionScope]
        [ActionName("add-quote-to-cart")]
        public ActionResult AddQuoteToCart(Guid id)
        {
            Quote quote;
            if ((quote = DbSession.Get<Quote>(id)) == null || quote.FirstLine == null)
            {
                return HttpNotFound();
            }

            var item = new CartItem();
            item.AppId = WebGlobal.AppId;
            item.SessionID = WebGlobal.GetSessionCookie(System.Web.HttpContext.Current);
            item.Name = quote.FirstLine.Name;
            item.Price = quote.FirstLine.Price ?? 0D;
            item.Quote = quote;
            item.Customer = quote.Customer;
            DbSession.SaveOrUpdate(item);
            DbSession.Flush();
            HttpContext.ResetCartCount();
            return RedirectToAction("cart");
        }

        [SessionScope]
        [ActionName("cart")]
        public ActionResult Cart()
        {
            var page = DbSession.Get<StandardPage>(new Guid("2994bafd-d775-4b0f-b842-a3cf00ff83e6"));
            ViewBag.Body = page.Body;
            ViewBag.H1 = page.Name;
            PageHeader = page;

            var items = HttpContext.GetCartItems();
            return View(items);
        }
        
        [HttpPost]
        [TransactionScope]
        [ActionName("cart")]
        public ActionResult Cart(IList<CartItem> dtos)
        {
            var useritems = HttpContext.GetCartItems();
            var items = dtos != null ? dtos.ToDictionary(i => i.ID) : new Dictionary<Guid, CartItem>();
            foreach (var item in useritems)
            {
                if (items.ContainsKey(item.ID))
                {
                    item.Quantity = items[item.ID].Quantity;
                    DbSession.SaveOrUpdate(item);
                }
                else
                {
                    DbSession.Delete(item);
                }
            }
            HttpContext.ResetCartCount();
            return Json(new { });
        }
        public ActionResult GetAddr()
        {
            var sc = new ServiceClient();
            var s_resp = sc.GetAddresses(Request.QueryString["sc"]);
            
            return Content(s_resp);
        }
        #region Order

        //[UseSsl]
        [NoCache]
        [SessionScope]
        [ActionName("order-details")]
        public ActionResult OrderDetails()
        {
            var items = HttpContext.GetCartItems();
            if (items.Count == 0)
            {
                return RedirectToAction("Cart");
            }
            var model = Session[SessionKeys.ORDER_DETAILS] as OrderDetailsModel;
            if (model == null)
            {
                Customer cus = null;
                if (CustomerId.HasValue)
                {
                    cus = DbSession.Get<Customer>(CustomerId.Value);
                }
                model = cus != null ? OrderDetailsModel.FromCustomer(cus) : new OrderDetailsModel();
            }
            return View(model);
        }

        //[UseSsl]
        [NoCache]
        [HttpPost]
        [TransactionScope]
        [ActionName("order-details")]
        public ActionResult OrderDetails(OrderDetailsModel model)
        {
            var items = HttpContext.GetCartItems();
            if (items.Count == 0)
            {
                return RedirectToAction("Cart");
            }
            using (var trans = DbSession.BeginTransaction())
            {
                Customer customer;
                try
                {
                    if (CustomerId.HasValue)
                    {
                        customer = DbSession.Get<Customer>(CustomerId.Value);
                        model.UpdateCustomer(DbSession, customer);
                        DbSession.Flush();
                    }
                    else
                    {
                        customer = DbSession.GetCustomerByEmail(model.Email1);
                        if (customer != null)
                        {
                            if (!String.IsNullOrWhiteSpace(customer.Password))
                            {
                                ModelState.AddModelError("", "This account is already taken. Please select a different email address or sign in.");
                                return ValidationErrors();
                            }
                            model.UpdateCustomer(DbSession, customer);
                            DbSession.Flush();
                        }
                        else
                        {
                            customer = CreateNewCustomer();
                            customer.EmailAddresses.Add(new CustomerEmailAddress { EmailAddress = model.Email1, Customer = customer });

                            model.UpdateCustomer(DbSession, customer);
                            DbSession.SaveOrUpdate(customer);
                            DbSession.SaveOrUpdate(new Event
                            {
                                EventType = DbSession.Get<EventType>(1),
                                Name = "New Customer",
                                Status = Event.EventStatus.Final,
                                Customer = customer,
                                User = DbSession.CurrentUser(),
                                RefID = customer.ID
                            });
                            DbSession.Flush();
							DbSession.SaveOrUpdate(new Event
                            {
                                EventType = DbSession.Get<EventType>(10),
                                Name = "BillingDetails Provided",
                                Status = Event.EventStatus.Final,
                                Customer = customer,
                                User = DbSession.CurrentUser(),
                                RefID = customer.ID
                            });
                            DbSession.Flush();
                            customer.SetNumber();
                            DbSession.Flush();
                        }
                    }

                    SendNotificationMail(customer);
                    SetAuthCookie(customer.ID, false);
                    Session[SessionKeys.ORDER_DETAILS] = model;
                    trans.Commit();
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    ModelState.AddModelError("", ex.Message);
                    WebGlobal.HandleException(ex, System.Web.HttpContext.Current);
                    return ValidationErrors();
                }
                var order = CreateOrder(DbSession, customer, items, model);
                if (order.IncludesDelivery && !order.IsDeliveryAllowed)
                {
                    ModelState.AddModelError("", "Online orders cannot be placed to this delivery address <br />1)	Please try a different delivery address <br />2)	Or please contact our sales office on +44 1342 410411 or by emailing <a href=\"mailto:sales@balconette.co.uk\">sales@balconette.co.uk</a>");
                    return ValidationErrors();
                }
                return RedirectToAction("order-payment", "customer");
            }
        }

        private void SendNotificationMail(Customer cus)
        {
            try
            {
                var str = new StringBuilder(10000);
                str.AppendLine("<html><body>");
                str.AppendLine("<h2>New Invoice Details Provided</h2>");
                str.AppendLine(DateTime.Now.ToString());
                str.AppendLine("<br /><br />");
                str.AppendLine(cus.Email);
                str.AppendLine("<table border=0>");
                if ((cus.DefaultContact != null))
                {
                    str.AppendLine("<tr><td align=right nowrap><b>Name:</b></td><td>" + cus.DefaultContact.FullName + "</td></tr>");
                }
                str.AppendLine("<tr><td align=right nowrap><b>E-mail:</b></td><td>" + cus.Email + "</td></tr>");
                str.AppendLine("<tr><td align=right nowrap><b>Company:</b></td><td>" + cus.CompanyName + "</td></tr>");
                str.AppendLine("<tr><td> </td><td></td></tr>");
                if ((cus.PrimaryAddress != null))
                {
                    str.AppendLine("<tr><td align=right nowrap><b>Address:</b></td><tdif" + cus.PrimaryAddress.AsHtml + "</td></tr>");
                }
                if ((cus.DefaultContact != null))
                {
                    str.AppendLine("<tr><td align=right nowrap><b>Phone:</b></td><td>" + cus.DefaultContact.PrimaryPhoneString + "</td></tr>");
                    str.AppendLine("<tr><td align=right nowrap><b>Mobile:</b></td><td>" + cus.DefaultContact.SecondaryPhoneString + "</td></tr>");
                }
                str.AppendLine("<tr><td align=right nowrap><b>Fax:</b></td><td>" + cus.FaxString + "</td></tr>");
                str.AppendLine("<tr><td> </td><td></td></tr>");
                str.AppendLine("</table>");
                str.AppendLine("</body></html>");

                var mlClient = new MailManager();
                mlClient.SendMail(WebGlobal.SystemMail, WebGlobal.SalesMail, "New Client (" + cus.Email + ") Provided Invoice Details.", str.ToString());
            }
            catch (Exception ex)
            {
                WebGlobal.HandleException(ex, System.Web.HttpContext.Current);
            }
        }

        public Order CreateOrder(ISession session, Customer customer, IList<CartItem> cartItems, OrderDetailsModel model)
        {
            var order = new Order(DbSession.CurrentUser());
            order.Customer = customer;
            order.CustomerContact = customer.DefaultContact;
            order.BillingAddress = model.ToAddress(session);
            order.VatEnabled = order.BillingAddress.SubRegion.VATEnabled;
            order.IncludesDelivery = model.DeliveryOption != OrderDetailsModel.DeliveryOptionType.NoDelivery;

            var source = GetSource();
            order.Source = source.Item1;
            order.SubSource = source.Item2;

            if (model.DeliveryOption == OrderDetailsModel.DeliveryOptionType.SameAddress)
            {
                order.DeliveryAddress = model.ToAddress(session);
            }
            else if (model.DeliveryOption == OrderDetailsModel.DeliveryOptionType.DifferentAddress)
            {
                order.DeliveryAddress = new Address();
                order.DeliveryAddress.House = model.DeliveryHouse;
                order.DeliveryAddress.Street = model.DeliveryStreet;
                order.DeliveryAddress.City = model.DeliveryTown;
                order.DeliveryAddress.Postcode = model.DeliveryPostCode;
                if (model.DeliverySubRegionId.HasValue)
                {
                    order.DeliveryAddress.SubRegion = session.Get<SubRegion>(model.DeliverySubRegionId.Value);
                }
            }
            order.LoadCartItems(cartItems);

            var genericTypes = GenericProductType.GetCachedList(session);
            foreach (var genericProductType in genericTypes)
            {
                var genericProduct = new GenericProduct();
                genericProduct.GenericProductType = genericProductType;
                genericProduct.Parent = order;

                var line = new OrderLine
                {
                    Price = genericProduct.SellingPrice,
                    Name = genericProduct.Name,
                    ProductDetails = genericProduct,
                    Order = order,
                    Quantity = genericProduct.Quantity,
                    OrderBatch = order.RawOrderBatches.FirstOrDefault()
                };

                order.RawOrderLines.Add(line);
            }


            if (order.IncludesDelivery)
                order.DeliveryPrice = order.DoCalculateDelivery();

            if (customer.GeneralDiscount > 0)
            {
                order.DiscountPercent = customer.GeneralDiscount;
            }

            if (!order.HasCustomProducts)
            {
                order.Status = Order.OrderStatus.Technical;
                order.RawOrderBatches[0].Status = OrderBatch.BatchStatus.Technical_Reception;
            }
            return order;
        }

        //[UseSsl]
        [NoCache]
        [SessionScope]
        [ActionName("order-payment")]
        public ActionResult OrderPayment(string token, string payerid, string cancel)
        {
            var sessionToken = Session[SessionKeys.PAYAPL_TOKEN] as string;
            var items = HttpContext.GetCartItems();
            var details = Session[SessionKeys.ORDER_DETAILS] as OrderDetailsModel;
            if (items.Count == 0 || details == null || !CustomerId.HasValue)
            {
                return RedirectToAction("Cart");
            }

            var order = CreateOrder(DbSession, DbSession.Get<Customer>(CustomerId.Value), items, details);

            if (cancel == null && !String.IsNullOrEmpty(sessionToken) && !String.IsNullOrEmpty(token) && !String.IsNullOrEmpty(payerid))
            {
                var result = ProcessPayPalResult(token, payerid, order);
                if (result != null)
                {
                    return result;
                }
            }

            var msg = Session[SessionKeys.GLOBAL_MSG] as string;
            if (!String.IsNullOrEmpty(msg))
            {
                ModelState.AddModelError("", msg);
                Session[SessionKeys.GLOBAL_MSG] = null;
            }

            var model = new OrderPaymentModel(items, order);
            return View(model);
        }

        //[UseSsl]
        [NoCache]
        [HttpPost]
        [SessionScope]
        [ActionName("order-payment")]
        public ActionResult OrderPayment(OrderPaymentModel model, string credit, string paypal)
        {
            var items = HttpContext.GetCartItems();
            var details = Session[SessionKeys.ORDER_DETAILS] as OrderDetailsModel;
            if (items.Count == 0 || details == null || !CustomerId.HasValue)
            {
                return RedirectToAction("Cart");
            }

            var order = CreateOrder(DbSession, DbSession.Get<Customer>(CustomerId.Value), items, details);

            var invoice = order.CreateInvoice(DbSession.CurrentUser());
            if (!String.IsNullOrEmpty(paypal))
            {
                RemoveCreditCardValidationErrors();
                return PayWithPayPal(model, invoice);
            }
            return PayWithCreditCard(model, invoice);
        }

        //[UseSsl]
        [NoCache]
        [ActionName("three-d-secure")]
        public ActionResult ThreeDSecure()
        {
            var action = Session["_crAcsUrl"] as string;
            var payLoad = Session["_crPayLoad"] as string;
            if (String.IsNullOrEmpty(action) || String.IsNullOrEmpty(payLoad))
                return RedirectToAction("cart");

            var uriBuilder = new UriBuilder("https", Request.Url.Host, Request.Url.Port, "/customer/three-d-secure-result");

            //var backUrl = "https://www.balconette.co.uk/customer/three-d-secure-result"; //Url.Action("three-d-secure-result", null, new { }, Request.Url.Scheme);
            var body = String.Format(
                @"<html>
                    <body>
                      <form name=""form1"" method=""post"" action=""{0}"">
                        <input name=""PaReq"" type=""hidden"" value=""{1}"" />
                        <input name=""TermUrl"" type=""hidden"" value=""{2}"" />
                        <input name=""MD"" type=""hidden"" value="""" />
                        <script type=""text/javascript"">form1.submit();</script>
                      </form>
                    </body>
                  </html>", action, payLoad, uriBuilder.Uri.ToString());
            return Content(body);
        }


        //[UseSsl]
        [NoCache]
        [HttpPost]
        [ValidateInput(false)]
        [ActionName("three-d-secure-result")]
        public ActionResult ThreeDSecureResult(string pares, string md)
        {
            var transactionId = Session["_crTransactionId"] as string;
            var items = HttpContext.GetCartItems();
            var orderDetails = Session[SessionKeys.ORDER_DETAILS] as OrderDetailsModel;
            var paymentDetails = Session[SessionKeys.PAYMENT_DETAILS] as OrderPaymentModel;
            string redirect;
            if (!String.IsNullOrEmpty(pares) && !String.IsNullOrEmpty(transactionId) && paymentDetails != null && items.Count != 0 && orderDetails != null && CustomerId.HasValue)
            {
                redirect = Url.Action("order-payment");
                var req = PrepareRequest(pares, transactionId);
                var centinelResponse = req.sendHTTP("https://paypal.cardinalcommerce.com/maps/txns.asp", 30000);
                //var crErrorNo = centinelResponse.getValue("ErrorNo");
                //var crErrorDesc = centinelResponse.getValue("ErrDesc");
                var crPaResStatus = centinelResponse.getValue("PAResStatus");
                var crCavv = centinelResponse.getValue("Cavv");
                var crSignatureVerification = centinelResponse.getValue("SignatureVerification");
                var crEciFlag = centinelResponse.getValue("EciFlag");
                var crXid = centinelResponse.getValue("Xid");
                if (crSignatureVerification.Equals("Y", StringComparison.OrdinalIgnoreCase) &&
                    (crPaResStatus.Equals("Y", StringComparison.OrdinalIgnoreCase) || crPaResStatus.Equals("A", StringComparison.OrdinalIgnoreCase)))
                {
                    var order = CreateOrder(DbSession, DbSession.Get<Customer>(CustomerId.Value), items, orderDetails);

                    var invoice = order.CreateInvoice(DbSession.CurrentUser());
                    var address = paymentDetails.BillingOption == OrderPaymentModel.BillingOptionType.SameAddress ?
                        invoice.Order.BillingAddress :
                        paymentDetails.GetCardHolderAddress(DbSession);

                    var payPalReq = WebGlobal.PreparePaypalRequest(invoice,
                        address,
                        paymentDetails.CreditCardNumber,
                        (CreditCardTypeType)paymentDetails.CreditCardType,
                        paymentDetails.Cvv,
                        paymentDetails.ExpMonth,
                        paymentDetails.ExpYear,
                        paymentDetails.StartMonth,
                        paymentDetails.StartYear,
                        paymentDetails.IssueNumber,
                        true,
                        crXid,
                        crEciFlag,
                        crCavv,
                        "Y",
                        crPaResStatus);

                    var responsed = WebGlobal.ProcessRequest(payPalReq);
                    if (responsed.Ack == AckCodeType.Success || responsed.Ack == AckCodeType.SuccessWithWarning)
                    {
                        using (var trans = DbSession.BeginTransaction())
                        {
                            WebGlobal.ProcessOrder(System.Web.HttpContext.Current, DbSession, invoice, Payment.PaymentKind.Credit_Card, crCavv, crEciFlag, "Y", crPaResStatus, crXid, responsed.AVSCode, responsed.CorrelationID, responsed.CVV2Code, responsed.TransactionID);
                            trans.Commit();
                        }
                        try
                        {
                            HttpContext.ClearCartItems();
                        }
                        catch (Exception ex)
                        {
                            WebGlobal.HandleException(ex, System.Web.HttpContext.Current);
                        }
                        redirect = PaymentSuccessUrl(invoice.Order);
                    }
                    else
                    {
                        Session[SessionKeys.GLOBAL_MSG] = "Please try again ...";
                    }
                }
                else
                {
                    Session[SessionKeys.GLOBAL_MSG] = "Please try again ...";
                }
            }
            else
            {
                redirect = Url.Action("cart");
            }
            return Content(String.Format("<html><head><script type=\"text/javascript\">window.parent.location.replace(\"{0}\");</script></head><body><h1>Please wait...</h1></body></html>", redirect));
        }

        private ActionResult PayWithPayPal(OrderPaymentModel model, Invoice invoice)
        {
            var req = new SetExpressCheckoutRequestType();
            req.SetExpressCheckoutRequestDetails = new SetExpressCheckoutRequestDetailsType();
            req.SetExpressCheckoutRequestDetails.OrderTotal = new BasicAmountType();
            req.SetExpressCheckoutRequestDetails.OrderTotal.currencyID = CurrencyCodeType.GBP;
            req.SetExpressCheckoutRequestDetails.OrderTotal.Value = invoice.Total.ToString("0.00");
            req.SetExpressCheckoutRequestDetails.ReturnURL = new UriBuilder("https", Request.Url.Host, Request.Url.Port, "/customer/order-payment").Uri.ToString(); //Url.Action("order-payment", null, new { }, Request.Url.Scheme);
            req.SetExpressCheckoutRequestDetails.CancelURL = new UriBuilder("https", Request.Url.Host, Request.Url.Port, "/customer/order-payment", "?cancel=paypal").Uri.ToString(); // Url.Action("order-payment", null, new { cancel = "paypal" }, Request.Url.Scheme);
            var caller = CreateCaller();
            var res = caller.Call("SetExpressCheckout", req) as SetExpressCheckoutResponseType;
            if (res != null && (res.Ack == AckCodeType.Success || res.Ack == AckCodeType.SuccessWithWarning))
            {
                Session[SessionKeys.PAYAPL_TOKEN] = res.Token;
                Response.Redirect("https://www.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=" + res.Token);
            }
            else
            {
                ModelState.AddModelError("", "We had some problems processing your transaction. Please try again later.");
                WebGlobal.HandleException(new Exception(res.Errors != null && res.Errors.Length > 0 ? res.Errors[0].LongMessage : "PayPal Error"), System.Web.HttpContext.Current);
            }
            return View(model);
        }

        private ActionResult PayWithCreditCard(OrderPaymentModel model, Invoice invoice)
        {
            var creq = WebGlobal.PrepareCentinelRequest(model.CreditCardNumber, invoice.Total.RoundUp2(), model.ExpMonth, model.ExpYear);
            var cres = creq.sendHTTP("https://paypal.cardinalcommerce.com/maps/txns.asp", 30000);


            var crEnrolled = cres.getValue("Enrolled");
            if (crEnrolled.Equals("Y"))
            {
                //3D Secure Authentication
                Session["_crTransactionId"] = cres.getValue("TransactionId");
                Session["_crEnrolled"] = crEnrolled;
                Session["_crAcsUrl"] = cres.getValue("ACSUrl");
                Session["_crPayLoad"] = cres.getValue("Payload");
                Session[SessionKeys.PAYMENT_DETAILS] = model;
                model.Iframe = Url.Action("three-d-secure");
            }
            else
            {
                //Standard PayPal Authentication
                var address = model.BillingOption == OrderPaymentModel.BillingOptionType.SameAddress ?
                    invoice.Order.BillingAddress :
                    model.GetCardHolderAddress(DbSession);

                var req = WebGlobal.PreparePaypalRequest(invoice, address, model.CreditCardNumber, (CreditCardTypeType)model.CreditCardType, model.Cvv, model.ExpMonth, model.ExpYear, model.StartMonth, model.StartYear, model.IssueNumber, false, null, null, null, null, null);
                var res = WebGlobal.ProcessRequest(req);
                if (res.Ack == AckCodeType.Success || res.Ack == AckCodeType.SuccessWithWarning)
                {
                    using (var trans = DbSession.BeginTransaction())
                    {
                        WebGlobal.ProcessOrder(System.Web.HttpContext.Current, DbSession, invoice, Payment.PaymentKind.Credit_Card, null, null, null, null, null, res.AVSCode, res.CorrelationID, res.CVV2Code, res.TransactionID);
                        trans.Commit();
                    }
                    try
                    {
                        HttpContext.ClearCartItems();
                    }
                    catch (Exception ex)
                    {
                        WebGlobal.HandleException(ex, System.Web.HttpContext.Current);
                    }
                    return Redirect(PaymentSuccessUrl(invoice.Order));
                }
                ModelState.AddModelError("", "We had some problems processing your transaction. Please try again later.");
                WebGlobal.HandleException(new Exception(res.Errors != null && res.Errors.Length > 0 ? res.Errors[0].LongMessage : "PayPal Error"), System.Web.HttpContext.Current);
            }
            return View(model);
        }

        private CentinelRequest PrepareRequest(string pares, string transactionId)
        {
            var request = new CentinelRequest();
            request.add("MsgType", "cmpi_authenticate");
            request.add("Version", "1.7");
            request.add("ProcessorId", "134-01");
            request.add("MerchantId", "effi@balconette.co.uk");
            request.add("TransactionPwd", "a9215361");
            request.add("TransactionType", "C");
            request.add("TransactionId", transactionId);
            request.add("PAResPayload", pares);
            return request;
        }

        private ActionResult ProcessPayPalResult(string token, string payerid, Order order)
        {
            var invoice = order.CreateInvoice(DbSession.CurrentUser());
            var req = new DoExpressCheckoutPaymentRequestType();
            req.DoExpressCheckoutPaymentRequestDetails = new DoExpressCheckoutPaymentRequestDetailsType();
            req.DoExpressCheckoutPaymentRequestDetails.Token = token;
            req.DoExpressCheckoutPaymentRequestDetails.PayerID = payerid;
            req.DoExpressCheckoutPaymentRequestDetails.PaymentAction = PaymentActionCodeType.Sale;
            req.DoExpressCheckoutPaymentRequestDetails.PaymentDetails = new PaymentDetailsType();
            req.DoExpressCheckoutPaymentRequestDetails.PaymentDetails.OrderTotal = new BasicAmountType();
            req.DoExpressCheckoutPaymentRequestDetails.PaymentDetails.OrderTotal.currencyID = CurrencyCodeType.GBP;
            req.DoExpressCheckoutPaymentRequestDetails.PaymentDetails.OrderTotal.Value = invoice.Total.ToString("0.00");
            var caller = CreateCaller();
            var res = caller.Call("DoExpressCheckoutPayment", req) as DoExpressCheckoutPaymentResponseType;
            if (res != null && (res.Ack == AckCodeType.Success || res.Ack == AckCodeType.SuccessWithWarning))
            {
                using (var trans = DbSession.BeginTransaction())
                {
                    WebGlobal.ProcessOrder(System.Web.HttpContext.Current, DbSession, invoice,
                        Payment.PaymentKind.Paypal, null, null, null, null, null, null, res.CorrelationID, null,
                        res.DoExpressCheckoutPaymentResponseDetails.PaymentInfo.TransactionID);
                    trans.Commit();
                }
                try
                {
                    HttpContext.ClearCartItems();
                }
                catch (Exception ex)
                {
                    WebGlobal.HandleException(ex, System.Web.HttpContext.Current);
                }
                Session[SessionKeys.PAYAPL_TOKEN] = null;
                return Redirect(PaymentSuccessUrl(order));
            }
            ModelState.AddModelError("", "Sorry, we couldn't process your transaction please try again later");
            return null;
        }

        private string PaymentSuccessUrl(Order order)
        {
            return String.Format("/general/payment-success?code={0}", order.Code);
        }

        private void RemoveCreditCardValidationErrors()
        {
            ModelState.Remove("CreditCardNumber");
            ModelState.Remove("CreditCardType");
            ModelState.Remove("ExpMonth");
            ModelState.Remove("ExpYear");
            ModelState.Remove("StartMonth");
            ModelState.Remove("StartYear");
            ModelState.Remove("IssueNumber");
            ModelState.Remove("Cvv");
            ModelState.Remove("CreditHouse");
            ModelState.Remove("CreditStreet");
            ModelState.Remove("CreditTown");
            ModelState.Remove("CreditCountryId");
            ModelState.Remove("CreditPostCode");
        }

        private CallerServices CreateCaller()
        {
            var profile = ProfileFactory.createSignatureAPIProfile();
            profile.APIUsername = DbSession.CurrentCompany().PayPalApiUsername;
            profile.APIPassword = DbSession.CurrentCompany().PayPalApiPassword;
            profile.APISignature = DbSession.CurrentCompany().PayPalApiSignature;
            profile.Environment = "Live";
            profile.Subject = "Online Transaction";
            var caller = new CallerServices();
            caller.APIProfile = profile;
            return caller;
        }

        #endregion


        #region Delivery Calculator

        [SessionScope]
        [ActionName("delivery-calculator")]
        public ActionResult DeliveryCalculator(Guid? id, int? sid, int? tid, int? cid, int? gid)
        {
            var model = new DeliveryCalculatorModel()
            {
                StandardId = sid,
                TypeId = tid,
                ColorId = cid,
                GlassId = gid,
            };
            return View(model);
        }

        [HttpPost]
        [SessionScope]
        [ActionName("delivery-calculator")]
        public ActionResult DeliveryCalculator(Guid? id, DeliveryCalculatorModel model)
        {
            Quote quote = null;
            var msgFormat = "Delivery price per unit +VAT is: <span class=\"area_color\">&pound;{0:0.00}</span>";
            if (id.HasValue)
            {
                quote = DbSession.Get<Quote>(id.Value);

            }
            else
            {
                JulietteStandard standard;
                JulietteType type;
                ColorLocal color;
                GlassSystemLocal glass;

                if (model != null && model.StandardId.HasValue && model.TypeId.HasValue && model.ColorId.HasValue && model.GlassId.HasValue && (standard = DbSession.Get<JulietteStandard>(model.StandardId.Value)) != null && (type = DbSession.Get<JulietteType>(model.TypeId.Value)) != null && (color = DbSession.Get<ColorLocal>(model.ColorId.Value)) != null && (glass = DbSession.Get<GlassSystemLocal>(model.GlassId.Value)) != null)
                {
                    quote = new Quote(DbSession.CurrentUser());
                    var jul = new Juliette()
                    {
                        JulietteStandard = standard,
                        JulietteType = type,
                        Color = color,
                        GlassSystem = glass
                    };

                    var line = new QuoteLine();
                    line.ProductDetails = jul;
                    line.Quote = quote;
                    line.Name = jul.Name;
                    line.Price = jul.SellingPrice;
                    quote.RawQuoteLines.Add(line);
                }
                else
                {
                    msgFormat = "Delivery price for all products in cart +VAT is: <span class=\"area_color\">&pound;{0:0.00}</span>";
                    var items = HttpContext.GetCartItems();
                    if (items.Any())
                    {
                        quote = new Quote(DbSession.CurrentUser());
                        quote.LoadCartItems(items);
                    }
                }
            }
            if (quote == null || model.SubRegionId == null)
            {
                return Content("Cannot calculate delivery.");
            }
            quote.DeliveryAddress = new Address();
            quote.DeliveryAddress.SubRegion = DbSession.Get<SubRegion>(model.SubRegionId.Value);
            ActionResult res;
            if (quote.DeliveryAddress.SubRegion == null || !quote.IsDeliveryAllowed)
            {
                res = Content("Cannot deliver to this region.");
            }
            else
            {
                var price = quote.DoCalculateDelivery();
                res = Content(String.Format(msgFormat, price));
            }
            return res;
        }

        #endregion


        #region Customer Forms

        [HttpPost]
        public ActionResult Upload()
        {
            try
            {
                foreach (string file in Request.Files)
                {
                    var hpf = this.Request.Files[file];
                    if (hpf.ContentLength == 0)
                    {
                        continue;
                    }

                    string savedFileName = Path.Combine(
                             AppDomain.CurrentDomain.BaseDirectory, "Competition ");
                    savedFileName = Path.Combine(savedFileName, Path.GetFileName(hpf.FileName));

                    hpf.SaveAs(savedFileName);
                }

            }
            catch (Exception ex)
            {

                throw;
            }
            return RedirectToAction("photo-comp-entry");
        }


        [ActionName("photo-comp-entry")]
        public ActionResult PhotoCompEntry()
        {
            var model = new RequestBrochureModel();
            if (AreaKind > AreaKind.General)
            {
                model.SelectedProduct = Area;
            }
            return GetCustomerDto("995b619c-18a7-4ed7-96b3-a35700e58bde", model);
        }
        public static List<string> GetAllPhotosExtensions()
        {
            var list = new List<string>();
            list.Add(".jpg");
            list.Add(".png");
            list.Add(".bmp");
            list.Add(".gif");
            list.Add(".jpeg");
            list.Add(".tiff");
            return list;
        }
        static bool IsValidImage(Stream imageStream)
        {
            if (imageStream.Length > 0)
            {
                byte[] header = new byte[4]; // Change size if needed.
                imageStream.Read(header, 0, header.Length);

                    try
                    {
                        Image.FromStream(imageStream).Dispose();
                        imageStream.Close();
                        return true;
                    }

                    catch(Exception ex)
                    {
                        return false;
                    }
            }

            imageStream.Close();
            return false;
        }
        public static bool IsPhoto(string fileName)
        {
            var list = CustomerController.GetAllPhotosExtensions();
            var filename = fileName.ToLower();
            bool isThere = false;
            foreach (var item in list)
            {
                if (filename.EndsWith(item))
                {
                    isThere = true;
                    break;
                }
            }
            return isThere;
        }
        [HttpPost]
        [ActionName("photo-comp-entry")]
        [TransactionScope]
        public ActionResult PhotoCompEntry(RequestBrochureModel model, HttpPostedFile image1)
        {
            bool allPhotos = true;
            string imagesFolderName = "";
            foreach (string file in Request.Files)
            {
                var hpf = this.Request.Files[file];
                if (hpf.ContentLength == 0)
                {
                    continue;
                }
                // validate file size
                if (hpf.ContentLength < 10 * 1024 * 1024)
                {
                    // system.Drawing check
                    var isValidImage = IsValidImage(hpf.InputStream);
                    var isPhoto = CustomerController.IsPhoto(hpf.FileName);
                    if (isPhoto && isValidImage)
                    {
                        string saveFileFolder = Path.Combine(
                                 AppDomain.CurrentDomain.BaseDirectory, "Competition");
                        if (!Directory.Exists(saveFileFolder))
                        {
                            Directory.CreateDirectory(saveFileFolder);
                        }
                        string subfolder = Path.Combine(saveFileFolder, model.Email1);
                        string date = DateTime.Now.ToString("ddd MM.dd.yyyy");
                        string time = DateTime.Now.ToString("HH.mm tt");
                        string dateTime = date + "_" + time;
                        subfolder = subfolder + "_" + dateTime;
                        imagesFolderName = model.Email1 + "_" + dateTime;
                        Directory.CreateDirectory(subfolder);
                        var savedFileName = Path.Combine(subfolder, Path.GetFileName(hpf.FileName));
                        hpf.SaveAs(savedFileName);
                    }
                    else
                    {
                        allPhotos = false;
                        break;
                    }
                }
                else
                {
                    return RedirectToAction("photo-comp-entry");
                }
            }

            var notes = new StringBuilder(1000);
            if (model.Products != null && model.Products.Any() && Request.Files.Count > 0 && allPhotos == true)
            {
                notes.AppendLine("Products:");
                foreach (var prodcut in model.Products)
                {
                    var area = DbSession.Get<Area>((AreaKind)prodcut);
                    if (area == null) continue;
                    notes.AppendLine(area.Name);
                }
                notes.AppendLine(model.Notes);
            }
            if (Request.Files.Count > 0 && allPhotos == true)
            {
                var customer = SaveCustomerDto(model, "Online Photo Competition", 25, notes.ToString());

                try
                {
                    var strBody = new StringBuilder(1000);
                    strBody.AppendLine("<html><body>");
                    strBody.AppendLine("<h2><u>Online Photo Competition Entry</u></h2>");
                    strBody.AppendLine("<table border=0>");
                    strBody.AppendLine("<tr><td align=left nowrap><b>Thank you for the photo/s submitted</b></td></td></tr>");
                    strBody.AppendLine("<tr><td align=left nowrap><b>We have recorded the below information for this submission:</b></td></td></tr>");
                    strBody.AppendLine("<tr><td align=right nowrap><b>Name:</b></td><td>" + model.FirstName + "</td></tr>");
                    strBody.AppendLine("<tr><td align=right nowrap><b>Name:</b></td><td>" + model.FirstName + "</td></tr>");
                    strBody.AppendLine("<tr><td align=right nowrap><b>E-mail:</b></td><td>" + model.Email1 + "</td></tr>");
                    strBody.AppendLine("<tr><td align=right nowrap><b>Company Name:</b></td><td>" + model.CompanyName + "</td></tr>");
                    strBody.AppendLine("<tr><td> </td><td></td></tr>");
                    strBody.AppendLine("<tr><td align=right nowrap><b>Address1:</b></td><td> Test Address </td></tr>");
                    strBody.AppendLine("<tr><td align=right nowrap><b>Address2:</b></td><td> Test Address 1</td></tr>");
                    strBody.AppendLine("<tr><td align=right nowrap><b>Town\\City:</b></td><td>" + model.Town + "</td></tr>");
                    strBody.AppendLine("<tr><td align=right nowrap><b>Country:</b></td><td>" + customer.PrimaryAddress.Country.Name_En + "</td></tr>");
                    strBody.AppendLine("<tr><td align=right nowrap><b>Region:</b></td><td>" + customer.PrimaryAddress.Region.Name_En + "</td></tr>");
                    strBody.AppendLine("<tr><td align=right nowrap><b>County:</b></td><td>" + customer.PrimaryAddress.SubRegion.Name_En + "</td></tr>");
                    strBody.AppendLine("<tr><td align=right nowrap><b>Postcode:</b></td><td>" + model.PostCode + "</td></tr>");
                    strBody.AppendLine("<tr><td> </td><td></td></tr>");
                    strBody.AppendLine("<tr><td align=right nowrap><b>Phone:</b></td><td>" + model.Phone + "</td></tr>");
                    strBody.AppendLine("<tr><td align=right nowrap><b>Mobile:</b></td><td>" + model.Mobile + "</td></tr>");
                    strBody.AppendLine("<tr><td align=right nowrap><b>Fax:</b></td><td>" + model.Fax + "</td></tr>");
                    strBody.AppendLine("<tr><td align=right nowrap><b>Notes:</b></td><td>" + model.Notes + "</td></tr>");
                    strBody.AppendLine("<tr><td> </td><td></td></tr>");
                    strBody.AppendLine("<tr><td align=right><b>Images Saved in Folder:</b></td><td>" + imagesFolderName + "</td></tr>");
                    strBody.AppendLine("</table></body></html>");
                    var mlClient = new MailManager();
                    mlClient.SendMail(WebGlobal.SystemMail, "competition@balconette.co.uk", "Photo Competition Entry", strBody.ToString());
                    //var body = TemplateService.GetText(DbSession.Get<Template>(new Guid("f02e41b9-c9e9-e011-9d71-58b0358c18e0")).Body, customer);
                    //mlClient.SendMail(WebGlobal.SystemMail, "competition@balconette.co.uk", "Photo Competition Entry", body);
                    // For Customer
                    mlClient.SendMail(WebGlobal.SystemMail, model.Email1, "Photo Competition Entry", strBody.ToString());
                    //var bodyCustomer = TemplateService.GetText(DbSession.Get<Template>(new Guid("f02e41b9-c9e9-e011-9d71-58b0358c18e0")).Body, customer);
                    //mlClient.SendMail(WebGlobal.SystemMail, model.Email1, "Photo Competition Entry", bodyCustomer);
                }
                catch (Exception ex)
                {
                    WebGlobal.HandleException(ex, System.Web.HttpContext.Current);
                }
                return Redirect("/general/photo-competition-submission-success");
            }
            else
            {
                return RedirectToAction("photo-comp-entry");
            }
        }


        [ActionName("request-brochure")]
        public ActionResult RequestBrochure()
        {
            var model = new RequestBrochureModel();
            if (AreaKind > AreaKind.General)
            {
                model.SelectedProduct = Area;
            }
            return GetCustomerDto("995b619c-18a7-4ed7-96b3-a35700e58bde", model);
        }

        [HttpPost]
        [ActionName("request-brochure")]
        [TransactionScope]
        public ActionResult RequestBrochure(RequestBrochureModel model)
        {
            var notes = new StringBuilder(1000);
            if (model.Products != null && model.Products.Any())
            {
                notes.AppendLine("Products:");
                foreach (var prodcut in model.Products)
                {
                    var area = DbSession.Get<Area>((AreaKind)prodcut);
                    if (area == null) continue;
                    notes.AppendLine(area.Name);
                }
                notes.AppendLine(model.Notes);
            }

            var customer = SaveCustomerDto(model, "Online Brochure Request", 2, notes.ToString());

            try
            {
                var strBody = new StringBuilder(1000);
                strBody.AppendLine("<html><body>");
                strBody.AppendLine("<h2><u>Online Brochure Request</u></h2>");
                strBody.AppendLine("<table border=0>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Name:</b></td><td>" + customer.DefaultContact.FullName + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>E-mail:</b></td><td>" + model.Email1 + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Company:</b></td><td>" + customer.CompanyName + "</td></tr>");
                strBody.AppendLine("<tr><td> </td><td></td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Address1:</b></td><td>" + model.House + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Address2:</b></td><td>" + model.Street + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Town\\City:</b></td><td>" + model.Town + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Country:</b></td><td>" + customer.PrimaryAddress.Country.Name_En + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Region:</b></td><td>" + customer.PrimaryAddress.Region.Name_En + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>County:</b></td><td>" + customer.PrimaryAddress.SubRegion.Name_En + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Postcode:</b></td><td>" + model.PostCode + "</td></tr>");
                strBody.AppendLine("<tr><td> </td><td></td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Phone:</b></td><td>" + model.Phone + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Mobile:</b></td><td>" + model.Mobile + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Fax:</b></td><td>" + model.Fax + "</td></tr>");
                strBody.AppendLine("<tr><td> </td><td></td></tr>");
                strBody.AppendLine("<tr><td align=right><b>Notes:</b></td><td>" + notes + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>BV Subscription:</b></td><td>" + (model.Subscription ? "Yes" : "No") + "</td></tr>");
                strBody.AppendLine("</table></body></html>");
                var mlClient = new MailManager();
                mlClient.SendMail(WebGlobal.SystemMail, WebGlobal.BrochuresMail, "New brochure request", strBody.ToString());
                var body = TemplateService.GetText(DbSession.Get<Template>(new Guid("f02e41b9-c9e9-e011-9d71-58b0358c18e0")).Body, customer);
                var pdfBody = Global.CreateHtmlDocument(body);
                var pdfPath = DbSession.CurrentCompany().CreatePdf(pdfBody, "Brochure " + customer.Code);
                mlClient.SendMail(WebGlobal.SystemMail, WebGlobal.BrochuresMail, "New brochure request (Letter)", body, pdfPath);
            }
            catch (Exception ex)
            {
                WebGlobal.HandleException(ex, System.Web.HttpContext.Current);
            }


            //var successBlock = DbSession.Get<CmsBlock>(new Guid("9dc43c28-4ebc-454a-a8b6-a1fc00f208d4"));
            //return Dialog(successBlock != null ? successBlock.Html : "Success", false);
            return Redirect("/general/brochure-request-success");
        }


        [ActionName("request-tickets")]
        public ActionResult RequestTickets()
        {
            var model = new RequestTicketsModel();
            return GetCustomerDto("e7e3b188-e8ce-46bc-b116-a4e0013a706d", model);
        }

        [HttpPost]
        [ActionName("request-tickets")]
        [TransactionScope]
        public ActionResult RequestTickets(RequestTicketsModel model)
        {
            var customer = SaveCustomerDto(model, "Online Exhibition Tickets Request", 14, "");
            try
            {
                var strBody = new StringBuilder(1000);
                strBody.AppendLine("<html><body>");
                strBody.AppendLine("<h2><u>Online Exhibition Tickets Request</u></h2>");
                strBody.AppendLine("<table border=0>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Name:</b></td><td>" + customer.DefaultContact.FullName + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>E-mail:</b></td><td>" + model.Email1 + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Company:</b></td><td>" + customer.CompanyName + "</td></tr>");
                strBody.AppendLine("<tr><td> </td><td></td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Address1:</b></td><td>" + model.House + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Address2:</b></td><td>" + model.Street + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Town\\City:</b></td><td>" + model.Town + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Country:</b></td><td>" + customer.PrimaryAddress.Country.Name_En + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Region:</b></td><td>" + customer.PrimaryAddress.Region.Name_En + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>County:</b></td><td>" + customer.PrimaryAddress.SubRegion.Name_En + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Postcode:</b></td><td>" + model.PostCode + "</td></tr>");
                strBody.AppendLine("<tr><td> </td><td></td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Phone:</b></td><td>" + model.Phone + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Mobile:</b></td><td>" + model.Mobile + "</td></tr>");
                strBody.AppendLine("<tr><td align=right nowrap><b>Fax:</b></td><td>" + model.Fax + "</td></tr>");
                strBody.AppendLine("</table></body></html>");
                var mlClient = new MailManager();
                mlClient.SendMail(WebGlobal.SystemMail, WebGlobal.BrochuresMail, "Exhibition Tickets Request", strBody.ToString());
            }
            catch (Exception ex)
            {
                WebGlobal.HandleException(ex, System.Web.HttpContext.Current);
            }

            var successBlock = DbSession.Get<CmsBlock>(new Guid("d21c399d-99ce-41cb-ae07-a65a00d71a35"));
            return Dialog(successBlock != null ? successBlock.Html : "Success", false);
        }

        [ActionName("bulk-products")]
        public ActionResult BulkProducts()
        {
            var model = new RequestBrochureModel();
            if (AreaKind > AreaKind.General)
            {
                model.SelectedProduct = Area;
            }
            return GetCustomerDto("fd537b13-e2de-44d8-9b94-a34f00fead1d", model);
        }

        [HttpPost]
        [ActionName("bulk-products")]
        [TransactionScope]
        public ActionResult BulkProducts(RequestBrochureModel model)
        {
            SaveCustomerDto(model, "Online Bulk Products Request", 17, "");
            var successBlock = DbSession.Get<CmsBlock>(new Guid("80af402a-bbdc-4c86-9f70-a35700e0bb0b"));
            return Dialog(successBlock != null ? successBlock.Html : "Success", false);
        }






        [ActionName("call-me-back")]
        public ActionResult CallMeBack()
        {
            return View(new CallMeBackModel());
        }

        [HttpPost]
        [ActionName("call-me-back")]
        public ActionResult CallMeBack(CallMeBackModel model)
        {
            var str = new StringBuilder(1000);
            str.AppendLine("<HTML><BODY>");
            str.AppendLine("<H2>New Call Back Request</H2>");
            str.AppendLine("<br />");
            str.AppendLine("<b>From: </b>" + model.Name + "<br />");
            str.AppendLine("<b>Phone: </b>" + model.Phone + "<br />");
            str.AppendLine("<b>Day: </b>" + model.Day + "<br />");
            str.AppendLine("<b>Hour: </b>" + model.Time + "<br /><br />");
            str.AppendLine("<b>Sent: " + DateTime.Now + "</b>");
            str.AppendLine("</BODY></HTML>");
            var mlClient = new MailManager();
            mlClient.SendMail(WebGlobal.SystemMail, WebGlobal.SalesMail, "New Call Back Request", str.ToString());

            var successBlock = DbSession.Get<CmsBlock>(new Guid("361da8d9-9eb3-4a00-8773-a3a500cd5e72"));
            return Content(successBlock != null ? successBlock.Html : "Success");
        }






        public ActionResult Unsubscribe(string email)
        {
            return View(new UnsubscribeModel
            {
                Email = email
            });
        }

        [HttpPost]
        [TransactionScope]
        public ActionResult Unsubscribe(UnsubscribeModel model)
        {
            if (!ModelState.IsValid)
            {
                return Dialog("Invalid email");
            }
            if (!ValidateCaptcha())
            {
                return Dialog("Invalid captcha");
            }

            var unsubscriber = new Unsubscriber(model.Email.Replace(" ", "").ToLower());
            DbSession.Save(unsubscriber);

            var successBlock = DbSession.Get<CmsBlock>(new Guid("b4e1fb17-a6a6-4582-91e8-a63000ea81ab"));
            return Dialog(successBlock != null ? successBlock.Html : "Success");
        }









        #endregion

        [Jsonp]
        public ActionResult GetCatalogs()
        {
            var res = DbSession.QueryOver<CustomerCatalogType>().Where(cc => cc.WebsiteVisible).OrderBy(cc => cc.Inx).Asc.Cacheable().CacheMode(CacheMode.Normal).List().Select(r => new { r.ID, r.Name }).ToList();
            return JsonDataSet(res, JsonRequestBehavior.AllowGet);
        }

        [Jsonp]
        public ActionResult GetProducts()
        {
            return Json(DbSession.GetAll<Area>(true).Where(a => a.IsProduct).ToList(), JsonRequestBehavior.AllowGet);
        }

        [Jsonp]
        public ActionResult GetCountries()
        {
            var res = DbSession.QueryOver<Country>().Where(c => c.WebsiteVisible).OrderBy(c => c.Inx).Asc.Cacheable().CacheMode(CacheMode.Normal).List().Where(c => c.Regions.Any(r => r.WebsiteVisible)).Select(c => new { ID = c.ID == 0 ? ZEROID : c.ID, Name = c.Name_En }).ToList();
            return JsonDataSet(res, JsonRequestBehavior.AllowGet);
        }

        [Jsonp]
        public ActionResult GetRegions()
        {
            var filter = Request.QueryString["$filter"];
            var strs = filter.Split("eq".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
            int country;
            var q = DbSession.QueryOver<Region>();
            if (strs.Length > 1 && Int32.TryParse(strs[1], out country))
            {
                country = country == ZEROID ? 0 : country;
                q = q.Where(r => r.Country.ID == country);
            }
            var res = q.Where(r => r.WebsiteVisible).OrderBy(r => r.Name_En).Asc.Cacheable().CacheMode(CacheMode.Normal).List().Where(r => r.SubRegions.Any(sr => sr.WebsiteVisible)).Select(r => new { r.ID, Name = r.Name_En }).ToList();
            return JsonDataSet(res, JsonRequestBehavior.AllowGet);
        }

        [Jsonp]
        public ActionResult GetSubRegions()
        {
            var filter = Request.QueryString["$filter"];
            var strs = filter.Split("eq".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
            int region;
            var q = DbSession.QueryOver<SubRegion>();
            if (strs.Length > 1 && Int32.TryParse(strs[1], out region))
            {
                q = q.Where(r => r.Region.ID == region);
            }
            var res = q.Where(sr => sr.WebsiteVisible).OrderBy(r => r.Name_En).Asc.Cacheable().CacheMode(CacheMode.Normal).List().Select(sr => new { sr.ID, Name = sr.Name_En }).ToList();
            return JsonDataSet(res, JsonRequestBehavior.AllowGet);
        }
        
    }
}
