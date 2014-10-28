using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace StudentManagement1.Controllers
{
    public class StudentController : Controller
    {
        private MobileAttendanceSystemDBContext db = new MobileAttendanceSystemDBContext();

        //
        // GET: /Student/

        public ActionResult Index(string searchBy, string search)
        {
            if (searchBy == "Student_Id")
            {
                return View(db.Students.Where(x => x.Student_Id.StartsWith(search) || search == null).ToList());
            }
            else if (searchBy == "Name")
            {
                return View(db.Students.Where(x => x.Name.StartsWith(search) || search == null).ToList());
            }

            else
            {
                return View(db.Students.Where(x => x.Semester.Semester_Name.StartsWith(search) || search == null));
            }
        }

        //
        // GET: /Student/Details/5

        public ActionResult Details(string id = null)
        {
            Student student = db.Students.Find(id);
            if (student == null)
            {
                return HttpNotFound();
            }
            return View(student);
        }

        //
        // GET: /Student/Create

        public ActionResult Create()
        {
            ViewBag.Semester_Id = new SelectList(db.Semesters, "Semester_Id", "Semester_Name");
            ViewBag.Degree_Id = new SelectList(db.Degrees, "Degree_Id", "Degree_Name");
            return View();
        }

        //
        // POST: /Student/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Student student)
        {
            try
            {


                if (ModelState.IsValid)
                {
                    var crypto = new SimpleCrypto.PBKDF2();
                    var encryPassword = crypto.Compute("1122");
                    student.Password = encryPassword;
                    student.Password_Salt = crypto.Salt;
                    db.Students.Add(student);
                    db.SaveChanges();

                    // to add in StudentCredithours table

                    var addCreditHours = db.StudentCreditHours.Create();
                    addCreditHours.Student_Id = student.Student_Id;
                    addCreditHours.CreditHours = 0;
                    db.StudentCreditHours.Add(addCreditHours);
                    db.SaveChanges();

                    return RedirectToAction("Index");
                }

                ViewBag.Semester_Id = new SelectList(db.Semesters, "Semester_Id", "Semester_Name", student.Semester_Id);
                ViewBag.Degree_Id = new SelectList(db.Degrees, "Degree_Id", "Degree_Name", student.Degree_Id);
                return View(student);
            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // GET: /Student/Edit/5

        public ActionResult Edit(string id = null)
        {

            Student student = db.Students.Find(id);
            if (student == null)
            {
                return HttpNotFound();
            }
            ViewBag.Semester_Id = new SelectList(db.Semesters, "Semester_Id", "Semester_Name", student.Semester_Id);
            ViewBag.Degree_Id = new SelectList(db.Degrees, "Degree_Id", "Degree_Name", student.Degree_Id);
            return View(student);
        }

        //
        // POST: /Student/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Student student)
        {
            try
            {

            if (ModelState.IsValid)
            {
                db.Entry(student).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Semester_Id = new SelectList(db.Semesters, "Semester_Id", "Semester_Name", student.Semester_Id);
            ViewBag.Degree_Id = new SelectList(db.Degrees, "Degree_Id", "Degree_Name", student.Degree_Id);
            ModelState.AddModelError("", "");
            return View(student);

            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // GET: /Student/Delete/5

        public ActionResult Delete(string id = null)
        {
            try
            {

            Student student = db.Students.Find(id);
            if (student == null)
            {
                return HttpNotFound();
            }
            return View(student);
            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // POST: /Student/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            try
            {
                //to remove Student related data from studentcredithours table
              
                StudentCreditHours studentCreditHours = db.StudentCreditHours.Where(x => x.Student_Id == id).SingleOrDefault();
                if (studentCreditHours.CreditHours == 0)
                {
                    db.StudentCreditHours.Remove(studentCreditHours);
                    db.SaveChanges();   
                }

                //to remove student related data from student table
              

                Student student = db.Students.Find(id);
                db.Students.Remove(student);
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