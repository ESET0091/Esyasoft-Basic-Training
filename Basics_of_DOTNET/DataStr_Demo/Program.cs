using System.Collections.Generic;
namespace DataStr_Demo
{
    internal class Program
    {
        static void Main(string[] args)
        {

            //List Example
            List<Student> students = new List<Student>();

            // Add Student objects to the list
            Student first = new Student(1, "Alice", 10);
            Student second = new Student(2, "Bob", 90);
            Student third = new Student(3, "Charlie", 78);
            students.Add(first);
            students.Add(second);
            students.Add(third);

            // Access and display each student using foreach
            Console.WriteLine("Student List:");
            foreach (Student s in students)
            {
                Console.WriteLine($"ID: {s.id}, Name: {s.name}, Marks: {s.marks}");
            }

            // Access a specific object by index
            Console.WriteLine($"\nSecond student is: {students[1].name}");

            //Dictionay Example
            Dictionary<string, Student> students_dict = new Dictionary<string, Student>();
            students_dict.Add("firstStudent", first);
            students_dict.Add("seondStudent", second);
            students_dict.Add("thirdStudent", third);

            foreach (KeyValuePair<string, Student> student in students_dict)
            {
                Console.WriteLine(student.Value.id);
            }

            //Hashset Example
            Console.WriteLine("Hashset demo");
            HashSet<Student> students_hashset = new HashSet<Student>();
            students_hashset.Add(first);
            students_hashset.Add(second);
            students_hashset.Add(first);
            students_hashset.Add(third);

            foreach (Student student in students_hashset)
            {
                Console.WriteLine(student.id);
            }

            //StackDemo
            Stack<Student> students_stack = new Stack<Student>();
            students_stack.Push(first);
            students_stack.Push(second);
            students_stack.Push(third);

            Student pop_stack = students_stack.Pop();
            Console.WriteLine(pop_stack.name);

            //Queue demo
            Console.WriteLine("Queue demo");
            Queue<Student> students_queue = new Queue<Student>();
            students_queue.Enqueue(first);
            students_queue.Enqueue(second);
            students_queue.Enqueue(third);

            Console.WriteLine(students_queue.Dequeue().name);


            // Linked list
            LinkedList<Student> std_link = new LinkedList<Student>();
            std_link.AddFirst(first);
            std_link.AddLast(second);
            std_link.AddLast(third);
            std_link.Remove(first);

            foreach (Student i in std_link)
            {
                Console.WriteLine($"Id: {i.id}, Name: {i.name}, Marks: {i.marks}");

            }

            // Touple 

            var tuple = Tuple.Create(first, second);
            Console.WriteLine(tuple.Item1.id);
            Console.WriteLine(tuple.Item2.id);
            
            Console.WriteLine(tuple.Item1.name);
            Console.WriteLine(tuple.Item2.name);

            // List of dictionary
            List<Dictionary<string, Student>> list_dict = new List<Dictionary<string, Student>>();
            list_dict.Add(students_dict);
            Console.WriteLine(list_dict.Count);


        }

    }
}
