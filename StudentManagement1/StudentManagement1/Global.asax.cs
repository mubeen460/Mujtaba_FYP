using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.WebPages;
using WebMatrix.WebData;

namespace StudentManagement1
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
           //WebSecurity.InitializeDatabaseConnection("MobileAttendanceSystemDBContext", "Admin", "User_Id", "User_Name", true);
            //if (!WebSecurity.Initialized)
            //{
            //    WebSecurity.InitializeDatabaseConnection("MobileAttendanceSystemDBContext", "Admin", "User_Id", "User_Name", true);
            //}
            Database.SetInitializer<StudentManagement1.MobileAttendanceSystemDBContext>(null);
            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            AuthConfig.RegisterAuth();


            InitializeDisplayModeProviders();
            // Ensure ASP.NET Simple Membership is initialized only once per app start
           // LazyInitializer.EnsureInitialized(ref _initializer, ref _isInitialized, ref _initializerLock);
        }


        protected void InitializeBundles()
        {
            var phoneScripts = new ScriptBundle("~/bundles/MobileJS")
                                      .Include("~/Scripts/jquery.mobile-1.*",
                                      "~/Scripts/jquery-1.*");

            var phoneStyles = new StyleBundle("~/bundles/MobileCSS")
                                       .Include("~/Content/jquery.mobile-1.4.2.min.css",
                                       "~/Content/jquery.mobile.structure-1.4.2.min.css",
                                       "~/Content/jquery.mobile.theme-1.4.2.min.css");

            BundleTable.Bundles.IgnoreList.Clear();
            BundleTable.Bundles.Add(phoneScripts);
            BundleTable.Bundles.Add(phoneStyles);
        }


        protected void InitializeDisplayModeProviders()
        {
            var phone = new DefaultDisplayMode("Phone")
            {
                ContextCondition = ctx => ctx.GetOverriddenUserAgent() != null && ctx.GetOverriddenUserAgent().Contains("iPhone")
            };

            DisplayModeProvider.Instance.Modes.Insert(0, phone);
        }






        //private static SimpleMembershipInitializer _initializer;
        //private static object _initializerLock = new object();
        //private static bool _isInitialized;

        //private class SimpleMembershipInitializer
        //{
        //    public SimpleMembershipInitializer()
        //    {
        //        Database.SetInitializer<MobileAttendanceSystemDBContext>(null);

        //        try
        //        {
        //            using (var context = new MobileAttendanceSystemDBContext())
        //            {
        //                if (!context.Database.Exists())
        //                {
        //                    // Create the SimpleMembership database without Entity Framework migration schema
        //                    ((IObjectContextAdapter)context).ObjectContext.CreateDatabase();
        //                }
        //            }

        //            WebSecurity.InitializeDatabaseConnection("MobileAttendanceSystemDBContext", "Admin", "User_Id", "User_Name", autoCreateTables: false);
        //        }
        //        catch (Exception ex)
        //        {
        //            throw new InvalidOperationException("The ASP.NET Simple Membership database could not be initialized. For more information, please see http://go.microsoft.com/fwlink/?LinkId=256588", ex);
        //        }
        //    }
        //}
    }
}