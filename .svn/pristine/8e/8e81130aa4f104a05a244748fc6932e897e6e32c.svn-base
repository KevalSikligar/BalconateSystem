using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Balcony.Miracle.Core;
using Balcony.Miracle.Web.Cms;

namespace Balcony.Miracle.Web.Areas.Admin.Controllers {

    public class AreasController : AdminBaseController {
        
       [SessionScope]
       public ActionResult Index() {

           return View(DbSession.GetAll<Area>(true).ToList());
       }

     
        [SessionScope]
        public ActionResult Edit(AreaKind? id) {
           Area area;
           if (id == null) {
               area = new Area();
           } else {
               area = DbSession.Get<Area>(id.Value);
           }
           if (area == null) {
               return HttpNotFound();
           }
           ViewBag.CmsBlocks = DbSession.GetAll<CmsBlock>(true);

           return View(area);
       }

        [HttpPost]
        [TransactionScope]
        [ValidateInput(false)]
        [ActionName("Edit")]
        public ActionResult EditPost(AreaKind id, Guid? flinks, Guid? footer, IList<GalleryImage> flargeImages, IList<GalleryImage> fsmallImages, HttpPostedFileBase qa1, HttpPostedFileBase qa2, HttpPostedFileBase qa3, HttpPostedFileBase qa4)
        {
            Area area;

            if (id == AreaKind.New) {
                area = new Area();
            } else {
                area = DbSession.Get<Area>(id);
                area.Links = null;
                area.ArticleTags.Clear();
                area.CaseStudyTags.Clear();
                area.PhotoTags.Clear();
            }
            var oldqa1 = area.QuoteAttachment1;
            var oldqa2 = area.QuoteAttachment2;
            var oldqa3 = area.QuoteAttachment3;
            var oldqa4 = area.QuoteAttachment4;
            if (TryUpdateModel(area))
            {

                using (var trans = DbSession.BeginTransaction()) {
                    try {
                        var tagDtos = area.ArticleTags.ToList();
                        area.ArticleTags.Clear();
                        foreach (var dtoTag in tagDtos) {
                            area.ArticleTags.Add(DbSession.Get<Tag>(dtoTag.ID));
                        }

                        tagDtos = area.DownloadTags.ToList();
                        area.DownloadTags.Clear();
                        foreach (var dtoTag in tagDtos)
                        {
                            area.DownloadTags.Add(DbSession.Get<Tag>(dtoTag.ID));
                        }

                        tagDtos = area.CaseStudyTags.ToList();
                        area.CaseStudyTags.Clear();
                        foreach (var dtoTag in tagDtos) {
                            area.CaseStudyTags.Add(DbSession.Get<Tag>(dtoTag.ID));
                        }

                        tagDtos = area.PhotoTags.ToList();
                        area.PhotoTags.Clear();
                        foreach (var dtoTag in tagDtos) {
                            area.PhotoTags.Add(DbSession.Get<Tag>(dtoTag.ID));
                        }

                        tagDtos = area.CustomerReviewTags.ToList();
                        area.CustomerReviewTags.Clear();
                        foreach (var dtoTag in tagDtos)
                        {
                            area.CustomerReviewTags.Add(DbSession.Get<Tag>(dtoTag.ID));
                        }

                        if (qa1 != null) {
                            var name = Path.GetFileNameWithoutExtension(qa1.FileName).Trim().Replace(" ", "-");
                            var ext = Path.GetExtension(qa1.FileName).ToLower();
                            var path = "/content/uploads/" + Guid.NewGuid() + "/";
                            var dir = Server.MapPath(path);
                            if (!Directory.Exists(dir))
                                Directory.CreateDirectory(dir);
                            var url = path + name + ext;
                            qa1.SaveAs(Server.MapPath(url));
                            area.QuoteAttachment1 = url;
                        }
                        if (qa2 != null) {
                            var name = Path.GetFileNameWithoutExtension(qa2.FileName).Trim().Replace(" ", "-");
                            var ext = Path.GetExtension(qa2.FileName).ToLower();
                            var path = "/content/uploads/" + Guid.NewGuid() + "/";
                            var dir = Server.MapPath(path);
                            if (!Directory.Exists(dir))
                                Directory.CreateDirectory(dir);
                            var url = path + name + ext;
                            qa2.SaveAs(Server.MapPath(url));
                            area.QuoteAttachment2 = url;
                        }
                        if (qa3 != null) {
                            var name = Path.GetFileNameWithoutExtension(qa3.FileName).Trim().Replace(" ", "-");
                            var ext = Path.GetExtension(qa3.FileName).ToLower();
                            var path = "/content/uploads/" + Guid.NewGuid() + "/";
                            var dir = Server.MapPath(path);
                            if (!Directory.Exists(dir))
                                Directory.CreateDirectory(dir);
                            var url = path + name + ext;
                            qa3.SaveAs(Server.MapPath(url));
                            area.QuoteAttachment3 = url;
                        }
                        if (qa4 != null)
                        {
                            var name = Path.GetFileNameWithoutExtension(qa4.FileName).Trim().Replace(" ", "-");
                            var ext = Path.GetExtension(qa4.FileName).ToLower();
                            var path = "/content/uploads/" + Guid.NewGuid() + "/";
                            var dir = Server.MapPath(path);
                            if (!Directory.Exists(dir))
                                Directory.CreateDirectory(dir);
                            var url = path + name + ext;
                            qa4.SaveAs(Server.MapPath(url));
                            area.QuoteAttachment4 = url;
                        }

                        //large images
                        if (flargeImages != null) {
                            foreach (var img in flargeImages) {
                                if (img.ShouldDelete && area.LargeImages.Contains(img)) {
                                    area.LargeImages.Remove(img);
                                }
                                if (!img.ShouldDelete && !area.LargeImages.Contains(img)) {
                                    area.LargeImages.Add(img);
                                }
                            }
                            ImagesController.SaveImages(flargeImages, DbSession);
                        }


                        //small images
                        if (fsmallImages != null) {
                            foreach (var img in fsmallImages) {
                                if (img.ShouldDelete && area.SmallImages.Contains(img)) {
                                    area.SmallImages.Remove(img);
                                }
                                if (!img.ShouldDelete && !area.SmallImages.Contains(img)) {
                                    area.SmallImages.Add(img);
                                }
                            }
                            ImagesController.SaveImages(fsmallImages, DbSession);
                        }

                        //links
                        if (flinks.HasValue) {
                            area.Links = DbSession.Get<CmsBlock>(flinks.Value);
                        }

                        area.FooterLinksID = footer;

                        DbSession.SaveOrUpdate(area);
                        DbSession.Flush();
                        trans.Commit();
                        
                        //try to delete deleted files
                        if (!String.IsNullOrEmpty(oldqa1) && String.IsNullOrEmpty(area.QuoteAttachment1)) {
                            try {
                                System.IO.File.Delete(Server.MapPath(oldqa1));
                            } catch { }
                        }
                        if (!String.IsNullOrEmpty(oldqa2) && String.IsNullOrEmpty(area.QuoteAttachment2)) {
                            try {
                                System.IO.File.Delete(Server.MapPath(oldqa2));
                            } catch { }
                        }
                        if (!String.IsNullOrEmpty(oldqa3) && String.IsNullOrEmpty(area.QuoteAttachment3)) {
                            try {
                                System.IO.File.Delete(Server.MapPath(oldqa3));
                            } catch { }
                        }
                        if (!String.IsNullOrEmpty(oldqa4) && String.IsNullOrEmpty(area.QuoteAttachment4)) {
                            try {
                                System.IO.File.Delete(Server.MapPath(oldqa4));
                            } catch { }
                        }
                    } catch {
                        trans.Rollback();
                        throw;
                    }
                }
                return RedirectToAction("Edit", new { id = area.ID });
            }

            ViewBag.CmsBlocks = DbSession.GetAll<CmsBlock>(true);
            return View(area);
        }

        [HttpPost]
        public ActionResult GetImages(AreaKind id) {
            var area = DbSession.Get<Area>(id);
            if (area == null) return HttpNotFound();
            return Json(new {large = area.LargeImages, small = area.SmallImages});
        }

        [HttpPost]
        [TransactionScope]
        [ValidateInput(false)]
        public ActionResult Save(AreaKind id, string f_h1, string f_body, string f_links, string f_title, string f_desc, string f_keywords) {
            var area = DbSession.Get<Area>(id);
            if (area == null) return HttpNotFound();
            area.HomepageH1 = (f_h1 ?? "").Trim();
            area.HomepageBody = (f_body ?? "").Trim();
            area.HomepageTitle = (f_title ?? "").Trim();
            area.HomepageDescription = (f_desc ?? "").Trim();
            area.HomepageKeywords = (f_keywords ?? "").Trim();

            if (!String.IsNullOrEmpty(f_links) && area.Links != null) {
                area.Links.Html = f_links.Trim();
                DbSession.SaveOrUpdate(area.Links);
            }

            DbSession.SaveOrUpdate(area);
            return Content("success");
        }

    }
}