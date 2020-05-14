using System;
using Balcony.Miracle.Core;

namespace Balcony.Miracle.Web.Cms {

    public class CmsRedirect : BaseEntity<Guid>
    {
        public virtual string Url { get; set; }

        public virtual string RedirectUrl { get; set; }

        public virtual bool IsPermanent { get; set; }
    }
}
