using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Balcony.Miracle.Core.Services.TemplateService;
using Balcony.Miracle.Web.Cms;

namespace Balcony.Miracle.Web.Models
{
    public class StandardPageModel
    {

        public StandardPageModel(StandardPage page, HttpContextBase context)
        {
            Page = page;
            Body = TemplateService.GetText(page.Body, PrepareTemplateProps(context));
        }

        public StandardPage Page { get; private set; }

        public string Body { get; private set; }

        private static Dictionary<string, object> PrepareTemplateProps(HttpContextBase context)
        {
            var result = new Dictionary<string, object>();
            if (context.Request == null) 
                return result;

            if (context.Request.QueryString != null)
            {
                foreach (string key in context.Request.QueryString.Keys)
                {
                    result["_" + key] = context.Request.QueryString[key];
                }
            }

            if (context.Request.Form != null)
            {
                foreach (string key in context.Request.Form.Keys)
                {
                    result["_" + key] = context.Request.Form[key];
                }
            }

            return result;
        }
    }
}