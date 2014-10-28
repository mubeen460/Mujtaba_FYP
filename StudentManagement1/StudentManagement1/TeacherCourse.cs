//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace StudentManagement1
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    
    public partial class TeacherCourse
    {
        public TeacherCourse()
        {
            this.TeacherCourseStudent = new HashSet<TeacherCourseStudent>();
        }

        [Display(Name = "TeacherCousre Id")]
        public int TeacherCourse_Id { get; set; }

        [Required]
        [StringLength(50)]
        [Display(Name = "Teacher Id")]
        public string Teacher_Id { get; set; }

        [Required]
        [StringLength(50)]
        [Display(Name = "Course Id")]
        public string Course_Id { get; set; }
    
        public virtual Course Course { get; set; }
        public virtual Teacher Teacher { get; set; }
        public virtual ICollection<TeacherCourseStudent> TeacherCourseStudent { get; set; }
    }
}