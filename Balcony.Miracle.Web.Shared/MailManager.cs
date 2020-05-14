using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Mail;
using System.Threading;
using System.Linq;
using System.Web;

namespace Balcony.Miracle.Web.Shared {

    public class MailManager {
        
        public void SendMail(string @from, string to, string subject, string body, IEnumerable<string> attachments) {
            SendMail(@from, to, subject, body, attachments.Select(att => new Attachment(att)));
        }

        public void SendMail(string @from, string to, string subject, string body, params string[] attachments) {
            SendMail(@from, to, subject, body, attachments.AsEnumerable());
        }

        public void SendMail(string @from, string to, string subject, string body, IEnumerable<Attachment> attachments) {
            if ((String.IsNullOrEmpty(@from) | String.IsNullOrEmpty(to) | String.IsNullOrEmpty(subject))) {
                return;
            }
            var mMsg = new MailMessage(@from, to, subject, body);
            mMsg.IsBodyHtml = true;
            if (attachments != null) {
                foreach (var attachment in attachments) {
                    mMsg.Attachments.Add(attachment);
                }
            }
            SendMail(mMsg);
        }

        public void SendMail(MailMessage mailMessage) {
            ThreadPool.QueueUserWorkItem(DoSendMail, mailMessage);
        }

        private static void DoSendMail(object stateInfo) {
            var mm = (MailMessage) stateInfo;
            var sc = new SmtpClient("email-smtp.eu-west-1.amazonaws.com", 2587);
            var crdntl = new NetworkCredential("AKIAJAOGEJY6RQFW567A", "AmAUvYhRT4dJHeuRZut0boSgJsrlDPEOlbLIKvRRxLpB");
            sc.Credentials = crdntl;
            sc.DeliveryMethod = SmtpDeliveryMethod.Network;
            sc.EnableSsl = true;
            try {
                sc.Send(mm);
            } catch (Exception ex) {
                WebGlobal.HandleException(ex, HttpContext.Current);
            } finally {
                try {
                    mm.Dispose();
                } catch (Exception ex) {
                    WebGlobal.HandleException(ex, HttpContext.Current);
                }
            }
        }

    }
}
