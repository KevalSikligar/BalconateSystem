using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Web.Script.Serialization;
using Balcony.Miracle.Core;
using NHibernate;

namespace Balcony.Miracle.Web.Cms {

    public class Tag : BaseEntity<Guid> {

        [Required]
        public virtual string Name { get; set; }

        public virtual string DescHtml { get; set; }

        public virtual bool ShowDesc { get; set; }

        [ScriptIgnore]
        public virtual TagCategory TagCategory { get; set; }
        
        [ScriptIgnore]
        public virtual IList<GalleryImage> GalleryImages { get; protected set; }

        [ScriptIgnore]
        public virtual IList<Page> Pages { get; protected set; }
        
        public virtual int Inx { get; set; }

        public virtual bool HasTags {
            get {
                return false;
            }
        }

       
    }
}
