using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using Balcony.Miracle.Core;

namespace Balcony.Miracle.Web.Cms {

    public class UploadedFile : BaseEntity<Guid> {

        public UploadedFile()
        {
            // ReSharper disable DoNotCallOverridableMethodsInConstructor
            Tags = new List<Tag>();
            // ReSharper restore DoNotCallOverridableMethodsInConstructor
        }

        public UploadedFile(HttpPostedFileBase file) : 
            this() {
            // ReSharper disable DoNotCallOverridableMethodsInConstructor

            var name = file.FileName.ToLower().Trim().Replace(" ", "-").Replace("_", "-");
            var path = "/content/uploads/" + Guid.NewGuid() + "/";

            var dir = HttpContext.Current.Server.MapPath(path);
            if (!Directory.Exists(dir))
                Directory.CreateDirectory(dir);

            Url = path + name;

            file.SaveAs(HttpContext.Current.Server.MapPath(Url));

            Name = Path.GetFileNameWithoutExtension(file.FileName);

            Extension = Path.GetExtension(file.FileName).ToLower().Substring(1);

            Size = file.ContentLength;

            Description = Name;

            // ReSharper restore DoNotCallOverridableMethodsInConstructor
        }

        public virtual string Name { get; set; }

        public virtual string Description { get; set; }

        public virtual IList<Tag> Tags { get; protected set; }

        public virtual string Url { get; set; }

        public virtual bool ShouldDelete { get; set; }

        public virtual string Extension { get; set; }

        public virtual int Size { get; set; }

        public virtual int Inx { get; set; }

        public virtual void Delete()
        {
            try
            {
                var file = HttpContext.Current.Server.MapPath(Url);
                var dir = Path.GetDirectoryName(file) ?? "";
                if (File.Exists(file))
                    File.Delete(file);

                if (!String.IsNullOrEmpty(dir))
                {
                    var info = new DirectoryInfo(dir);
                    if (info.GetFileSystemInfos().Length == 0)
                    {
                        info.Delete(true);
                    }
                }
            }
            catch { }
        }
    }

}