namespace BankApp_using_class
{
    internal class Program
    {
        static void Main(string[] args)
        {
            BankAccount account = null;
            bool exit = false;

            Console.WriteLine("=== Welcome to Virtual Banking System ===\n");

            while (!exit)
            {
                DisplayMenu();
                Console.Write("Enter your choice (1-5): ");

                if (int.TryParse(Console.ReadLine(), out int choice))
                {
                    switch (choice)
                    {
                        case 1: // Create account
                            CreateAccount(ref account);
                            break;

                        case 2: // Deposit money
                            if (ValidateAccount(account))
                                DepositMoney(account);
                            break;

                        case 3: // Withdraw money
                            if (ValidateAccount(account))
                                WithdrawMoney(account);
                            break;

                        case 4: // Display account details
                            if (ValidateAccount(account))
                                account.DisplayDetails();
                            break;

                        case 5: // Exit
                            exit = true;
                            Console.WriteLine("Thank you for using Virtual Banking System. Goodbye!");
                            break;

                        default:
                            Console.WriteLine("Invalid choice. Please enter a number between 1-5.");
                            break;
                    }
                }
                else
                {
                    Console.WriteLine("Invalid input. Please enter a number.");
                }

                Console.WriteLine(); // Empty line for better readability
            }
        }

        // Method to display the menu
        static void DisplayMenu()
        {
            Console.WriteLine("Please select an option:");
            Console.WriteLine("1. Create a new bank account");
            Console.WriteLine("2. Deposit money");
            Console.WriteLine("3. Withdraw money");
            Console.WriteLine("4. Display account details");
            Console.WriteLine("5. Exit");
        }

        // Method to create a new account
        static void CreateAccount(ref BankAccount account)
        {
            Console.Write("Enter account number: ");
            string accountNumber = Console.ReadLine();

            Console.Write("Enter account holder name: ");
            string accountHolder = Console.ReadLine();

            Console.Write("Enter initial deposit amount (optional, press Enter for $0): ");
            string initialDepositInput = Console.ReadLine();

            decimal initialDeposit = 0;
            if (!string.IsNullOrEmpty(initialDepositInput))
            {
                if (!decimal.TryParse(initialDepositInput, out initialDeposit) || initialDeposit < 0)
                {
                    Console.WriteLine("Invalid amount. Setting initial deposit to $0.00");
                    initialDeposit = 0;
                }
            }

            account = new BankAccount(accountNumber, accountHolder, initialDeposit);
            Console.WriteLine($"\nAccount created successfully!");
            Console.WriteLine($"Account Number: {accountNumber}");
            Console.WriteLine($"Account Holder: {accountHolder}");
            Console.WriteLine($"Initial Balance: ${initialDeposit:F2}");
        }

        // Method to deposit money
        static void DepositMoney(BankAccount account)
        {
            Console.Write("Enter amount to deposit: ");
            if (decimal.TryParse(Console.ReadLine(), out decimal amount))
            {
                account.Deposit(amount);
            }
            else
            {
                Console.WriteLine("Invalid amount. Please enter a valid number.");
            }
        }

        // Method to withdraw money
        static void WithdrawMoney(BankAccount account)
        {
            Console.Write("Enter amount to withdraw: ");
            if (decimal.TryParse(Console.ReadLine(), out decimal amount))
            {
                account.Withdraw(amount);
            }
            else
            {
                Console.WriteLine("Invalid amount. Please enter a valid number.");
            }
        }

        // Method to validate if an account exists
        static bool ValidateAccount(BankAccount account)
        {
            if (account == null)
            {
                Console.WriteLine("Error: No account found. Please create an account first.");
                return false;
            }
            return true;
        }
    }
}
