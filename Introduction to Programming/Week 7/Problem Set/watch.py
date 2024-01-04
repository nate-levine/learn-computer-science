import re


def main():
    print(parse(input("HTML: ")))


def parse(html):
    if matches := re.search(r"src=\"https?://(?:www\.)?youtube\.com/embed/([a-zA-Z0-9]+)", html):
        # Return the first parenthesized subgroup
        return f"https://youtu.be/{matches.group(1)}"


if __name__ == "__main__":
    main()