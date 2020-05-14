using System.Web.Optimization;

namespace Balcony.Miracle.Web {

    public class BundleConfig {

        public static void RegisterBundles(BundleCollection bundles) {

            //BundleTable.EnableOptimizations = true;

            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/scripts/jquery-1.*"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryui").Include(
                        "~/scripts/jquery-ui*"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/scripts/jquery.unobtrusive*",
                        "~/scripts/jquery.validate*"));

            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/scripts/modernizr-*"));

            bundles.Add(new StyleBundle("~/content/css").Include("~/content/site.css"));

            bundles.Add(new StyleBundle("~/content/themes/base/css").Include(
                        "~/content/themes/base/jquery.ui.core.css",
                        "~/content/themes/base/jquery.ui.resizable.css",
                        "~/content/themes/base/jquery.ui.selectable.css",
                        "~/content/themes/base/jquery.ui.accordion.css",
                        "~/content/themes/base/jquery.ui.autocomplete.css",
                        "~/content/themes/base/jquery.ui.button.css",
                        "~/content/themes/base/jquery.ui.dialog.css",
                        "~/content/themes/base/jquery.ui.slider.css",
                        "~/content/themes/base/jquery.ui.tabs.css",
                        "~/content/themes/base/jquery.ui.datepicker.css",
                        "~/content/themes/base/jquery.ui.progressbar.css",
                        "~/content/themes/base/jquery.ui.theme.css"));
        }
    }
}