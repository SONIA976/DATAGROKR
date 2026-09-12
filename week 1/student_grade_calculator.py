import csv
import os


def calculate_grade(average):
    if average >= 90:
        return "A+"
    elif average >= 80:
        return "A"
    elif average >= 70:
        return "B"
    elif average >= 60:
        return "C"
    elif average >= 50:
        return "D"
    else:
        return "F"


def get_marks(subject):
    while True:
        try:
            marks = float(input(f"Enter marks for {subject}: "))

            if 0 <= marks <= 100:
                return marks
            else:
                print("Marks must be between 0 and 100.")

        except ValueError:
            print("Please enter a valid number.")


def calculate_result(marks):
    total = sum(marks.values())
    average = total / len(marks)
    grade = calculate_grade(average)

    if average >= 50:
        status = "PASS"
    else:
        status = "FAIL"

    return total, average, grade, status


def save_result(name, marks, total, average, grade, status):
    file_path = os.path.join(os.path.dirname(__file__), "students.csv")

    file_exists = os.path.exists(file_path)

    with open(file_path, "a", newline="") as file:
        writer = csv.writer(file)

        if not file_exists or os.path.getsize(file_path) == 0:
            writer.writerow([
                "Name",
                "Python",
                "SQL",
                "Git",
                "Total",
                "Average",
                "Grade",
                "Status"
            ])

        writer.writerow([
            name,
            marks["Python"],
            marks["SQL"],
            marks["Git"],
            total,
            round(average, 2),
            grade,
            status
        ])


def main():
    print("=" * 45)
    print("       STUDENT GRADE CALCULATOR")
    print("=" * 45)

    name = input("Enter student name: ").strip()

    subjects = ["Python", "SQL", "Git"]
    marks = {}

    for subject in subjects:
        marks[subject] = get_marks(subject)

    total, average, grade, status = calculate_result(marks)

    print("\n" + "=" * 45)
    print("                 RESULT")
    print("=" * 45)

    print(f"Student Name : {name}")

    for subject, mark in marks.items():
        print(f"{subject:<13}: {mark}")

    print("-" * 45)
    print(f"Total        : {total}")
    print(f"Average      : {average:.2f}")
    print(f"Grade        : {grade}")
    print(f"Status       : {status}")
    print("=" * 45)

    save_result(name, marks, total, average, grade, status)

    print("Result saved successfully!")


if __name__ == "__main__":
    main()