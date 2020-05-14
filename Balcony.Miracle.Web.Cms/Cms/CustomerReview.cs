using System;
using System.ComponentModel.DataAnnotations;

namespace Balcony.Miracle.Web.Cms {

    public class CustomerReview : Page
    {

        public CustomerReview() {
            // ReSharper disable DoNotCallOverridableMethodsInConstructor
            DateCreated = DateTime.Now;
            // ReSharper restore DoNotCallOverridableMethodsInConstructor
        }
        
        public virtual string Email { get; set; }
        
        public virtual DateTime DateCreated { get; set; }
        
        public virtual int Rating { get; set; }
        
        public virtual bool Visible { get; set; }

        [Required]
        public override string Body { get; set; }
        
        [Required]
        public override string Title { get; set; }

        public virtual string CompanyReview { get; set; }
        
        public virtual string AfterSaleReview { get; set; }
        
        public virtual string ValueForMoneyReview { get; set; }
        
        public virtual GalleryImage Image { get; set; }
    }
}
