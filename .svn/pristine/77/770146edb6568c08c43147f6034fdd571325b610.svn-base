using System;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Controllers;

namespace Balcony.Miracle.Web.Areas.Api.Controllers {

    [ApiAuthorize]
    public class GeneralServiceController : BaseController {      

        [HttpPost]
        [TransactionScope]
        public ActionResult GetConnStringFormat(string username, string password) {
            var str = "Data Source=\"{0}\";Initial Catalog={1};MultipleActiveResultSets=True;Connect Timeout=300;Network Library=dbmssocn;User ID=sa;Password=a9215361;";
            var user = DbSession.Get<User>(username);
            if (user.LoginEnabled && user.ValidatePassword(password)) {
                return Xml(str);
            }
            return Xml(String.Empty);
        }

        [TransactionScope]
        public ActionResult Test() {
            return Content(DbSession.CurrentConfig().MiracleUkVersion.ToString());
        }
    }
}
