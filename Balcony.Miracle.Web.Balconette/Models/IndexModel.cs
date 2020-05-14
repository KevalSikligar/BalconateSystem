using System.Collections.Generic;
using System.Linq;
using Balcony.Miracle.Web.Cms;

namespace Balcony.Miracle.Web.Models
{
    public class IndexModel<TModel>
    {
        public const string NO_ITEMS_TEXT = "No items found ...";

        public IEnumerable<TModel> Results { get; set; }

        public ICollection<Tag> Tags { get; set; }

        public IEnumerable<IGrouping<TagCategory, Tag>> TagCategories { get; set; }

        public bool HideFilterBar { get; set; }

        public AreaKind AreaKind { get; set; }

        public string Body { get; set; }
    }
}