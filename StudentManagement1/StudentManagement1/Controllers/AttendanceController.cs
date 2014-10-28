using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using StudentManagement1.Models;
namespace StudentManagement1.Controllers
{
    public class AttendanceController : Controller
    {
        private MobileAttendanceSystemDBContext db = new MobileAttendanceSystemDBContext();

        //
        // GET: /Attendance/


        //************Login*************

        //for teacher login form

        public ActionResult Index()
        {
            return View();
        }


        //for post request
        [HttpPost]
        public ActionResult Index(Teacher teacher)
        {
           
                if (teacher.Password != null && teacher.Teacher_Id != null)
                {

                    if (IsValid(teacher.Teacher_Id, teacher.Password))
                    {
                        FormsAuthentication.SetAuthCookie(teacher.Teacher_Id, false);
                        //if (Request.Browser.IsMobileDevice){ }
                        //return RedirectToAction("Login", "Account", new { Area = "Mobile", ReturnUrl = returnUrl });
                        return RedirectToAction("Courses", "Attendance", new { id = teacher.Teacher_Id });

                    }

                    else
                    {
                        ModelState.AddModelError("", "");
                    }
                }
            
            return View(teacher);
        }



        //
        // Get :/Attendance/AllocatedCourses/

        public ActionResult Courses(string id = null)
        {

            // to pass credit hours from TeacherCreditHours class to view

            TeacherCreditHours teacherCreditHours = db.TeacherCreditHours.Where(x => x.Teacher_Id == id).SingleOrDefault();
            if (teacherCreditHours != null)
            {
                ViewData["teacherCreditHours"] = "Total Credit Hours : " + teacherCreditHours.CreditHours + "";
            }
            

            //to get allocated courses of current teacher
            ViewData["teacherid"] = id;
            return View(db.TeacherCourses.Where(x => x.Teacher_Id == id).ToList());
        }



        //
        // Get :/Attendance/MarkAttendance/
        public ActionResult MarkAttendance(string id , string teacherid)
        {
            //to pass session time
            ViewBag.SessionTime = db.SessionTimes.ToList();
            ViewData["CourseId"]= id;
            ViewData["TeacherId"] = teacherid;

            //to get allocated students to teacher
            TeacherCourse teacherCourse = db.TeacherCourses.Where(x => x.Course_Id == id && x.Teacher_Id == teacherid).SingleOrDefault();
            List<TeacherCourseStudent> teacherCourseStudent = db.TeacherCourseStudents.Where(x => x.TeacherCourse_Id == teacherCourse.TeacherCourse_Id).ToList();
            //string user = User.Identity.Name;



            return View(teacherCourseStudent);
        }


        //
        // Post :/Attendance/MarkAttendance/
        [HttpPost]
        public ActionResult MarkAttendance(IEnumerable<string> PresentStudents, string TeacherId, string CourseId, DateTime? Date = null, int? Time = 0)
        {
            bool holiday = false;
            
            if(Date != null && Time != 0)
            {
                // check current day
                //DayOfWeek today = DateTime.Today.DayOfWeek;
                DateTime today = (DateTime)Date;
                string day = today.ToString("dddd");
                if (day == DayOfWeek.Saturday.ToString() || day == DayOfWeek.Sunday.ToString())
                {
                    holiday = true;
                }



                // check duplication
                bool duplicate = false;
                List<Session> sessions = db.Sessions.Where(x => x.Course_Id == CourseId && x.Teacher_Id == TeacherId).ToList();
                foreach (var item in sessions)
                {
                    if (item.Date == Date && item.SessionTime_Id == Time)
                    {
                        duplicate = true;
                    }
                }

                if (duplicate != true && holiday != true)
                {
                    //to save session
                    Session session = db.Sessions.Create();
                    session.Course_Id = CourseId;
                    session.Teacher_Id = TeacherId;
                    session.SessionTime_Id = (int)Time;
                    session.Date = (DateTime)Date;
                    db.Sessions.Add(session);
                    db.SaveChanges();

                    //to get session id
                    Session sessionNow = db.Sessions.Where(x => x.Course_Id == CourseId && x.Teacher_Id == TeacherId && x.Date == Date && x.SessionTime_Id == Time).SingleOrDefault();
                    Attendance attendance = db.Attendances.Create();


                    TeacherCourse teacherCourse = db.TeacherCourses.Where(x => x.Course_Id == CourseId && x.Teacher_Id == User.Identity.Name).SingleOrDefault();
                    List<TeacherCourseStudent> teacherCourseStudent = db.TeacherCourseStudents.Where(x => x.TeacherCourse_Id == teacherCourse.TeacherCourse_Id).ToList();
                    foreach (var item in teacherCourseStudent)
                    {
                        bool status = false;

                        if (PresentStudents != null)
                        {
                            foreach (var item2 in PresentStudents)
                            {
                                if (item.Student_Id == item2)
                                {
                                    status = true;
                                    break;
                                }

                            }
                        }
                        attendance.Session_Id = sessionNow.Session_Id;
                        attendance.Student_Id = item.Student_Id;
                        attendance.Status = status;
                        db.Attendances.Add(attendance);
                        db.SaveChanges();

                    }

                    return RedirectToAction("Courses", "Attendance", new { id = TeacherId });
                }

                else
                {
                    if (duplicate == true)
                    {
                        ViewData["error"] = "Session already exist!";
                    }
                    if (holiday == true)
                    {
                        ViewData["error"] = "This is not a working day!";
                    }
                    
                    ModelState.AddModelError("", "");
                }
           
        }
           
                else
            {
                ViewData["error"] = "Date and Time fields are required!";
                ModelState.AddModelError("", "");
            }

            ViewBag.SessionTime = db.SessionTimes.ToList();
            ViewData["CourseId"] = CourseId;
            ViewData["TeacherId"] = TeacherId;

            //to get allocated students to teacher
            TeacherCourse teacherCourses = db.TeacherCourses.Where(x => x.Course_Id == CourseId && x.Teacher_Id == User.Identity.Name).SingleOrDefault();
            List<TeacherCourseStudent> teacherCourseStudents = db.TeacherCourseStudents.Where(x => x.TeacherCourse_Id == teacherCourses.TeacherCourse_Id).ToList();
            return View(teacherCourseStudents);

        }

