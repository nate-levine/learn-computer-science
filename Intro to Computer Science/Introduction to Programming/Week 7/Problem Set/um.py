import re


def main():
    print(count(input("Text: ")))


def count(text):
    return len(re.findall(r"(\b[U-u]m\b)", text))


if __name__ == "__main__":
    main()