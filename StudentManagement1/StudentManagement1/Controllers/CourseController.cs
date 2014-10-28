using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace StudentManagement1.Controllers
{
    public class CourseController : Controller
    {
        private MobileAttendanceSystemDBContext db = new MobileAttendanceSystemDBContext();

        //
        // GET: /Course/


        public ActionResult Index(string searchBy, string search)
        {
            if (searchBy == "Course_Id")
            {
                return View(db.Courses.Where(x => x.Course_Id.StartsWith(search) || search == null).ToList());
            }
            else if (searchBy == "Name")
            {
                return View(db.Courses.Where(x => x.Course_Name.StartsWith(search) || search == null).ToList());
            }

            else
            {
                return View(db.Courses.Where(x => x.Degree.Degree_Name.StartsWith(search) || search == null).ToList());
            }
        }

        //
        // GET: /Course/Details/5

        //public ActionResult Details(string id = null)
        //{
        //    Course course = db.Courses.Find(id);
        //    if (course == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(course);
        //}

        //
        // GET: /Course/Create

        public ActionResult Create()
        {
            ViewBag.Degree_Id = new SelectList(db.Degrees, "Degree_Id", "Degree_Name");
            ViewBag.Semester_Id = new SelectList(db.Semesters, "Semester_Id", "Semester_Name");
            return View();
        }

        //
        // POST: /Course/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Course course)
        {
            try
            {

            if (ModelState.IsValid)
            {
                db.Courses.Add(course);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Degree_Id = new SelectList(db.Degrees, "Degree_Id", "Degree_Name", course.Degree_Id);
            ViewBag.Semester_Id = new SelectList(db.Semesters, "Semester_Id", "Semester_Name", course.Semester_Id);
            return View(course);

            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // GET: /Course/Edit/5

        public ActionResult Edit(string id = null)
        {
            try
            {

            Course course = db.Courses.Find(id);
            if (course == null)
            {
                return HttpNotFound();
            }
            ViewBag.Degree_Id = new SelectList(db.Degrees, "Degree_Id", "Degree_Name", course.Degree_Id);
            ViewBag.Semester_Id = new SelectList(db.Semesters, "Semester_Id", "Semester_Name", course.Semester_Id);
            return View(course);

            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // POST: /Course/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Course course)
        {
            //try
            //{

                if (ModelState.IsValid)
                {
                    db.Entry(course).State = EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                ViewBag.Degree_Id = new SelectList(db.Degrees, "Degree_Id", "Degree_Name", course.Degree_Id);
                ViewBag.Semester_Id = new SelectList(db.Semesters, "Semester_Id", "Semester_Name", course.Semester_Id);
                return View(course);
            
            //}
            //catch (Exception)
            //{

            //    return View("Error");
            //}
        }

        //
        // GET: /Course/Delete/5

        public ActionResult Delete(string id = null)
        {
            try
            {
             
            Course course = db.Courses.Find(id);
            if (course == null)
            {
                return HttpNotFound();
            }
            return View(course);

            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // POST: /Course/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            try
            {

                //to delete course from TeacherCourse table

                //to determin teachers list that assigned with this course
                List <TeacherCourse> teacherCourses = db.TeacherCourses.Where(x => x.Course_Id == id).ToList();
                if (teacherCourses != null)
                {
                    foreach (var item in teacherCourses)
                    {
                        //get total credit hours of teachers who teches that course from TeacherCreditHours table
                        TeacherCreditHours teacherCreditHours = db.TeacherCreditHours.Where(x => x.Teacher_Id == item.Teacher_Id).SingleOrDefault();
                        int totalCreditHours = teacherCreditHours.CreditHours;

                        //to determin students assigned to each teacher from TeacherCourseStudents table
                        List<TeacherCourseStudent> studentToRemove = db.TeacherCourseStudents.Where(x => x.TeacherCourse_Id == item.TeacherCourse_Id).ToList();

                        // to remove students related to courses
                        if (studentToRemove != null)
                        {
                            foreach (var item2 in studentToRemove)
                            {
                                db.TeacherCourseStudents.Remove(item2);
                                db.SaveChanges();
                            }
                        }


                        //to minus Credit hourse from teacherCreditHours table
                        Course course = db.Courses.Where(x => x.Course_Id == id).SingleOrDefault();
                        totalCreditHours = totalCreditHours - course.Credit_Hours;

                        //update credit hours in teacherCreditHours table
                        var updateCreditHours = db.TeacherCreditHours.FirstOrDefault(ad => ad.Teacher_Id == item.Teacher_Id);
                        updateCreditHours.CreditHours = totalCreditHours;
                        db.SaveChanges();

                        //remove course from teacher course table
                        db.TeacherCourses.Remove(item);
                        db.SaveChanges(); 
                        
                    }
                }
                
      
                List<StudentCourse> studentCourse = db.StudentCourses.Where(x => x.Course_Id == id).ToList();
                foreach (var item in studentCourse)
                {
                    //to minus course credit hours from studentCredit Hours Table from StudentCourse table
                     List<StudentCreditHours> studentCreditHours = db.StudentCreditHours.Where(x => x.Student_Id == item.Student_Id).ToList();
                     
                    foreach (var item2 in studentCreditHours)
                     {
                         //get total enrolled credit hours 
                         int totalCreditHours = item2.CreditHours;
                         //get course credit hours to minus 
                         Course course = db.Courses.Where(x => x.Course_Id == id).SingleOrDefault();
                        // minus course credit hours from toal credit hours
                         totalCreditHours = totalCreditHours - course.Credit_Hours;


                         //update credit hours in teacherCreditHours table
                         var updateCreditHours = db.StudentCreditHours.FirstOrDefault(ad => ad.Student_Id == item.Student_Id);
                         updateCreditHours.CreditHours = totalCreditHours;
                         db.SaveChanges();


                         //to delete course from StudentCourse table
                         db.StudentCourses.Remove(item);
                         db.SaveChanges();
                     }
                }
            
            //to delete course from course table
            Course cours = db.Courses.Find(id);
            db.Courses.Remove(cours);
            db.SaveChanges();
            return RedirectToAction("Index");
            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}