        //
        // Get :/Attendance/ViewAttendance/
        public ActionResult ViewAttendance(string id , string teacherid)
        {
            //To get total sessions
            List<Session> sessions = db.Sessions.Where(x => x.Course_Id == id && x.Teacher_Id == teacherid).ToList();
            int totalSessions = sessions.Count;

            //to get allocated students to teacher
            TeacherCourse teacherCourse = db.TeacherCourses.Where(x => x.Course_Id == id && x.Teacher_Id == User.Identity.Name).SingleOrDefault();
            List<TeacherCourseStudent> teacherCourseStudent = db.TeacherCourseStudents.Where(x => x.TeacherCourse_Id == teacherCourse.TeacherCourse_Id).ToList();

            //to add student data and peercentage 
            List<PercentageModel> students = new List<PercentageModel>();
            PercentageModel obj = new PercentageModel();


            
            //get students from  attendnce table
            foreach (var item in teacherCourseStudent)
            {
                float percentage = 0;
                int totalPresents = 0;
                foreach (var item2 in sessions)
                {
                    //get presents of curent student
                    Attendance Presents = db.Attendances.Where(x => x.Session_Id == item2.Session_Id && x.Student_Id == item.Student_Id).SingleOrDefault();
                    if (Presents!= null)
                    {


                        if (Presents.Status == true)
                        {
                            totalPresents += 1;
                        }
                    }
                }

                float a = totalPresents * 100;
                percentage = a / totalSessions;

                // add current student in students list
                obj = new PercentageModel();
                obj.Student_Id = item.Student_Id;
                obj.Name = item.Student.Name;
                obj.Sur_Name = item.Student.Sur_Name;
                obj.Semester_Name = item.Student.Semester.Semester_Name;
                obj.Percentage = " " + percentage + " %";
                students.Add(obj);
            }

            return View(students);
        }


        //
        // Get :/Attendance/CourseSessions/
        public ActionResult CourseSessions(string id = null)
        {
            // to pass credit hours from TeacherCreditHours class to view

            TeacherCreditHours teacherCreditHours = db.TeacherCreditHours.Where(x => x.Teacher_Id == id).SingleOrDefault();
            if (teacherCreditHours != null)
            {
                ViewData["teacherCreditHours"] = "Total Credit Hours : " + teacherCreditHours.CreditHours + "";
            }

            //to get allocated courses of current teacher
            ViewData["teacherid"] = id;
            return View(db.TeacherCourses.Where(x => x.Teacher_Id == id).ToList());
        }


        //
        // Get :/Attendance/Sessions/
        public ActionResult Sessions(string id, string teacherid)
        {
            List<Session> session = db.Sessions.Where(x => x.Course_Id == id && x.Teacher_Id == teacherid).ToList();
            return View(session);
        }

        //
        // Get :/Attendance/EditSessions/
        public ActionResult EditSessions(int id)
        {
            List<Attendance> attendance = db.Attendances.Where(x => x.Session_Id == id).ToList();

            return View(attendance);
        }


        //******Logout******

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Attendance");
        }


        [HttpGet]
        public ActionResult ChangePassword()
        {
            string user = User.Identity.Name;
            try
            {
                Teacher teacher = db.Teachers.Where(x => x.Teacher_Id == user).Single();
                //Admin admin = (from p in db.Admins
                //                where p.User_Name == user
                //                select p).Single();
                if (teacher == null)
                {
                    return HttpNotFound();
                }
                return View(teacher);
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
                if (New_Password.Length >= 4 && New_Password.Length <= 50)
                {


                    //to check equality of new and conform password
                    if (string.Equals(New_Password, Compare_Password))
                    {


                        //Check that provided password is match with old password

                        using (var db2 = new MobileAttendanceSystemDBContext())
                        {

                            string user = User.Identity.Name;

                            var teacher = db2.Teachers.FirstOrDefault(ad => ad.Teacher_Id == user);
                            string userid =teacher.Teacher_Id;
                            string username = teacher.Teacher_Id;
                            string password = teacher.Password;
                            string passwordsalt = teacher.Password_Salt;

                            if (IsValid(teacher.Teacher_Id, Password))
                            {

                                FormsAuthentication.SetAuthCookie(teacher.Teacher_Id, false);
                                var art = db2.Teachers.FirstOrDefault(ad => ad.Teacher_Id == user);
                                var crypto = new SimpleCrypto.PBKDF2();
                                var encryPassword = crypto.Compute(New_Password);
                                art.Password_Salt = crypto.Salt;
                                art.Password = encryPassword;
                                db2.SaveChanges();
                                return RedirectToAction("Index", "Attendance");
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

        private bool IsValid(string teacherid, string password)
        {
            var crypt = new SimpleCrypto.PBKDF2();

            bool isValid = false;

            using (db)
            {
                var teacher = db.Teachers.FirstOrDefault(ad => ad.Teacher_Id == teacherid);
                if (teacher != null)
                {
                    if (teacher.Password == crypt.Compute(password, teacher.Password_Salt))
                    {
                        isValid = true;
                    }
                }
            }

            return isValid;
        }



        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}