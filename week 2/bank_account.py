class BankAccount:
    def __init__(self, account_number, customer_name, balance=0):
        self.account_number = account_number
        self.customer_name = customer_name
        self.balance = balance
        self.transactions = []

    def deposit(self, amount):
        if amount <= 0:
            print("Deposit amount must be greater than 0.")
            return

        self.balance += amount

        self.transactions.append(
            f"Deposited: ₹{amount:.2f}"
        )

        print(f"₹{amount:.2f} deposited successfully.")

    def withdraw(self, amount):
        if amount <= 0:
            print("Withdrawal amount must be greater than 0.")
            return

        if amount > self.balance:
            print("Insufficient balance.")
            return

        self.balance -= amount

        self.transactions.append(
            f"Withdrawn: ₹{amount:.2f}"
        )

        print(f"₹{amount:.2f} withdrawn successfully.")

    def check_balance(self):
        print(f"Current balance: ₹{self.balance:.2f}")

    def show_transactions(self):
        print("\nTransaction History")
        print("-" * 30)

        if not self.transactions:
            print("No transactions found.")
            return

        for transaction in self.transactions:
            print(transaction)


class SavingsAccount(BankAccount):
    def __init__(self, account_number, customer_name, balance=0, interest_rate=4):
        super().__init__(account_number, customer_name, balance)
        self.interest_rate = interest_rate

    def account_info(self):
        return f"Savings Account - Interest Rate: {self.interest_rate}%"


class CurrentAccount(BankAccount):
    def __init__(self, account_number, customer_name, balance=0, overdraft_limit=5000):
        super().__init__(account_number, customer_name, balance)
        self.overdraft_limit = overdraft_limit

    def account_info(self):
        return f"Current Account - Overdraft Limit: ₹{self.overdraft_limit:.2f}"


def main():
    savings = SavingsAccount(
        "SAV1001",
        "Sonia Joshi",
        5000
    )

    current = CurrentAccount(
        "CUR1001",
        "Rahul",
        10000
    )

    print("=" * 45)
    print("          BANK ACCOUNT SYSTEM")
    print("=" * 45)

    print("\nSAVINGS ACCOUNT")
    print("-" * 45)
    print(f"Customer      : {savings.customer_name}")
    print(f"Account Number: {savings.account_number}")
    print(savings.account_info())

    savings.check_balance()
    savings.deposit(2000)
    savings.withdraw(1000)
    savings.check_balance()

    print("\nCURRENT ACCOUNT")
    print("-" * 45)
    print(f"Customer      : {current.customer_name}")
    print(f"Account Number: {current.account_number}")
    print(current.account_info())

    current.check_balance()
    current.deposit(3000)
    current.withdraw(2000)
    current.check_balance()

    print("\n" + "=" * 45)
    print("SAVINGS ACCOUNT TRANSACTIONS")
    print("=" * 45)
    savings.show_transactions()

    print("\n" + "=" * 45)
    print("CURRENT ACCOUNT TRANSACTIONS")
    print("=" * 45)
    current.show_transactions()

    print("\n" + "=" * 45)
    print("Program completed successfully!")
    print("=" * 45)


if __name__ == "__main__":
    main()