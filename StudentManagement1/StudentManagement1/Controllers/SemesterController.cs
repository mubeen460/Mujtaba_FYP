using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace StudentManagement1.Controllers
{
    public class SemesterController : Controller
    {
        private MobileAttendanceSystemDBContext db = new MobileAttendanceSystemDBContext();

        //
        // GET: /Semester/

        public ActionResult Index(string searchBy, string search)
        {
            if (searchBy == "Degree_Name")
            {
                return View(db.Semesters.Where(x => x.Degree.Degree_Name.StartsWith(search) || search == null).ToList());
            }
            else 
            {
                return View(db.Semesters.Where(x => x.Semester_Name.StartsWith(search) || search == null).ToList());
            }

        }

        ////
        //// GET: /Semester/Details/5

        //public ActionResult Details(int id = 0)
        //{
        //    try
        //    {
        //    Semester semester = db.Semesters.Find(id);
        //    if (semester == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(semester);
        //    }
        //    catch (Exception)
        //    {

        //        return View("Error");
        //    }
        //}

        //
        // GET: /Semester/Create

        public ActionResult Create()
        {
            try
            {

            ViewBag.Degree_Id = new SelectList(db.Degrees, "Degree_Id", "Degree_Name");
            return View();

            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // POST: /Semester/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Semester semester)
        {
            try
            {

            if (ModelState.IsValid)
            {
                db.Semesters.Add(semester);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Degree_Id = new SelectList(db.Degrees, "Degree_Id", "Degree_Name", semester.Degree_Id);
            return View(semester);
            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // GET: /Semester/Edit/5

        public ActionResult Edit(int id = 0)
        {
            try
            {
            Semester semester = db.Semesters.Find(id);
            if (semester == null)
            {
                return HttpNotFound();
            }
            ViewBag.Degree_Id = new SelectList(db.Degrees, "Degree_Id", "Degree_Name", semester.Degree_Id);
            return View(semester);
            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // POST: /Semester/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Semester semester)
        {
            try
            {

            if (ModelState.IsValid)
            {
                db.Entry(semester).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Degree_Id = new SelectList(db.Degrees, "Degree_Id", "Degree_Name", semester.Degree_Id);
            return View(semester);
            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // GET: /Semester/Delete/5

        public ActionResult Delete(int id = 0)
        {
            try
            {
            Semester semester = db.Semesters.Find(id);
            if (semester == null)
            {
                return HttpNotFound();
            }
            return View(semester);
            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // POST: /Semester/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            try
            {
            Semester semester = db.Semesters.Find(id);
            db.Semesters.Remove(semester);
            db.SaveChanges();
            return RedirectToAction("Index");
            }
            catch (Exception)
            {

                return View("Error");
            }
        }



        public ActionResult SemesterCourses(int id, string degreeid)
        {
            List<Course> semestercourses = db.Courses.Where(x => x.Semester_Id == id && x.Degree_Id == degreeid).ToList();

            return View(semestercourses);
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}