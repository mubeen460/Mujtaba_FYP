using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StudentManagement1.Models
{
    public class PercentageModel
    {
        //this Model is created to get student percentage
        public string Student_Id { get; set; }
        public string Name { get; set; }
        public string Sur_Name { get; set; }
        public string Semester_Name { get; set; }
        public string Percentage { get; set; }
    }
}