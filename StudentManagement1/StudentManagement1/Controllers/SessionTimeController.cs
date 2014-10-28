using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace StudentManagement1.Controllers
{
    public class SessionTimeController : Controller
    {
        private MobileAttendanceSystemDBContext db = new MobileAttendanceSystemDBContext();

        //
        // GET: /SessionTime/

        public ActionResult Index()
        {
            return View(db.SessionTimes.ToList());
        }

        //
        // GET: /SessionTime/Details/5

        //public ActionResult Details(int id = 0)
        //{
        //    SessionTime sessiontime = db.SessionTimes.Find(id);
        //    if (sessiontime == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(sessiontime);
        //}

        //
        // GET: /SessionTime/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /SessionTime/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(SessionTime sessiontime)
        {
            if (ModelState.IsValid)
            {
                db.SessionTimes.Add(sessiontime);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(sessiontime);
        }

        //
        // GET: /SessionTime/Edit/5

        public ActionResult Edit(int id = 0)
        {
            SessionTime sessiontime = db.SessionTimes.Find(id);
            if (sessiontime == null)
            {
                return HttpNotFound();
            }
            return View(sessiontime);
        }

        //
        // POST: /SessionTime/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(SessionTime sessiontime)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sessiontime).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(sessiontime);
        }

        //
        // GET: /SessionTime/Delete/5

        public ActionResult Delete(int id = 0)
        {
            SessionTime sessiontime = db.SessionTimes.Find(id);
            if (sessiontime == null)
            {
                return HttpNotFound();
            }
            return View(sessiontime);
        }

        //
        // POST: /SessionTime/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            SessionTime sessiontime = db.SessionTimes.Find(id);
            db.SessionTimes.Remove(sessiontime);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}