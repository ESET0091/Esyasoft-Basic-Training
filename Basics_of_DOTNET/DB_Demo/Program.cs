using System;
using System.Data.SqlClient;
namespace DB_Demo
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");
            Console.WriteLine("Getting Connection ...");

            var datasource = @"LAPTOP-M86ENGOL"; // your server
            var database = "b2_dotnet"; // your database name
            //var username = "DESKTOP-LCNNVH9\\kk"; // username of server to connect
            //var password = ""; // password

            // Create your connection string
            string connString = @"Data Source=" + datasource +
                ";Initial Catalog=" + database + "; Trusted_Connection=True;";


            Console.WriteLine(connString);

            SqlConnection conn = new SqlConnection(connString);

            try
            {
                Console.WriteLine("Opening Connection ...");
                // Open the connection
                conn.Open();
                Console.WriteLine("Connection successful!");
                //InsertStaff(conn);
                displayStaff(conn);

            }
            catch (Exception e)
            {
                Console.WriteLine("Error: " + e.Message);
            }
            finally
            {
                // Close the connection
                conn.Close();
            }


        }
        static void InsertStaff(SqlConnection conn)
        {
            Console.Write("Enter the Staff Name...");

            int std_id = 1;
            string myname = "Sachin2";
            string contact_no = "7390873709";

            string querry = "insert into student (std_id, std_name, std_contactno) values(@ID, @Myname, @Phone_no)";
            SqlCommand cm = new SqlCommand(querry, conn);
            cm.Parameters.AddWithValue("@ID", std_id);
            cm.Parameters.AddWithValue("@Myname", myname);
            cm.Parameters.AddWithValue("@Phone_no", contact_no);


            int rows = cm.ExecuteNonQuery();
            if (rows > 0)
            {
                Console.WriteLine("Inseted record successfully");
            }
        }
        static void displayStaff(SqlConnection conn)
        {
            string query = "select * from student";
            SqlCommand cm = new SqlCommand(query, conn);
            SqlDataReader reader = cm.ExecuteReader();
            Console.WriteLine("Staff :");
            while (reader.Read())
            {
                {
                    Console.WriteLine($"ID :{reader["std_id"]}, Name :{reader["std_name"]}, Phone no :{reader["std_contactno"]}");

                }
            }
        }
    }
}
