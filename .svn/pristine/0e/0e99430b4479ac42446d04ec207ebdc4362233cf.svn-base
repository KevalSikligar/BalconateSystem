using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Balcony.Miracle.Core;

namespace Balcony.Miracle.Web.Cms {

    public class Page : BaseEntity<Guid>, IPageHeader {
        private string url;
        private string name;

        public Page() {
            // ReSharper disable DoNotCallOverridableMethodsInConstructor
            Name = "New Page";
            Tags = new List<Tag>();
            UseTemplate = true;
            // ReSharper restore DoNotCallOverridableMethodsInConstructor
        }

        [Required]
        public virtual string Url {
            get {
                return url;
            }
            set {
                url = value != null ? value.ToLower().Trim() : "";
            }
        }

        [Required]
        public virtual string Name {
            get { return name; }
            set { name = value != null ? value.Trim() : null; }
        }

        [Required]
        public virtual string Title { get; set; }
        
        public virtual string Description { get; set; }
        
        public virtual string Keywords { get; set; }
        
        public virtual Area Area { get; set; }

        public virtual string Body { get; set; }

        public virtual string Head { get; set; }

        public virtual string Footer { get; set; }
        
        public virtual bool UseTemplate { get; set; }

        public virtual int Inx { get; set; }

        public virtual string ThumbTitle { get; set; }

        public virtual string ThumbDescription { get; set; }


        public static IList<ComboItem> AreaKindList {
            get {
                return Global.EnumToList<AreaKind>();
            }
        }

        public virtual IList<Tag> Tags { get; protected set; }


        public virtual Guid? FooterLinksID { get; set; }


        public virtual string ThumbTitleDisplay {
            get { return String.IsNullOrEmpty(ThumbTitle) ? Name : ThumbTitle; }
        }

        public virtual string ThumbDescriptionDisplay {
            get { return String.IsNullOrEmpty(ThumbDescription) ? Description : ThumbDescription; }
        }


    }
}
