using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace Balcony.Miracle.Web.Utility
{
    public class EmailSender
    {
            public static bool Send(string subject, string content, string to)
            {
                try
                {
                    Boolean success = false;
                using (MailMessage mm = new MailMessage("info@dictalogic.com", "competition@balconette.co.uk"))
                {
                    mm.Subject = subject;
                    mm.Body = content;
                    mm.IsBodyHtml = false;
                  
                    using (SmtpClient smtp = new SmtpClient())
                    {
                        smtp.Host = "smtp.gmail.com";
                        smtp.EnableSsl = true;
                        NetworkCredential NetworkCred = new NetworkCredential("info@dictalogic.com", "Dictalogic1");
                        smtp.UseDefaultCredentials = true;
                        smtp.Credentials = NetworkCred;
                        smtp.Port = 587;
                        smtp.Send(mm);
                        success = true;
                    }
                }
                return success;
            }
                catch (Exception ex)
                {
                    return false;
                }
            }
    }
}