namespace Class_Assinment1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            string accountNumber ="";
            string accountHolderName = "";
            decimal balance = 0.0m;
            bool accountCreated = false;

            while (true)
            {
                Console.WriteLine("\n Console Banking Application ");
                Console.WriteLine("1. Create a new bank account");
                Console.WriteLine("2. Deposit money");
                Console.WriteLine("3. Withdraw money");
                Console.WriteLine("4. Display account details");
                Console.WriteLine("5. Exit");
                Console.Write("Enter your choice: ");

                //string choiceInput = Console.ReadLine();
                int choice = Convert.ToInt32(Console.ReadLine());

                switch (choice)
                {
                    case 1:
                        // Create Account
                        if (accountCreated)
                        {
                            Console.WriteLine("An account already exists. You cannot create another one.");
                        }
                        else
                        {
                            
                            Console.Write("Enter Account Number: ");
                            accountNumber = Console.ReadLine();
                            Console.Write("Enter Account Holder Name: ");
                            accountHolderName = Console.ReadLine();
                            balance = 0.0m; // Initialize balance to zero
                            accountCreated = true;
                            Console.WriteLine("Account created successfully!");
                        }
                        break;

                    case 2:
                        // Deposite ammount
                        if (!accountCreated)
                        {
                            Console.WriteLine("Please create an account first.");
                        }
                        else
                        {
                            Console.Write("Enter amount to deposit: ");                            
                            decimal depositAmt = Convert.ToInt32(Console.ReadLine());          
                            if (depositAmt > 0)
                            {
                                balance += depositAmt;
                                Console.WriteLine($"Successfully deposited {depositAmt}. New balance: {balance}");

                            }
                            else
                            {
                                Console.WriteLine("Invalid deposit amount. Please enter a positive number.");
                            }
                            
                        }
                        break;

                    case 3:
                        {
                            // Withdraw Ammount
                            if (!accountCreated)
                            {
                                Console.WriteLine("Please create an account first.");
                            }
                            else
                            {
                                Console.Write("Enter amount to withdraw: ");
                                decimal withdrawAmount = Convert.ToInt32(Console.ReadLine());
                                if (withdrawAmount > 0 && withdrawAmount<=balance)
                                {
                                    balance -= withdrawAmount;
                                    Console.WriteLine($"Successfully withdrawl {withdrawAmount}. New balance: {balance}");

                                }
                                else
                                {
                                    Console.WriteLine("Invalid withdrawl amount. Please enter a valid number.");
                                }

                            }
                            break;
                        }
                    case 4:
                        {
                            // Display Account details
                            if (!accountCreated)
                            {
                                Console.WriteLine("Please create an account first.");
                            }
                            else
                            {
                                Console.WriteLine("\n Account Details: ");
                                Console.WriteLine($"Account Number: {accountNumber}");
                                Console.WriteLine($"Account Holder: {accountHolderName}");
                                Console.WriteLine($"Current Balance: {balance}");
                            }
                            break;
                        }

                    case 5:
                        {
                            // Exit
                            Console.WriteLine("Exiting application.");
                            return; // Exit the Main method and terminate the program
                        }
                            default:
                            Console.WriteLine("Invalid choice. Please enter a number between 1 and 5.");
                            break;
                        
                }
                
            }
        }
    }
}
