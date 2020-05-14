using System;

namespace Balcony.Miracle.Web.Cms {
    
    public class CaseStudy : Page {

        public const int THUMB_WIDTH = 55;

        public CaseStudy() {
            // ReSharper disable DoNotCallOverridableMethodsInConstructor
            Name = "[New Case Study]";
            Url = "/case-studies/[name-with-dashes]";
            DateCreated = DateTime.Now;
            Body = "<p>[CASE STUDY BODY]</p>";
            // ReSharper restore DoNotCallOverridableMethodsInConstructor
        }

        public virtual DateTime DateCreated { get; set; }

        public virtual CmsBlock SharedLinks { get; set; }

        public virtual GalleryImage Image { get; set; }


    }
}
