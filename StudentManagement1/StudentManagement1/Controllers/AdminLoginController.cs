using StudentManagement1.Filters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using WebMatrix.WebData;

namespace StudentManagement1.Controllers
{
   // [InitializeSimpleMembership]
    public class AdminLoginController : Controller  
    {
        private MobileAttendanceSystemDBContext db = new MobileAttendanceSystemDBContext();

    



        //************Login*************

        //for admin login form

        public ActionResult Index()
        {
            return View();
        }


        //for post request
        [HttpPost]
        public ActionResult Index(Admin admin)
        {
            if (ModelState.IsValid)
            {
                if (admin.Password != null && admin.User_Name != null)
                {
                
                if (IsValid(admin.User_Name, admin.Password))
                {
                    FormsAuthentication.SetAuthCookie(admin.User_Name, false);
                    return RedirectToAction("Index", "Teacher");
                   
                }

                else
                {
                    ModelState.AddModelError("", "");
                }

                }
                else
                {
                    ModelState.AddModelError("", "");
                }
            }
            return View(admin);
        }

       
        //******Logout******

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index","Home");
        }



        //********Registration**********

        public ActionResult Registration()
        {
            return View();
        }



        [HttpPost]
        public ActionResult Registration(Admin admin)
        {
            if (ModelState.IsValid)
            {
                using (var db = new MobileAttendanceSystemDBContext())
                {
                    var crypto = new SimpleCrypto.PBKDF2();
                    var encryPassword = crypto.Compute(admin.Password);
                    var sysuser = db.Admins.Create();

                    sysuser.User_Name = admin.User_Name;
                    sysuser.Password = encryPassword;
                    sysuser.Password_Salt = crypto.Salt;
                    
                     sysuser.User_Id = Guid.NewGuid();

                    db.Admins.Add(sysuser);
                    db.SaveChanges();

                    return RedirectToAction("Index", "Teacher");
                }
            }

            else
            {
                ModelState.AddModelError("","Login data is incorrect");
            }
            return View();
        }



        //********Change Password**********

        [HttpGet]
        public ActionResult ChangePassword()
        {
            string user = User.Identity.Name;
            try
            {
            Admin admin = db.Admins.Where(x => x.User_Name == user).Single();
            //Admin admin = (from p in db.Admins
            //                where p.User_Name == user
            //                select p).Single();
            if (admin == null)
            {
                return HttpNotFound();
            }
            return View(admin);
            //return user;
            }
            catch (Exception)
            {

                return RedirectToAction("Index", "AdminLogin");
            }
        }


        [HttpPost]
        public ActionResult ChangePassword(string Password, string New_Password, string Compare_Password)
        {

            string a = Password;
            string b = New_Password;
            //to check empty fields
            if (ModelState.IsValid && !(string.IsNullOrEmpty(Password)) && !string.IsNullOrEmpty(New_Password) && !string.IsNullOrEmpty(Compare_Password))
            {

                //to check new password length
              if (New_Password.Length >= 4 && New_Password.Length <= 50 )
                {


                  //to check equality of new and conform password
                if (string.Equals(New_Password, Compare_Password))
                {


                    //Check that provided password is match with old password

                    using (var db2 = new MobileAttendanceSystemDBContext())
                    {

                    string user = User.Identity.Name;

                    var admin = db2.Admins.FirstOrDefault(ad => ad.User_Name == user);
                    System.Guid userid = admin.User_Id;
                    string username = admin.User_Name;
                    string password = admin.Password;
                    string passwordsalt = admin.Password_Salt;
                     
                    if (IsValid(admin.User_Name, Password))
                    {

                        FormsAuthentication.SetAuthCookie(admin.User_Name, false);
                       var art = db2.Admins.FirstOrDefault(ad => ad.User_Name == user);
                        var crypto = new SimpleCrypto.PBKDF2();
                        var encryPassword = crypto.Compute(New_Password);
                        art.Password_Salt = crypto.Salt;
                        art.Password = encryPassword;
                        db2.SaveChanges();
                        return RedirectToAction("Index", "Teacher");
                    }
                    else
                    {
                        ModelState.AddModelError("Password", "Password is incorrect");
                    }


                    }

                    //var admin2 = db.Admins.FirstOrDefault(ad => ad.User_Name == "mujtaba");
                }

                else
                {
                    ModelState.AddModelError("Compare_Password", "New Password and Conform Password do not match");
                }

                }

                else
                {
                    ModelState.AddModelError("New_Password", "The field New Password must be a string with a minimum length of 4 and a maximum length of 50. ");
                }

            }

            else
            {
                ModelState.AddModelError("", "All fields are required");
            }
                return View();
            
        }

       
        private bool IsValid(string userName, string password)
        {
            var crypt = new SimpleCrypto.PBKDF2();

            bool isValid = false;
           
            using (db)
            {
                var admin = db.Admins.FirstOrDefault(ad => ad.User_Name == userName);
                if (admin != null)
                {
                    if (admin.Password == crypt.Compute(password, admin.Password_Salt))
                    {
                        isValid = true;
                    }
                }
            }

            return isValid;
        }


        //***********************************************************
      
    }
}