using System;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Cms;
using Balcony.Miracle.Web.Models;
using Balcony.Miracle.Web.Shared;
using Balcony.Miracle.Core.Services.TemplateService;
namespace Balcony.Miracle.Web.Controllers
{
    public class GeneralController : BaseController
    {
        public GeneralController() :
            base(AreaKind.General) {
        }
        public override ActionResult _fallback(string id)
        {
            return View("Homepage", Area);
        }

        public ActionResult Image(Guid id) {
            var storedFile = DbSession.Get<StoredFile>(id);
            if (storedFile == null)
                return HttpNotFound();

            var stream = new MemoryStream(storedFile.Data);

            return File(stream, "image");
        }

        [ActionName("send-email")]
        [ValidateInput(false)]
        public ActionResult SendEmail(string to, string subject, string body)
        {
            var emailValidation = new EmailAddressAttribute();
            if (String.IsNullOrEmpty(to) || !emailValidation.IsValid(to) || !to.EndsWith("@balconette.co.uk", StringComparison.InvariantCultureIgnoreCase))
                throw new ArgumentException("Invalid email address");

            var mlClient = new MailManager();
            mlClient.SendMail(WebGlobal.SystemMail, to, subject ?? "", body ?? "");

            return Json(new { });
        }


       
        //RSVP

        [ActionName("rsvp")]
        public ActionResult RSVP()
        {
             var model = new RSVPModel();
             if (AreaKind > AreaKind.General)
             {
                 model.SelectedProduct = Area;
             }
             return GetCustomerDto("09a0b9fe-bc41-4fa4-a365-a7cb00e4b31c", model);
            
           
        }

        [HttpPost]
        [ActionName("rsvp")]
        [TransactionScope]
        public ActionResult RSVP(RSVPModel model)
        {
            var notes = new StringBuilder(1000);
            notes.AppendLine(model.Notes);
           

             var customer = SaveCustomerDto(model, "Customer RSVP to Balcony open house event", 500, notes.ToString());

             try
             {
                 var strBody = new StringBuilder(1000);
                 strBody.AppendLine("<html><body>");
                 strBody.AppendLine("<h2><u>Customer RSVPed to Balcony open house event</u></h2>");
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
                 strBody.AppendLine("<tr><td align=right><b>Notes:</b></td><td>" + model.Notes + "</td></tr>");
                 strBody.AppendLine("<tr><td align=right nowrap><b>BV Subscription:</b></td><td>" + (model.Subscription ? "Yes" : "No") + "</td></tr>");
                 strBody.AppendLine("</table></body></html>");
                 var mlClient = new MailManager();
                 mlClient.SendMail(WebGlobal.SystemMail, WebGlobal.BrochuresMail, "Customer RSVPed to Balcony open house event", strBody.ToString());
                 var body = TemplateService.GetText(DbSession.Get<Template>(new Guid("f02e41b9-c9e9-e011-9d71-58b0358c18e0")).Body, customer);
                 
             }
             catch (Exception ex)
             {
                 WebGlobal.HandleException(ex, System.Web.HttpContext.Current);
             }


            return Redirect("/general/rsvp-success");


        }
        //END RSVP


        //ArrangeVisit

        [ActionName("arrange-a-visit")]
        public ActionResult ArrangeVisit()
        {
            var model = new ArrangeVisitModel();
            if (AreaKind > AreaKind.General)
            {
                model.SelectedProduct = Area;
            }
            return GetCustomerDto("A386ECA9-08D5-4717-BC5E-A3D6012943B5", model);


        }

        [HttpPost]
        [ActionName("arrange-a-visit")]
        [TransactionScope]
        public ActionResult ArrangeVisit(ArrangeVisitModel model)
        {
            var notes = new StringBuilder(1000);
            notes.AppendLine(model.Notes);


            var customer = SaveCustomerDto(model, "Ambassador visit request", 21, notes.ToString());

            try
            {
                var strBody = new StringBuilder(1000);
                strBody.AppendLine("<html><body>");
                strBody.AppendLine("<h2><u>Customer requested Ambassador visit</u></h2>");
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
                
                strBody.AppendLine("<tr><td> </td><td></td></tr>");
                strBody.AppendLine("<tr><td align=right><b>Notes:</b></td><td>" + model.Notes + "</td></tr>");
                
                strBody.AppendLine("</table></body></html>");
                var mlClient = new MailManager();
                mlClient.SendMail(WebGlobal.SystemMail, "ambassador@balconette.co.uk", "Ambassador visit request", strBody.ToString());
            }
            catch (Exception ex)
            {
                WebGlobal.HandleException(ex, System.Web.HttpContext.Current);
            }


            return Redirect("/general/ambassador-visit-request-success");


        }
        //END RSVP


        [ActionName("contact-us")]
        public ActionResult ContactUs()
        {
            var model = new ContactUsModel();
            return GetCustomerDto("7a445574-7fd4-4c13-af41-a34c00ad81e3", model);
        }

        [HttpPost]
        [ActionName("contact-us")]
        [TransactionScope]
        public ActionResult ContactUs(ContactUsModel model)
        {
            var emailAttr = new EmailAttribute();
            if (String.IsNullOrEmpty(model.FirstName) || String.IsNullOrEmpty(model.LastName) || String.IsNullOrEmpty(model.Email1) || !emailAttr.IsValid(model.Email1))
                throw new Exception("Invalid model");

            var customer = SaveCustomerDto(model, "Online Contact Request", 41, model.Notes ?? "", validateModel: false);
            try
            {
                var strBody = new StringBuilder(1000);
                strBody.AppendLine("<html><head><style>body{font-size: 12pt;font-family: Times New Roman;margin: 0px;}</style></head><body>");
                strBody.AppendLine(customer.DefaultContact.FullName + "<br />");
                if (!String.IsNullOrEmpty(customer.CompanyName))
                    strBody.AppendLine(customer.CompanyName + "<br />");
                strBody.AppendLine("<br /><br /><br />");
                strBody.AppendLine(customer.DefaultContact.Email);
                strBody.AppendLine("<br /><br />");
                var catalog = customer.CustomerCatalogs.FirstOrDefault();
                strBody.AppendLine(catalog != null ? catalog.Name : "");
                strBody.AppendLine("<br /><br />");
                if (!String.IsNullOrEmpty(customer.RawCustomerContacts[0].PrimaryPhone))
                    strBody.AppendLine("T: " + customer.RawCustomerContacts[0].PrimaryPhone + "<br />");
                strBody.AppendLine("<br /><br />");
                strBody.AppendLine(model.Notes);
                strBody.AppendLine("</body></html>");

                var mlClient = new MailManager();
                mlClient.SendMail(WebGlobal.SystemMail, WebGlobal.SalesMail, "New Contact Request", strBody.ToString());
            }
            catch (Exception ex)
            {
                WebGlobal.HandleException(ex, System.Web.HttpContext.Current);
            }

            return Redirect("/general/contact-us-success");
        }

        public ActionResult CmsRedirect(string url, bool? permanent)
        {
            if (String.IsNullOrEmpty(url))
                return HttpNotFound();

            return permanent.HasValue && permanent.Value ? RedirectPermanent(url) : Redirect(url);
        }
    
    }
}