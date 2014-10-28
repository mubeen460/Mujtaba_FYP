using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace StudentManagement1.Controllers
{
    public class TeacherController : Controller
    {
        private MobileAttendanceSystemDBContext db = new MobileAttendanceSystemDBContext();
        List<Course> availableCourses = new List<Course>();
        List<Student> availableStudents = new List<Student>();
        //
        // GET: /Teacher/

        public ActionResult Index(string searchBy, string search)
        {

            if (searchBy == "Teacher_Id")
            {
                return View(db.Teachers.Where(x => x.Teacher_Id.StartsWith(search) || search == null).ToList());
            }
            else if (searchBy == "Name")
            {
                return View(db.Teachers.Where(x => x.Name.StartsWith(search) || search == null).ToList());
            }

            else
            {
                return View(db.Teachers.Where(x => x.Department.Dept_Name.StartsWith(search) || search == null).ToList());
            }
        }
       
        //
        // GET: /Teacher/Create

        public ActionResult Create()
        {
            try
            {

                ViewBag.Dept_Id = new SelectList(db.Departments, "Dept_Id", " Dept_Name");
                return View();

            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // POST: /Teacher/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Teacher teacher)
        {
            try
            {

                if (ModelState.IsValid)
                {
                         //to add crypto passward and other data in teacher table
            var crypto = new SimpleCrypto.PBKDF2();
            var encryPassword = crypto.Compute(teacher.Password);
            teacher.Password = encryPassword;
            teacher.Password_Salt = crypto.Salt;
            
            db.Teachers.Add(teacher);
            db.SaveChanges();


            // to add in TeacherCredithours table

            MobileAttendanceSystemDBContext db2 = new MobileAttendanceSystemDBContext();

            var addCreditHours = db2.TeacherCreditHours.Create();
            addCreditHours.Teacher_Id = teacher.Teacher_Id;
            addCreditHours.CreditHours = 0;
            db2.TeacherCreditHours.Add(addCreditHours);
            db2.SaveChanges();

            return RedirectToAction("Index");
            }

            ViewBag.Dept_Id = new SelectList(db.Departments, "Dept_Id", "Dept_Name", teacher.Dept_Id);
             return View(teacher);
            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // GET: /Teacher/Edit/5

        public ActionResult Edit(string id = null)
        {
            Teacher teacher = db.Teachers.Find(id);
            if (teacher == null)
            {
                return HttpNotFound();
            }
            ViewBag.Dept_Id = new SelectList(db.Departments, "Dept_Id", "Dept_Name", teacher.Dept_Id);
            return View(teacher);
        }

        //
        // POST: /Teacher/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Teacher teacher)
        {
            try
            {
            if (ModelState.IsValid)
            {
                db.Entry(teacher).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Dept_Id = new SelectList(db.Departments, "Dept_Id", "Dept_Name", teacher.Dept_Id);
            return View(teacher);
            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // GET: /Teacher/Delete/5

        public ActionResult Delete(string id = null)
        {
            Teacher teacher = db.Teachers.Find(id);
            if (teacher == null)
            {
                return HttpNotFound();
            }
            return View(teacher);
        }

        //
        // POST: /Teacher/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            try
            {
                //to remove teacher related data from teachercredithours table
                TeacherCreditHours teacherCreditHours = db.TeacherCreditHours.Where(x => x.Teacher_Id == id).SingleOrDefault();
                if(teacherCreditHours.CreditHours == 0)
                {
                db.TeacherCreditHours.Remove(teacherCreditHours);
                db.SaveChanges();
                }
                //to remove teacher related data from teacher table
              
                Teacher teacher = db.Teachers.Find(id);
                db.Teachers.Remove(teacher);
                db.SaveChanges();

            return RedirectToAction("Index");
            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // Get :/Teacher/AllocatedCourses/5

        public ActionResult AllocatedCourses(string id = null)
        {

            // to pass credit hours from TeacherCreditHours class to view

            TeacherCreditHours teacherCreditHours = db.TeacherCreditHours.Where(x => x.Teacher_Id == id).SingleOrDefault();
            if(teacherCreditHours != null)
            {
                ViewData["teacherCreditHours"] = "Total Credit Hours : " + teacherCreditHours.CreditHours + "";
            }
            else
            {
                ViewData["teacherCreditHours"] = "Total Credit Hours : 0";
            }
            //to get allocated courses of current teacher
            ViewData["teacherid"] = id;
            return View(db.TeacherCourses.Where(x => x.Teacher_Id == id).ToList());
        }


        //
        // POST: /Teacher/RemoveCourse/5
        [HttpPost]
        public ActionResult AllocatedCourses(IEnumerable<string> courseIdsToRemove, string teacherid)
        {
            if (courseIdsToRemove != null)
            {
                //to remove credit hours
                TeacherCreditHours teacherCreditHours = db.TeacherCreditHours.Where(x => x.Teacher_Id == teacherid).SingleOrDefault();
                int totalCreditHours = teacherCreditHours.CreditHours;

                foreach (var item in courseIdsToRemove)
                {
                    
                    TeacherCourse teacherCourses = db.TeacherCourses.Where(x => x.Teacher_Id == teacherid && x.Course_Id == item).SingleOrDefault();
                    //remove sessions
                    List<Session> sessions = db.Sessions.Where(x => x.Course_Id == item && x.Teacher_Id == teacherid).ToList();
                    foreach (var session in sessions)
                    {
                        List<Attendance> attendances = db.Attendances.Where(x => x.Session_Id == session.Session_Id).ToList();
                        foreach (var attendance in attendances)
                        {
                            db.Attendances.Remove(attendance);
                            db.SaveChanges();
                        }

                        db.Sessions.Remove(session);
                        db.SaveChanges();

                    }
                     List<TeacherCourseStudent> studentToRemove = db.TeacherCourseStudents.Where(x => x.TeacherCourse_Id == teacherCourses.TeacherCourse_Id).ToList();
                    
                    // to remove students related to courses
                     if (studentToRemove != null)
                     {
                         foreach (var item2 in studentToRemove)
                         {        
                             db.TeacherCourseStudents.Remove(item2);
                             db.SaveChanges();
                         }
                     }
              
                    db.TeacherCourses.Remove(teacherCourses);
                    db.SaveChanges();

                    //to minus Credit hourse from teacherCreditHours table
                    Course course = db.Courses.Where(x => x.Course_Id == item).SingleOrDefault();
                    totalCreditHours = totalCreditHours - course.Credit_Hours;
                }

                //update credit hours in teacherCreditHours table
                var updateCreditHours = db.TeacherCreditHours.FirstOrDefault(ad => ad.Teacher_Id == teacherid);
                updateCreditHours.CreditHours = totalCreditHours;
                db.SaveChanges();
                return RedirectToAction("AllocatedCourses", "Teacher", new { id = teacherid });
            }

            else
            {
                ViewData["error"] = "First select courses";
                ModelState.AddModelError("", "");
            }
            return View(db.TeacherCourses.Where(x => x.Teacher_Id == teacherid).ToList());
        }



        //
        // Get: /Teacher/AddCourses/5

        public ActionResult AddCourses(string id, string searchBy, string search)
        {
            List<TeacherCourse> selectedCourses = db.TeacherCourses.Where(x => x.Teacher_Id == id).ToList();

            //get teacher's department total courses
            var teacher = db.Teachers.Where(x => x.Teacher_Id == id).SingleOrDefault();
            var department = teacher.Dept_Id;
            List<Course> totalCourses = db.Courses.Where(x => x.Degree.Dept_Id == department).ToList();

            //List<Course> totalCourses = db.Courses.ToList();
            

            ViewData["teacherid"] = id;

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
        // Post: /Teacher/AddCourses/5

        [HttpPost]
        public ActionResult AddCourses(string teacherid, IEnumerable<string> courseIdsToAdd)
        {
             
             int validCreditHours = 0;
             int validity = 0;
            
                   
            //to check teacher designation and valide credit hours

            var teacher = db.Teachers.Where(x => x.Teacher_Id == teacherid).Single();
            if (teacher.Designation == "Lecturer")
                 { 
                        validCreditHours = 12; 
                 }
            else if(teacher.Designation == "Assistance Professor")
                {
                         validCreditHours = 9;
                }

            else if(teacher.Designation == "Associate Professor")
                {
                         validCreditHours = 6;
                }

             else if(teacher.Designation == "Professor")
                {
                         validCreditHours = 3;
                }
         //to get credithours that teacher teaches

            var teachercredithours = db.TeacherCreditHours.Where(x => x.Teacher_Id == teacherid).SingleOrDefault();
        
        
            //to check that credit hours should not increase than valid credit hours

            int totalCreditHours = 0;
            if (teachercredithours != null)
            {
                totalCreditHours = teachercredithours.CreditHours;   
            }

            if (courseIdsToAdd != null)
            {

                foreach (var item in courseIdsToAdd)
                {
                    var courses = db.Courses.Where(x => x.Course_Id == item).Single();
                    totalCreditHours = totalCreditHours + courses.Credit_Hours;
                }
                
            
                if (totalCreditHours <= validCreditHours)
                {

                    //to add courses in teachercourse table
                    var teachercourse = db.TeacherCourses.Create();
                    foreach (var item in courseIdsToAdd)
                    {
                        teachercourse.Course_Id = item;
                        teachercourse.Teacher_Id = teacherid;
                        db.TeacherCourses.Add(teachercourse);
                        db.SaveChanges();
                    }

                    //update credit hours in teacherCreditHours table
                    var updateCreditHours = db.TeacherCreditHours.FirstOrDefault(ad => ad.Teacher_Id == teacherid);
                    if (updateCreditHours != null)
                    {
                        updateCreditHours.CreditHours = totalCreditHours;
                        db.SaveChanges();
                    }
                    else
                    {
                        var credithours = db.TeacherCreditHours.Create();
                        credithours.Teacher_Id = teacherid;
                        credithours.CreditHours = totalCreditHours;
                        db.TeacherCreditHours.Add(credithours);
                        db.SaveChanges();
                    }

                    return RedirectToAction("AllocatedCourses", "Teacher", new { id = teacherid });
                }

                else
                {
                    //to determin number of credit hours that can assigned
                    int allcredithours = 0;
                    if (teachercredithours != null)
                    {
                       allcredithours = teachercredithours.CreditHours;
                    }
                    int creditToAssign = validCreditHours - allcredithours;
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
        // Get: /Teacher/AddStudents/5
        [HttpGet]
        public ActionResult AddStudents(int id , string courseid, string searchBy, string search)
        {
            ViewData["teachercourseid"] = id;

            List<TeacherCourseStudent> selectedStudents = db.TeacherCourseStudents.Where(x => x.TeacherCourse_Id == id ).ToList();

            List<StudentCourse> totalStudents = db.StudentCourses.Where(x => x.Course_Id == courseid).ToList();
            List<Student> availableStudents = new List<Student>();

            foreach (var TS in totalStudents)
            {

                int check = 0;

                foreach (var SS in selectedStudents)
                {
                    if (TS.Student_Id == SS.Student_Id)
                    {
                        check = 1;
                        break;
                    }
                }

                if (check == 0)
                {
                    availableStudents.Add(db.Students.Where(x => x.Student_Id == TS.Student_Id).Single());
                }

            }

            if (search != null)
            {

                if (searchBy == "Student_Id")
                {
                    return View(availableStudents.Where(x => x.Student_Id.StartsWith(search) || search == null).ToList());
                }
                else if (searchBy == "Name")
                {
                    return View(availableStudents.Where(x => x.Name.StartsWith(search) || search == null).ToList());
                }

                else
                {
                    return View(availableStudents.Where(x => x.Semester.Semester_Name.StartsWith(search) || search == null));
                }
            }

            else
            {
                return View(availableStudents);
            }
        }


         //
        // Post: /Teacher/AddStudents/5


        [HttpPost]
        public ActionResult AddStudents(int teachercourseid, IEnumerable<string> StudentIdsToAdd )
        {

            //to determin techer id for RedirectToAction link

           TeacherCourse selectedStudents = db.TeacherCourses.Where(x => x.TeacherCourse_Id == teachercourseid).Single();




            //to insert data in TeacherCourseStudent table

            var TeacherCourseStudent = db.TeacherCourseStudents.Create();

            if (StudentIdsToAdd != null)
            {

                foreach (var item in StudentIdsToAdd)
                {
                    TeacherCourseStudent.Student_Id = item;
                    TeacherCourseStudent.TeacherCourse_Id = teachercourseid;
                    db.TeacherCourseStudents.Add(TeacherCourseStudent);
                    db.SaveChanges();
                }

                return RedirectToAction("AllocatedCourses", "Teacher", new { id = selectedStudents.Teacher_Id });
            }

            else
            {
                ViewData["error"] = "First select courses";
                ModelState.AddModelError("", "");
            }

            return View(availableStudents);     
        }



        //
        // Get: /Teacher/RemoveStudents/5

        public ActionResult RemoveStudents(int id, string searchBy, string search )
        {
            ViewData["teachercourseid"] = id;

            List<TeacherCourseStudent> selectedstudents = db.TeacherCourseStudents.Where(x => x.TeacherCourse_Id == id).ToList();
            if (search != null)
            {

                if (searchBy == "Student_Id")
                {
                    return View(selectedstudents.Where(x => x.Student_Id.StartsWith(search) || search == null).ToList());
                }
                else if (searchBy == "Name")
                {
                    return View(selectedstudents.Where(x => x.Student.Name.StartsWith(search) || search == null).ToList());
                }

                else
                {
                    return View(selectedstudents.Where(x => x.Student.Semester.Semester_Name.StartsWith(search) || search == null).ToList());
                }
            }

            else
            {
                return View(selectedstudents);
            }
        }



        //
        // Post: /Teacher/RemoveStudents/5
        [HttpPost]
        public ActionResult RemoveStudents(int teachercourseid, IEnumerable<string> StudentsIdsToRemove)
        {
            List<TeacherCourseStudent> selectedstudents = db.TeacherCourseStudents.Where(x => x.TeacherCourse_Id == teachercourseid).ToList();

            if (StudentsIdsToRemove != null)
            {

                foreach (var item in StudentsIdsToRemove)
                {
                    TeacherCourseStudent studentToRemove = db.TeacherCourseStudents.Where(x => x.Student_Id == item && x.TeacherCourse_Id == teachercourseid).SingleOrDefault();
                    db.TeacherCourseStudents.Remove(studentToRemove);
                    db.SaveChanges();
                }
            }

            else
            {
                ViewData["error"] = "First select courses";
                ModelState.AddModelError("", "");
            }

            //TeacherCourseStudent students = db.TeacherCourseStudents.Where(x => x.TeacherCourse_Id == teachercourseid).SingleOrDefault();
            return View(db.TeacherCourseStudents.Where(x => x.TeacherCourse_Id == teachercourseid).ToList()); 
        }

        //
        // password Cryption function
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


        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }

        public string Teacher_Id { get; set; }
    }
}