using System;
using System.ComponentModel.DataAnnotations;
using System.Drawing;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Cms;

namespace Balcony.Miracle.Web.Models {

    public class CurvedDoorQuoteModel : IPageHeader {

        public CurvedDoorQuoteModel() {

        }

        public CurvedDoorQuoteModel(CurvedDoorModelLocal model) : 
            this() {
            TypeId = model.ID;
           
            MinHeight = model.CurvedDoorSystem.MinHeight;
            MaxHeight = model.CurvedDoorSystem.MaxHeight;
            MinLength = model.MinLength;
            MaxLength = model.MaxLength;

            ShortName = model.ShortName_En;
            H1 = model.H1;
            Title = model.Title;
            Description = model.Description;
            Keywords = model.Keywords;

            ProductDescription = model.Desc1;

            CurvedDoorModelName = model.Name_En;
            CurvedDoorModelShortName = model.ShortName_En;
            LengthPosition = new Point(model.LengthX, model.LengthY);
            HeightPosition = new Point(model.HeightX, model.HeightY);
            DepthPosition = new Point(model.DepthX, model.DepthY);
            WidthPosition = new Point(model.WidthX, model.WidthY);
        }


        public CurvedDoorQuoteModel(CurvedDoor cpd) : 
            this(cpd.CurvedDoorModel) {

            ColorId = cpd.Color.ID;
            GlassId = cpd.GlassSystem.ID;
            
            Height = cpd.Height;
            Length = cpd.Length;
            Width = cpd.Width > 0 ? cpd.Width : (int?)null;
            Depth = cpd.Depth > 0 ? cpd.Depth : (int?)null;
        }


        public int TypeId { get; set; }

        public int ColorId { get; set; }
        
        public int GlassId { get; set; }

        public string CurvedDoorModelShortName { get; set; }

        public string CurvedDoorModelName { get; set; }

        public Point LengthPosition { get; set; }

        public Point HeightPosition { get; set; }

        public Point DepthPosition { get; set; }

        public Point WidthPosition { get; set; }
        

        [Required(ErrorMessage = "This is required")]
        [SpecifiedRange("MinHeight", "MaxHeight")]
        public int? Height { get; set; }

        public int MinHeight { get; set; }
        public int MaxHeight { get; set; }

        [Required(ErrorMessage = "This is required")]
        [SpecifiedRange("MinLength", "MaxLength")]
        public int? Length { get; set; }

        public int MinLength { get; set; }
        public int MaxLength { get; set; }


        public int? Width { get; set; }

        public int? Depth { get; set; }

        public string ShortName { get; set; }

        public string H1 { get; set; }

        public string Title { get; set; }
        
        public string Description { get; set; }
        
        public string Keywords { get; set; }

        public string ProductDescription { get; set; }

        public Guid? FooterLinksID
        {
            get { return null; }
        }

    }
}