using System.Web.Mvc;
using Balcony.Miracle.Core;
using NHibernate.Context;

namespace Balcony.Miracle.Web {
        
    public class SessionScope : ActionFilterAttribute {

        public override void OnActionExecuting(ActionExecutingContext filterContext) {
            Bind();
        }
      
        public static void Bind() {
            if (!CurrentSessionContext.HasBind(Global.SessionFactory)) {
                var sess = Global.SessionFactory.OpenSession();
                CurrentSessionContext.Bind(sess);
            } 
        }

        
    }
}