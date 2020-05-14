using System;
using System.Web.Mvc;
using Balcony.Miracle.Web.Cms;
using Balcony.Miracle.Web.Models;

namespace Balcony.Miracle.Web.Controllers {

    public class TagsController : BaseController {

        [Jsonp]
        [SessionScope]
        public ActionResult GetTags(Guid? id) {
            if (id == null) {
                return Json(TagCategories, JsonRequestBehavior.AllowGet);
            }
            return Json(DbSession.Get<TagCategory>(id.Value).Tags, JsonRequestBehavior.AllowGet);
        }

        [SessionScope]
        [ActionName("tag-description")]
        public ActionResult TagDescription(Guid? id) {
            Tag tag;
            if (id == null || (tag = DbSession.Get<Tag>(id.Value)) == null) {
                return HttpNotFound();
            }
            var model = new DescriptionModel();
            model.Body = tag.DescHtml;
            model.Title = tag.Name + " Description";
            model.Keywords = "";
            model.Description = tag.Name;
            PageHeader = model;
            return View("Description", model);
        }

        [SessionScope]
        [ActionName("tag-category-description")]
        public ActionResult TagCategoryDescription(Guid? id) {
            TagCategory category;
            if (id == null || (category = DbSession.Get<TagCategory>(id.Value)) == null) {
                return HttpNotFound();
            }
            var model = new DescriptionModel();
            model.Body = category.DescHtml;
            model.Title = category.Name + " Description";
            model.Keywords = "";
            model.Description = category.Name;
            PageHeader = model;
            return View("Description", model);
        }

    }
}
