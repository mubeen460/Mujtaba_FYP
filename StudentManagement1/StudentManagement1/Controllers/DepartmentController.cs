using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace StudentManagement1.Controllers
{
    public class DepartmentController : Controller
    {
        private MobileAttendanceSystemDBContext db = new MobileAttendanceSystemDBContext();

        //
        // GET: /Department/

        public ActionResult Index()
        {
            return View(db.Departments.ToList());
        }

        //
        // GET: /Department/Details/5

        //public ActionResult Details(string id = null)
        //{
        //    try
        //    {

        //    Department department = db.Departments.Find(id);
        //    if (department == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(department);

        //    }
        //    catch (Exception)
        //    {

        //        return View("Error");
        //    }
        //}

        //
        // GET: /Department/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Department/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Department department)
        {
            try
            {

            if (ModelState.IsValid)
            {
                db.Departments.Add(department);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(department);

            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // GET: /Department/Edit/5

        public ActionResult Edit(string id = null)
        {
            try
            {

            Department department = db.Departments.Find(id);
            if (department == null)
            {
                return HttpNotFound();
            }
            return View(department);

            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // POST: /Department/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Department department)
        {
            if (ModelState.IsValid)
            {
                try
                {

               
                db.Entry(department).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
                }
                catch (Exception)
                {

                    ModelState.AddModelError("Dept_Id", "Department Id can not be changed");
                }
            }
            return View(department);
        }

        //
        // GET: /Department/Delete/5

        public ActionResult Delete(string id = null)
        {
            try
            {
            Department department = db.Departments.Find(id);
            if (department == null)
            {
                return HttpNotFound();
            }
            return View(department);

            }
            catch (Exception)
            {

                return View("Error");
            }
        }

        //
        // POST: /Department/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            try
            {

            
            Department department = db.Departments.Find(id);
            db.Departments.Remove(department);
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