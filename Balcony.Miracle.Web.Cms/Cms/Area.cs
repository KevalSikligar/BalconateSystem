using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Balcony.Miracle.Core;

namespace Balcony.Miracle.Web.Cms {

    public class Area : BaseEntity<AreaKind>, IPageHeader {

        public Area() : 
            base(AreaKind.New) {
            // ReSharper disable DoNotCallOverridableMethodsInConstructor
            Name = "New Page";
            ArticleTags = new List<Tag>();
            CaseStudyTags = new List<Tag>();
            PhotoTags = new List<Tag>();
            LargeImages = new List<GalleryImage>();
            SmallImages = new List<GalleryImage>();
            DownloadTags = new List<Tag>();
            // ReSharper restore DoNotCallOverridableMethodsInConstructor
        }

        [Required]
        public virtual string Name { get; set; }

        public virtual CmsBlock Links { get; set; }

        public virtual IList<Tag> ArticleTags { get; protected set; }

        public virtual IList<Tag> CustomerReviewTags { get; protected set; }

        public virtual IList<Tag> DownloadTags { get; protected set; }

        public virtual IList<Tag> CaseStudyTags { get; protected set; }

        public virtual IList<Tag> PhotoTags { get; protected set; }

        public virtual IList<Tag> GetTagsForIndexType(IndexType indexType)
        {
            switch (indexType)
            {
                case IndexType.Gallery:
                    return PhotoTags;
                case IndexType.Articles:
                    return ArticleTags;
                case IndexType.CaseStudies:
                    return CaseStudyTags;
                case IndexType.CustomerReviews:
                    return CustomerReviewTags;
                case IndexType.Downloads:
                    return DownloadTags;
                default:
                    throw new ArgumentOutOfRangeException("indexType", indexType, null);
            }
        }

        public virtual Guid? FooterLinksID { get; set; }

        public virtual IList<GalleryImage> LargeImages { get; protected set; }

        public virtual IList<GalleryImage> SmallImages { get; protected set; }


        public virtual string DropdownBody { get; set; }
        public virtual string HomepageBody { get; set; }
        public virtual string HomepageTitle { get; set; }
        public virtual string HomepageH1 { get; set; }
        public virtual string HomepageKeywords { get; set; }
        public virtual string HomepageDescription { get; set; }

        public virtual bool IsProduct { get; set; }

        public virtual string QuoteAttachment1 { get; set; }
        public virtual string QuoteAttachment2 { get; set; }
        public virtual string QuoteAttachment3 { get; set; }
        public virtual string QuoteAttachment4 { get; set; }

        public virtual string ArticlesBody { get; set; }
        public virtual string ArticlesTitle { get; set; }
        public virtual string ArticlesKeywords { get; set; }
        public virtual string ArticlesDescription { get; set; }

        public virtual IPageHeader ArticlesPageHeader
        {
            get
            {
                return new PageHeader
                {
                    Title = ArticlesTitle, Description = ArticlesDescription, Keywords = ArticlesKeywords
                };
            }
        }

        public virtual string CaseStudiesBody { get; set; }
        public virtual string CaseStudiesTitle { get; set; }
        public virtual string CaseStudiesKeywords { get; set; }
        public virtual string CaseStudiesDescription { get; set; }

        public virtual IPageHeader CaseStudiesPageHeader
        {
            get
            {
                return new PageHeader
                {
                    Title = CaseStudiesTitle, Description = CaseStudiesDescription, Keywords = CaseStudiesKeywords
                };
            }
        }

        public virtual string PhotosBody { get; set; }
        public virtual string PhotosTitle { get; set; }
        public virtual string PhotosKeywords { get; set; }
        public virtual string PhotosDescription { get; set; }

        public virtual IPageHeader PhotosPageHeader
        {
            get
            {
                return new PageHeader
                {
                    Title = PhotosTitle, Description = PhotosDescription, Keywords = PhotosKeywords
                };
            }
        }

        public virtual string CustomerReviewsBody { get; set; }
        public virtual string CustomerReviewsTitle { get; set; }
        public virtual string CustomerReviewsKeywords { get; set; }
        public virtual string CustomerReviewsDescription { get; set; }

        public virtual IPageHeader CustomerReviewsPageHeader
        {
            get
            {
                return new PageHeader
                {
                    Title = CustomerReviewsTitle, Description = CustomerReviewsDescription, Keywords = CustomerReviewsKeywords
                };
            }
        }

        public virtual string DownloadsBody { get; set; }
        public virtual string DownloadsTitle { get; set; }
        public virtual string DownloadsKeywords { get; set; }
        public virtual string DownloadsDescription { get; set; }

        public virtual IPageHeader DownloadsPageHeader
        {
            get
            {
                return new PageHeader
                {
                    Title = DownloadsTitle, Description = DownloadsDescription, Keywords = DownloadsKeywords
                };
            }
        }

        public virtual IPageHeader GatPageHeaderForIndexType(IndexType indexType)
        {
            switch (indexType)
            {
                case IndexType.Gallery:
                    return PhotosPageHeader;
                case IndexType.Articles:
                    return ArticlesPageHeader;
                case IndexType.CaseStudies:
                    return CaseStudiesPageHeader;
                case IndexType.CustomerReviews:
                    return CustomerReviewsPageHeader;
                case IndexType.Downloads:
                    return DownloadsPageHeader;
            }
            throw new ArgumentOutOfRangeException("indexType", indexType, null);
        }

        public virtual string GatPageBodyForIndexType(IndexType indexType)
        {
            switch (indexType)
            {
                case IndexType.Gallery:
                    return PhotosBody;
                case IndexType.Articles:
                    return ArticlesBody;
                case IndexType.CaseStudies:
                    return CaseStudiesBody;
                case IndexType.CustomerReviews:
                    return CustomerReviewsBody;
                case IndexType.Downloads:
                    return DownloadsBody;
            }
            throw new ArgumentOutOfRangeException("indexType", indexType, null);
        }

        public static AreaKind ProductToAreaKind(ProductDetails product)
        {
            if (product is Juliette)
            {
                return AreaKind.Juliettes;
            }
            if (product is Balustrade)
            {
                return AreaKind.Balustrades;
            }
            if (product is CurvedDoor)
            {
                return AreaKind.CurvedDoors;
            }
            if (product is Accessory)
            {
                return AreaKind.Balconano;
            }
            return AreaKind.General;
        }

        #region Implementation of IPageHeader

        public virtual string Title
        {
            get { return HomepageTitle; }
            set { HomepageTitle = value; }
        }

        public virtual string Description
        {
            get { return HomepageDescription; }
            set { HomepageDescription = value; }
        }

        public virtual string Keywords
        {
            get { return HomepageKeywords; }
            set { HomepageKeywords = value; }
        }

        #endregion
    }
}
