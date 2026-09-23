import requests
import pandas as pd


API_URL = "https://jsonplaceholder.typicode.com/users"


def fetch_data():
    """Fetch user data from REST API."""
    response = requests.get(API_URL)

    if response.status_code == 200:
        return response.json()

    raise Exception("Failed to fetch data from API.")


def transform_data(data):
    """Transform JSON data into a pandas DataFrame."""
    df = pd.DataFrame(data)

    result = pd.DataFrame({
        "id": df["id"],
        "name": df["name"],
        "username": df["username"],
        "email": df["email"],
        "city": df["address"].apply(lambda address: address["city"])
    })

    return result


def save_data(df):
    """Save transformed data to CSV."""
    output_file = "data/processed_users.csv"
    df.to_csv(output_file, index=False)

    return output_file


def user_generator(data):
    """Generate users one at a time using lazy evaluation."""
    for user in data:
        yield {
            "id": user["id"],
            "name": user["name"],
            "email": user["email"]
        }


def run_pipeline():
    """Run the complete ETL pipeline."""

    print("=" * 50)
    print("             ETL PIPELINE")
    print("=" * 50)

    # Extract
    print("\n1. Extracting data from REST API...")

    data = fetch_data()

    print(f"Fetched {len(data)} records.")

    # Generator
    print("\n2. Using generator for lazy evaluation...")

    users = user_generator(data)

    first_user = next(users)

    print("First user generated:")
    print(first_user)

    # Transform
    print("\n3. Transforming data using Pandas...")

    df = transform_data(data)

    print(df.to_string(index=False))

    # Load
    print("\n4. Loading data into CSV...")

    output_file = save_data(df)

    print(f"Data saved to: {output_file}")

    print("\n" + "=" * 50)
    print("       ETL PIPELINE COMPLETED")
    print("=" * 50)


if __name__ == "__main__":
    run_pipeline()