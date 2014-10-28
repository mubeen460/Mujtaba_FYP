using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace StudentManagement1.Controllers
{
    public class StuCouController : Controller
    {
        private MobileAttendanceSystemDBContext db = new MobileAttendanceSystemDBContext();
        List<Course> availableCourses = new List<Course>();

        //
        // GET: /StuCou/

        public ActionResult Index(string id = null)
        {

            //to check semester elligiblity
            //List<Course> courses = db.Courses.Create(); 

            //var student = db.Students.Where(x => x.Student_Id == id).SingleOrDefault();
            //int semesterid = student.Semester_Id;
            //string degreeid = student.Degree_Id;
            //List<Semester> semesters = db.Semesters.Where(x => x.Semester_Id == semesterid && x.Degree_Id == degreeid).ToList();
            //foreach (var item in semesters)
            //{
            //    if (item.Semester_Id != semesterid)
            //    {
                    
            //    }


            //    if (true)
            //    {

            //    }
            //}



            // to pass credit hours from studentCreditHours class to view

            StudentCreditHours studentCreditHours = db.StudentCreditHours.Where(x => x.Student_Id == id).SingleOrDefault();
            if (studentCreditHours != null)
            {
                ViewData["studentCreditHours"] = "Total Credit Hours : " + studentCreditHours.CreditHours + "";
            }
            else
            {
                ViewData["studentCreditHours"] = "Total Credit Hours : 0";
            }
            //to get enrolled courses of current student
            ViewData["stid"] = id;
            return View(db.StudentCourses.Where(x => x.Student_Id == id).ToList());
        }

        //
        // GET: /StuCou/Add

        [HttpGet]
        public ActionResult Add(string id, string searchBy, string search)
        {

            
            List<StudentCourse> selectedCourses = db.StudentCourses.Where(x => x.Student_Id == id).ToList();

            //List<Course> totalCourses = db.Courses.ToList();

            //
            var student = db.Students.Where(x => x.Student_Id == id).SingleOrDefault();
            int semesterid = student.Semester_Id;
            string degreeid = student.Degree_Id;
            List<Course> totalCourses = db.Courses.Where(x => x.Semester_Id == semesterid && x.Degree_Id == degreeid).ToList();
            

            ViewData["stid"] = id;

            foreach (var TC in totalCourses)
            {

                int check = 0;

                foreach (var SC in selectedCourses)
                {
                    if (TC.Course_Id == SC.Course_Id)
                    {
                        check = 1;
                        break;
                    }
                }

                if (check == 0)
                {
                    availableCourses.Add(db.Courses.Where(x => x.Course_Id == TC.Course_Id).Single());
                }

            }

            if (search != null)
            {

                if (searchBy == "Course_Id")
                {
                    return View(availableCourses.Where(x => x.Course_Id.StartsWith(search) || search == null).ToList());
                }
                else if (searchBy == "Name")
                {
                    return View(availableCourses.Where(x => x.Course_Name.StartsWith(search) || search == null).ToList());
                }

                else
                {
                    return View(availableCourses.Where(x => x.Degree.Degree_Name.StartsWith(search) || search == null).ToList());
                }
            }

            else
            {
                return View(availableCourses);
            }
        }

        //
        // POST: /StuCou/Add

        [HttpPost]
        public ActionResult Add(IEnumerable<string> courseIdsToAdd, string Student_Id)
        {
            // to set valid credit hours
            int validCreditHours = 18;

            //to get total enrolled credit hours of student
            var studentCreditHours = db.StudentCreditHours.Where(x => x.Student_Id == Student_Id).SingleOrDefault();
            int totalCreditHours = 0;
            if (studentCreditHours != null)
            {
                 totalCreditHours = studentCreditHours.CreditHours;   
            }
           

            var stucou = db.StudentCourses.Create();

            if (courseIdsToAdd != null)
            {

                foreach (var item in courseIdsToAdd)
                {
                    var courses = db.Courses.Where(x => x.Course_Id == item).Single();
                    totalCreditHours = totalCreditHours + courses.Credit_Hours;
                }

                if (totalCreditHours <= validCreditHours)
                {
                    //to add courses in studentcourse table
                    foreach (var item in courseIdsToAdd)
                    {
                        stucou.Course_Id = item;
                        stucou.Student_Id = Student_Id;
                        db.StudentCourses.Add(stucou);
                        db.SaveChanges();
                    }


                    //update credit hours in StudentCreditHours table
                    var updateCreditHours = db.StudentCreditHours.Where(ad => ad.Student_Id == Student_Id).SingleOrDefault();
                    if (updateCreditHours != null)
                    {
                        updateCreditHours.CreditHours = totalCreditHours;
                        db.SaveChanges();
                    }

                    else
                    {
                        var credithours = db.StudentCreditHours.Create();
                        credithours.Student_Id = Student_Id;
                        credithours.CreditHours = totalCreditHours;
                        db.StudentCreditHours.Add(credithours);
                        db.SaveChanges();
                    }
                    

                    return RedirectToAction("Index", "StuCou", new { id = Student_Id });
                }

                else
                {
                    //to determin number of credit hours that can assigned
                    int creditToAssign = validCreditHours - studentCreditHours.CreditHours;
                    ViewData["error"] = "Oops! can not assign more than " + validCreditHours + " credit hours.You can assign " + creditToAssign + " more credit hours";
                    ModelState.AddModelError("", "");
                }
            }

            else
            {
                ViewData["error"] = "First select courses";
                    
                ModelState.AddModelError("", "");
            }


            return View(availableCourses);        
        }


        //
        // POST: /StuCou/Remove

        [HttpPost]
        public ActionResult Index(IEnumerable<string> courseIdsToRemove, string Student_Id)
        {
            if (courseIdsToRemove != null)
            {
                int totalCreditHours = 0;
                StudentCreditHours studentCreditHours = db.StudentCreditHours.Where(x => x.Student_Id == Student_Id).SingleOrDefault();
                if (studentCreditHours != null )
                {
                    totalCreditHours = studentCreditHours.CreditHours;   
                }
                foreach (var item in courseIdsToRemove)
                {
                    StudentCourse stuCourses = db.StudentCourses.Where(x => x.Student_Id == Student_Id && x.Course_Id == item).SingleOrDefault();
                    db.StudentCourses.Remove(stuCourses);
                    db.SaveChanges();

                    //to minus Credit hourse from teacherCreditHours table
                    Course course = db.Courses.Where(x => x.Course_Id == item).SingleOrDefault();
                    totalCreditHours = totalCreditHours - course.Credit_Hours;
              
                }

                //update credit hours in teacherCreditHours table
                var updateCreditHours = db.StudentCreditHours.FirstOrDefault(ad => ad.Student_Id == Student_Id);
                updateCreditHours.CreditHours = totalCreditHours;
                db.SaveChanges();
                return RedirectToAction("Index", "StuCou", new { id = Student_Id });
            }

            else
            {
                ViewData["error"] = "First select courses";
                ModelState.AddModelError("", "");
            }

            return View(db.StudentCourses.Where(x => x.Student_Id == Student_Id).ToList()); 

    }


        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}