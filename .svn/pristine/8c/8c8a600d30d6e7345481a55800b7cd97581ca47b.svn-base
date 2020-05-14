using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Balcony.Miracle.Core;

namespace Balcony.Miracle.Web.Cms {

    public class TagCategory : BaseEntity<Guid> {

        public TagCategory() {
            // ReSharper disable DoNotCallOverridableMethodsInConstructor
            Tags = new List<Tag>();
            // ReSharper restore DoNotCallOverridableMethodsInConstructor
        }

        [Required]
        public virtual string Name { get; set; }
        
        public virtual string DescHtml { get; set; }
      
        public virtual bool ShowDesc { get; set; }

        public virtual IList<Tag> Tags { get; protected set; }

        public virtual int Inx { get; set; }

        public virtual bool HasTags {
            get {
                return Tags.Count > 0;
            }
        }
    }
}
