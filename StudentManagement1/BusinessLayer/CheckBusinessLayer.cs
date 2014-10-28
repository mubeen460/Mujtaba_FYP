using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
namespace BusinessLayer
{
   public class CheckBusinessLayer
    {
       public IEnumerable<Check> check
       {
           get
           {
               string ConnectionString = ConfigurationManager.ConnectionStrings["CheckDatabase"].ConnectionString;
               List<Check> checks = new List<Check>();

               using (SqlConnection con = new SqlConnection(ConnectionString))
               {
                   SqlCommand cmd = new SqlCommand("Select * from check_Table",con);
                   cmd.CommandType = CommandType.Text;
                   con.Open();
                   SqlDataReader reader = cmd.ExecuteReader();
                   while (reader.Read())
                   {
                       Check check = new Check();
                       check.check_table = Convert.ToInt32(reader["check_table"]);
                       checks.Add(check);
                   }
               }

               return checks;
           }
       }
       

  
    }
}
