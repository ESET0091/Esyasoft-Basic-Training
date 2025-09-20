namespace Assignment1
{
    internal class Program
    {
        static void Main(string[] args)
        {

            Console.Write("Total no of subjects : ");
            int no_of_subjects, sum = 0, avg_percent, highest = -1, lowest = 10000;


            no_of_subjects = Convert.ToInt32(Console.ReadLine());

            int[] marks_of_sub = new int[no_of_subjects];

            for (int i = 0; i < no_of_subjects; ++i)
            {
                Console.Write($"Marks of subject {i + 1}: ");
                marks_of_sub[i] = Convert.ToInt32(Console.ReadLine());
                if (marks_of_sub[i] > highest) highest = marks_of_sub[i];
                if (marks_of_sub[i] < lowest) lowest = marks_of_sub[i];
                sum += marks_of_sub[i];
            }

            //avg = sum / no_of_subjects;
            int total_marks = no_of_subjects * 100;

            avg_percent = (sum * 100) / (total_marks);

            Console.WriteLine($"Sum of the total marks obtained by the Student : {sum}");
            Console.WriteLine($"Avg marks obtained by the Student : {avg_percent}");
            Console.WriteLine($"Highest marks obtained by the Student : {highest}");
            Console.WriteLine($"Lowest marks obtained by the Student : {lowest}");

        }

    }
}