using System;
using System.Data;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Core.Contracts;
using Balcony.Miracle.Web.Controllers;

namespace Balcony.Miracle.Web.Areas.api.Controllers {

    [ApiAuthorize]
    public class NumServiceController : BaseController {      

        [HttpPost]
        [TransactionScope(IsolationLevel.Serializable)]
        public ActionResult GetNumber(string entity, string company) {
            var number = DbSession.QueryOver<Number>().Where(n => n.EntityTypeID == entity).And(n => n.CompanyID == company).SingleOrDefault();
            if (number == null) {
                throw new Exception("Number not found");
            }
            var res = number.Low;
            number.Low += 1;
            DbSession.SaveOrUpdate(number);
            return Xml(new NumberDto {Number = res});
        }
       
    }
}
