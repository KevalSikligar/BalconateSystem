using System;
using Balcony.Miracle.Web.Cms;

namespace Balcony.Miracle.Web.Models {
    
    public class DescriptionModel : IPageHeader {

        public string Body { get; set; }

        public string Title { get; set; }

        public string Description { get; set; }

        public string Keywords { get; set; }

        public Guid? FooterLinksID
        {
            get { return null; }
        }

    }
}