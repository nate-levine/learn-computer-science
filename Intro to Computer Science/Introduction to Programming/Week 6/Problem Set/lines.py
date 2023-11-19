import sys


def main():
    if len(sys.argv) < 2 or len(sys.argv) > 2:
        sys.exit()
    elif not sys.argv[1].endswith(".py"):
        sys.exit()

    count = line_count(sys.argv[1])
    print(count)


def line_count(program_name):
    line_count = 0
    with open(program_name, "r") as file:
        for line in file:
            if (not line == "\n") and (not line.startswith("#")):
                line_count += 1
    return line_count


if __name__ == "__main__":
    main()