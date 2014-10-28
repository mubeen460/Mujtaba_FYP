using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace StudentManagement1.Controllers
{
    public class DegreeController : Controller
    {
        private MobileAttendanceSystemDBContext db = new MobileAttendanceSystemDBContext();

        //
        // GET: /Degree/

        public ActionResult Index()
        {
            return View(db.Degrees.ToList());
        }

       
        //
        // GET: /Degree/Create

        public ActionResult Create()
        {
            ViewBag.Dept_Id = new SelectList(db.Departments, "Dept_Id", "Dept_Name");
            return View();
        }

        //
        // POST: /Degree/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Degree degree)
        {
            try
            {
            if (ModelState.IsValid)
            {
                db.Degrees.Add(degree);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Dept_Id = new SelectList(db.Departments, "Dept_Id", "Dept_Name",degree.Dept_Id);
            return View(degree);

            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // GET: /Degree/Edit/5

        public ActionResult Edit(string id = null)
        {
            try
            {
            Degree degree = db.Degrees.Find(id);
            if (degree == null)
            {
                return HttpNotFound();
            }
            ViewBag.Dept_Id = new SelectList(db.Departments, "Dept_Id", "Dept_Name", degree.Dept_Id);
            return View(degree);
         
            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // POST: /Degree/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Degree degree)
        {
            try
            {
            if (ModelState.IsValid)
            {
                db.Entry(degree).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Department_Id = new SelectList(db.Departments, "Dept_Id", "Dept_Name", degree.Dept_Id);
            return View(degree);
            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // GET: /Degree/Delete/5

        public ActionResult Delete(string id = null)
        {
            try
            {

                Degree degree = db.Degrees.Find(id);
            if (degree == null)
            {
                return HttpNotFound();
            }
            return View(degree);
            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // POST: /Degree/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            try
            {
            Degree degree = db.Degrees.Find(id);
            db.Degrees.Remove(degree);
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