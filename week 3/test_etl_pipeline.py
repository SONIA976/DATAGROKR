import pytest
import pandas as pd

from etl_pipeline import fetch_data, transform_data, save_data


# Fixture
@pytest.fixture
def sample_data():
    return [
        {
            "id": 1,
            "name": "Test User",
            "username": "testuser",
            "email": "test@example.com",
            "address": {
                "city": "Bangalore"
            }
        },
        {
            "id": 2,
            "name": "Another User",
            "username": "anotheruser",
            "email": "another@example.com",
            "address": {
                "city": "Mysore"
            }
        }
    ]


# Test transformation
def test_transform_data(sample_data):
    df = transform_data(sample_data)

    assert isinstance(df, pd.DataFrame)
    assert len(df) == 2
    assert list(df.columns) == [
        "id",
        "name",
        "username",
        "email",
        "city"
    ]
    assert df.iloc[0]["city"] == "Bangalore"


# Test API data
def test_fetch_data():
    data = fetch_data()

    assert isinstance(data, list)
    assert len(data) > 0
    assert "id" in data[0]
    assert "name" in data[0]


# Test saving CSV
def test_save_data(tmp_path, sample_data):
    df = transform_data(sample_data)

    output_file = tmp_path / "test_output.csv"

    df.to_csv(output_file, index=False)

    assert output_file.exists()


# Parametrized test
@pytest.mark.parametrize(
    "value,expected",
    [
        (2, 4),
        (3, 9),
        (5, 25),
        (10, 100)
    ]
)
def test_square(value, expected):
    assert value ** 2 == expected