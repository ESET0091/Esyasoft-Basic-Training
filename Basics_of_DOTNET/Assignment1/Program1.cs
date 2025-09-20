namespace Assignment1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.Write("Total no of subjects : ");
            int no_of_subjects, sum = 0, avg = 0, avg_percent;


            no_of_subjects = Convert.ToInt32(Console.ReadLine());

            int[] marks_of_sub = new int[no_of_subjects];

            for (int i = 0; i < no_of_subjects; ++i)
            {
                Console.Write($"Marks of subject {i + 1}: ");
                marks_of_sub[i] = Convert.ToInt32(Console.ReadLine());
                sum += marks_of_sub[i];
            }

            //avg = sum / no_of_subjects;
            int total_marks = no_of_subjects * 100;

            avg_percent = (sum * 100) / (total_marks);

            Console.WriteLine($"Avg marks obtained by the Student : {avg_percent}");

            if (avg_percent > 90)
            {
                Console.WriteLine("Grade A");
                Console.WriteLine("All subject passed.");
            }
            else if (avg_percent > 80)
            {
                Console.WriteLine("Grade B");
                Console.WriteLine("All subject passed.");
            }
            else if (avg_percent > 70)
            {
                Console.WriteLine("Grade C");
                Console.WriteLine("All subject passed.");
            }
            else if (avg_percent > 60)
            {
                Console.WriteLine("Grade D");
                Console.WriteLine("All subject passed.");
            }
            else if (avg_percent > 50)
            {
                Console.WriteLine("Grade E");
                Console.WriteLine("All subject passed.");
            }
            else
            {
                //Console.WriteLine("Grade A");
                Console.WriteLine("All subject failed.");
            }


        }

    }
}