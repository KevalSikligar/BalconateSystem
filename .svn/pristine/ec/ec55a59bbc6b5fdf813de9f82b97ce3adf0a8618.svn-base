using System;

namespace Balcony.Miracle.Web.Cms {
    
    public class Article : Page {

        public const int THUMB_HEIGHT = 130;

        public Article() {
            // ReSharper disable DoNotCallOverridableMethodsInConstructor
            Name = "[New Article]";
            Url = "/articles/[name-with-dashes]";
            DateCreated = DateTime.Now;
            Body = "<p>[ARTICLE BODY]</p>";
            // ReSharper restore DoNotCallOverridableMethodsInConstructor
        }

        public virtual DateTime DateCreated { get; set; }

        public virtual CmsBlock SharedLinks { get; set; }

        public virtual GalleryImage Image { get; set; }


    }
}
