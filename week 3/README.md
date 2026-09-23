# Week 3 Mini Project - ETL Pipeline with Unit Tests

## Student Details

- Name: Sonia Joshi
- USN: 1NT23CS238
- Program: DataGrokr Pre-Learning Program
- Week: 3
- Project: ETL Pipeline with Unit Tests

## Project Description

This project demonstrates an ETL (Extract, Transform, Load) pipeline using Python.

The pipeline fetches user data from a REST API, transforms the JSON data using Pandas, and saves the processed data into a CSV file.

Unit tests are implemented using pytest to verify the correctness of the pipeline.

## ETL Pipeline

The project follows three main stages:

### 1. Extract

User data is fetched from a REST API using the `requests` library.

### 2. Transform

The JSON data is converted into a Pandas DataFrame.

The required fields are extracted:

- ID
- Name
- Username
- Email
- City

### 3. Load

The transformed data is saved into:

`data/processed_users.csv`

## Generators

The project uses a Python generator with `yield` to demonstrate lazy evaluation.

The generator processes user records one at a time instead of creating all generated records at once.

## Unit Testing

The project uses `pytest` for testing.

The tests demonstrate:

- Test cases
- Pytest fixtures
- Parametrized tests
- DataFrame validation
- API response validation
- CSV file validation

## Project Structure

```text
week 3
├── data
│   └── processed_users.csv
├── output
├── .gitignore
├── etl_pipeline.py
├── test_etl_pipeline.py
└── README.md