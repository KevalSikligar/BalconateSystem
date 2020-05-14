using System.Data;
using System.Web;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using NHibernate;
using NHibernate.Context;

namespace Balcony.Miracle.Web {
        
    public class TransactionScope : ActionFilterAttribute {


        public IsolationLevel IsolationLevel { get; set; }

        public TransactionScope() {
            IsolationLevel = IsolationLevel.Unspecified;
        }

        public TransactionScope(IsolationLevel isolationLevel) {
            IsolationLevel = isolationLevel;
        }

        public override void OnActionExecuting(ActionExecutingContext filterContext) {
            if (!CurrentSessionContext.HasBind(Global.SessionFactory)) {
                var sess = Global.SessionFactory.OpenSession();
                CurrentSessionContext.Bind(sess);
            }   
            var trans = HttpContext.Current.Items[AppKeys.TRANSACTION_KEY] as ITransaction;
            if (trans == null) {
                trans = Global.CurrentSession.BeginTransaction(IsolationLevel);
                HttpContext.Current.Items[AppKeys.TRANSACTION_KEY] = trans;
            }            
        }

    }
}