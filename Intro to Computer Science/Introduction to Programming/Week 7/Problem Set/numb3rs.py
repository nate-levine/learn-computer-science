import re


def main():
    print(validate(input("IPv4 Address: ")))


def validate(ip):
    if matches := re.search(r"^(.+)\.(.+)\.(.+)\.(.+)$", ip):
        str0, str1, str2, str3 = matches.groups()
    try:
        int0 = int(str0)
        int1 = int(str1)
        int2 = int(str2)
        int3 = int(str3)
    except ValueError:
        return False
    else:
        if (0 <= int0 <= 255) and (0 <= int1 <= 255) and (0 <= int2 <= 255) and (0 <= int3 <= 255):
            return True
        else:
            return False


if __name__ == "__main__":
    main()