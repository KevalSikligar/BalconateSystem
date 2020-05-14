using System;
using System.ComponentModel.DataAnnotations;
using Balcony.Miracle.Core;

namespace Balcony.Miracle.Web.Cms {

    public class CmsBlock : BaseEntity<Guid> {

        public CmsBlock() {
            // ReSharper disable DoNotCallOverridableMethodsInConstructor
            Name = "[New CMS Block]";
            // ReSharper restore DoNotCallOverridableMethodsInConstructor
        }

        [Required]
        public virtual string Name { get; set; }

        public virtual string Html { get; set; }

    }
}
