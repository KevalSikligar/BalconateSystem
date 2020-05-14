using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Cms;
using NHibernate;

namespace Balcony.Miracle.Web.Areas.Admin.Controllers {

    public class CustomerReviewsController : AdminBaseController {
        
       [SessionScope]
       public ActionResult Index() {

           return View(DbSession.QueryOver<CustomerReview>()
               .OrderBy(p => p.Area).Asc
               .ThenBy(p => p.DateCreated).Desc
               .Cacheable()
               .CacheMode(CacheMode.Normal)
               .List());
       }

        [SessionScope]
        public ActionResult Edit(Guid? id) {
            var page = id == null ? new CustomerReview() : DbSession.Get<CustomerReview>(id.Value);
            if (page == null) {
                return HttpNotFound();
            }
            ViewBag.Areas = DbSession.GetAll<Area>(true);
            return View(page);
        }

        [HttpPost]
        [TransactionScope]
        [ActionName("Edit")]
        [ValidateInput(false)]
        public ActionResult EditPost(Guid id, AreaKind farea, IList<GalleryImage> images)
        {
            CustomerReview page;
            if (Guid.Empty.Equals(id))
            {
                page = new CustomerReview();
            }
            else
            {
                page = DbSession.Get<CustomerReview>(id);
                page.Image = null;
                page.Tags.Clear();
            }
            if (TryUpdateModel(page)) {
                var dtos = page.Tags.ToList();
                page.Tags.Clear();
                foreach (var dtoTag in dtos)
                {
                    page.Tags.Add(DbSession.Get<Tag>(dtoTag.ID));
                }
                page.Area = DbSession.Get<Area>(farea);
                if (images != null)
                {
                    ImagesController.SaveImages(images, DbSession);
                    page.Image = images.FirstOrDefault(img => !img.ShouldDelete);
                }
                DbSession.SaveOrUpdate(page);
                DbSession.Flush();
                return RedirectToAction("Edit", new { id = page.ID });
            }

            ViewBag.Areas = DbSession.GetAll<Area>(true);
            return View(page);
        }
    }
}