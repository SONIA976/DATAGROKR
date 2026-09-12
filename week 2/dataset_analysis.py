import pandas as pd
import numpy as np


def load_data():
    """Load transaction data from CSV file."""
    try:
        df = pd.read_csv("transactions.csv")
        return df

    except FileNotFoundError:
        print("Error: transactions.csv file not found.")
        return None


def analyze_transactions(df):
    """Perform pandas and NumPy analysis on transactions."""

    print("=" * 55)
    print("             TRANSACTION DATA ANALYSIS")
    print("=" * 55)

    # Display complete dataset
    print("\n1. TRANSACTION DATA")
    print("-" * 55)
    print(df.to_string(index=False))

    # Basic information
    print("\n2. DATASET INFORMATION")
    print("-" * 55)
    print(f"Number of transactions : {len(df)}")
    print(f"Total transaction amount: ₹{df['amount'].sum():.2f}")
    print(f"Average transaction     : ₹{df['amount'].mean():.2f}")
    print(f"Highest transaction     : ₹{df['amount'].max():.2f}")
    print(f"Lowest transaction      : ₹{df['amount'].min():.2f}")

    # NumPy analysis
    amounts = np.array(df["amount"])

    print("\n3. NUMPY ANALYSIS")
    print("-" * 55)
    print(f"NumPy total   : ₹{np.sum(amounts):.2f}")
    print(f"NumPy average : ₹{np.mean(amounts):.2f}")
    print(f"NumPy maximum : ₹{np.max(amounts):.2f}")
    print(f"NumPy minimum : ₹{np.min(amounts):.2f}")

    # Deposit and withdrawal analysis
    print("\n4. TRANSACTION TYPE ANALYSIS")
    print("-" * 55)

    transaction_summary = (
        df.groupby("transaction_type")["amount"]
        .agg(["count", "sum", "mean"])
        .reset_index()
    )

    transaction_summary.columns = [
        "Transaction Type",
        "Count",
        "Total Amount",
        "Average Amount"
    ]

    print(transaction_summary.to_string(index=False))

    # Customer analysis using groupby
    print("\n5. CUSTOMER ANALYSIS")
    print("-" * 55)

    customer_summary = (
        df.groupby("customer")["amount"]
        .agg(["count", "sum", "mean"])
        .reset_index()
    )

    customer_summary.columns = [
        "Customer",
        "Transactions",
        "Total Amount",
        "Average Amount"
    ]

    print(customer_summary.to_string(index=False))

    # Account type analysis
    print("\n6. ACCOUNT TYPE ANALYSIS")
    print("-" * 55)

    account_summary = (
        df.groupby("account_type")["amount"]
        .agg(["count", "sum"])
        .reset_index()
    )

    account_summary.columns = [
        "Account Type",
        "Transactions",
        "Total Amount"
    ]

    print(account_summary.to_string(index=False))

    # Lambda example
    print("\n7. LAMBDA ANALYSIS")
    print("-" * 55)

    df["transaction_size"] = df["amount"].apply(
        lambda amount: "High" if amount >= 5000 else "Normal"
    )

    print(
        df[["customer", "amount", "transaction_size"]]
        .to_string(index=False)
    )

    # Map example
    print("\n8. MAP EXAMPLE")
    print("-" * 55)

    type_mapping = {
        "Deposit": "Money Added",
        "Withdrawal": "Money Removed"
    }

    df["transaction_description"] = df["transaction_type"].map(
        type_mapping
    )

    print(
        df[
            ["transaction_type", "transaction_description"]
        ].drop_duplicates().to_string(index=False)
    )

    # Filter example
    print("\n9. FILTERED TRANSACTIONS")
    print("-" * 55)

    high_value_transactions = df[
        df["amount"] >= 5000
    ]

    print(high_value_transactions.to_string(index=False))

    # List comprehension
    print("\n10. LIST COMPREHENSION")
    print("-" * 55)

    high_amounts = [
        amount for amount in df["amount"]
        if amount >= 5000
    ]

    print("Transactions >= ₹5000:", high_amounts)

    # Dictionary comprehension
    print("\n11. DICTIONARY COMPREHENSION")
    print("-" * 55)

    customer_totals = {
        customer: total
        for customer, total in df.groupby("customer")["amount"].sum().items()
    }

    print(customer_totals)

    print("\n" + "=" * 55)
    print("             ANALYSIS COMPLETED")
    print("=" * 55)


def main():
    df = load_data()

    if df is not None:
        analyze_transactions(df)


if __name__ == "__main__":
    main()