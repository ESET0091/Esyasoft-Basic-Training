using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassDemo
{
    internal class Student
    {
        int student_id;
        string name;
        int age;
        string contact_no;
        string email_id;

       public void initialize()
        {
            student_id = 1;
            name = "Gopal";
            age = 22;
            contact_no = "7390873700";
            email_id = "Gopal@gmail.com";
        }
        public void showDisplay()
        {
            Console.WriteLine("Calling Student");
            Console.WriteLine("Student ID is: ",student_id);
            Console.WriteLine("Name of student is: ",name);
            Console.WriteLine("Age of student is: ",age);
            Console.WriteLine("Contact no of student is: ",contact_no);
            Console.WriteLine("Email of student is: ",email_id);
        }

        //Student(int std_id)
        //{

        //}

        public Student(int std_id, string name, int age, string con_no,  string email_id)
        {
            student_id = std_id;
            this.name = name;
            this.age = age;
            contact_no = con_no;
            this.email_id = email_id;
        }
        public void getTotalMarks()
        {

        }
        public void result()
        { 

        }


    }
}
