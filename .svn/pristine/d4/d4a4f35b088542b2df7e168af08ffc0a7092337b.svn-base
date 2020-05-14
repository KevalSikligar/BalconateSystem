using System.Web;
using Balcony.Miracle.Core;
using NHibernate.Context;

namespace Balcony.Miracle.Web.Shared {
    
    public class NHibernateSessionModule : IHttpModule {
       
        public void Dispose() {
       
        }

        public void Init(HttpApplication context) {
            context.BeginRequest +=
                delegate {
                    var session = Global.SessionFactory.OpenSession();
                    CurrentSessionContext.Bind(session);
                };
            context.EndRequest +=
                delegate {
                    CurrentSessionContext.Unbind(Global.SessionFactory);
                };
        }
    }
}
