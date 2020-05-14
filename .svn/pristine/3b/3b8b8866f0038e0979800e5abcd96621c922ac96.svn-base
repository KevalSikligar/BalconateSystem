using System.Collections.Generic;
using Balcony.Miracle.Core;

namespace Balcony.Miracle.Web.Models
{
    public class BalustradeDrawingModel
    {
        public int ViewIndex { get; set; }
        public int SystemId { get; set; }
        public int GlassId { get; set; }
        public int ColorId { get; set; }
        public int Height { get; set; }
        public BalustradeSection.SectionFinishType StartType { get; set; }
        public BalustradeSection.SectionFinishType EndType { get; set; }
        public int? StartWallAngle { get; set; }
        public int? EndWallAngle { get; set; }
        public IList<BalustradeDrawingSectionModel> Sections { get; set; }
        public int? HRBR { get; set; }
        public int? BRHR { get; set; }
        public int? WG { get; set; }
        public int? GW { get; set; }
        public int? Quantity { get; set; }
        public BalustradeDrawingModelCartType? CartType { get; set; }
    }

    public enum BalustradeDrawingModelCartType
    {
        Partial,
        Full
    }

    public class BalustradeDrawingSectionModel
    {
        public int Length { get; set; }

        public double Angle { get; set; }

        public int? Ofst { get; set; }
    }
}