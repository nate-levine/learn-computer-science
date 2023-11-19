import sys
import csv


def main():
    if len(sys.argv) < 3 or len(sys.argv) > 3 or (not sys.argv[1].endswith(".csv")) or (not sys.argv[2].endswith(".csv")):
        sys.exit()
    
    data = read_file(sys.argv[1])
    write_file(sys.argv[2], data)


def read_file(program_name):
    data = []

    try:
        with open(program_name, "r") as file:
            reader = csv.DictReader(file)
            for row in reader:
                data.append({"name": row["name"], "house": row["house"]})
        return data
    except FileNotFoundError:
        sys.exit()


def write_file(program_name, data):
    with open(program_name, "w", newline="") as file:
        writer = csv.DictWriter(file, fieldnames=["first", "last", "house"])
        writer.writeheader()
        for row in data:
            last, first = row["name"].split(", ")
            house = row["house"]
            writer.writerow({"first": first, "last": last, "house": house})


if __name__ == "__main__":
    main()