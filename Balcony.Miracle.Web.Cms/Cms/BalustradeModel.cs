using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Balcony.Miracle.Core;

namespace Balcony.Miracle.Web.Cms {

    public class BalustradeModel : BaseEntityWithMeta<Guid, BalustradeModel.ModelMeta>, IPageHeader {

        public BalustradeModel() {
            // ReSharper disable DoNotCallOverridableMethodsInConstructor
            Meta = new ModelMeta();
            // ReSharper restore DoNotCallOverridableMethodsInConstructor
        }

        [Required]
        public virtual string Url { get; set; }

        [Required]
        public virtual string Name { get; set; }

        public virtual string Title { get; set; }
        
        public virtual string H1 { get; set; }
        
        public virtual string Keywords { get; set; }

        public virtual Guid? FooterLinksID
        {
            get { return null; }
        }

        public virtual string Description { get; set; }

        public virtual int Inx { get; set; }

        public virtual string Image { get; set; }

        public virtual string Body { get; set; }

        public virtual List<ModelSection> Sections {
            get {
                return Meta.Sections;
            }
            set {
                Meta.Sections = value;
            }
        } 
        
        
        public class ModelMeta : MetaBase {

            public ModelMeta() {
                Sections = new List<ModelSection>();
            }

            public List<ModelSection> Sections { get; set; } 

        }

        public class ModelSection {

            public int X { get; set; }
            
            public int Y { get; set; }

            public bool Curved { get; set; }
        }


    }
}
