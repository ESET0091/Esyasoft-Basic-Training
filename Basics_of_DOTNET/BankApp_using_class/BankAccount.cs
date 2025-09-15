using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BankApp_using_class
{
    internal class BankAccount
    {

        // Properties
        public string AccountNumber { get; private set; }
        public string AccountHolder { get; private set; }
        public decimal Balance { get; private set; }

        // Constructor
        public BankAccount(string accountNumber, string accountHolder, decimal initialBalance = 0)
        {
            AccountNumber = accountNumber;
            AccountHolder = accountHolder;
            Balance = initialBalance;
        }

        // Method to deposit money
        public bool Deposit(decimal amount)
        {
            if (amount <= 0)
            {
                Console.WriteLine("Error: Deposit amount must be positive.");
                return false;
            }

            Balance += amount;
            Console.WriteLine($"Successfully deposited ${amount:F2}");
            return true;
        }

        // Method to withdraw money
        public bool Withdraw(decimal amount)
        {
            if (amount <= 0)
            {
                Console.WriteLine("Error: Withdrawal amount must be positive.");
                return false;
            }

            if (amount > Balance)
            {
                Console.WriteLine("Error: Insufficient funds for withdrawal.");
                return false;
            }

            Balance -= amount;
            Console.WriteLine($"Successfully withdrew ${amount:F2}");
            return true;
        }

        // Method to display account details
        public void DisplayDetails()
        {
            Console.WriteLine("\n=== Account Details ===");
            Console.WriteLine($"Account Number: {AccountNumber}");
            Console.WriteLine($"Account Holder: {AccountHolder}");
            Console.WriteLine($"Balance: ${Balance:F2}");
            Console.WriteLine("=======================\n");
        }
    }
}

    
