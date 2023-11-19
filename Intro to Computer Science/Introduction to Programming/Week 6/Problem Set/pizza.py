import sys
from tabulate import tabulate


def main():
    if len(sys.argv) < 2 or len(sys.argv) > 2 or (not sys.argv[1].endswith(".csv")):
        sys.exit()

    formatted_data = format(sys.argv[1])
    print(tabulate(formatted_data[1:], headers=formatted_data[0], tablefmt="grid"))


def format(program_name):
    rows = []
    with open(program_name, "r") as file:
        for line in file:
            row = line.split(",")
            rows.append(row)
    return rows


if __name__ == "__main__":
    main()