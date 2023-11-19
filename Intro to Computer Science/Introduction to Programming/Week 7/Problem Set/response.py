from validator_collection import checkers


def main():
    is_valid = validate(input("What's your email address? "))
    if is_valid:
        print("Valid")
    else:
        print("Invalid")


def validate(value):
    return checkers.is_email(value, allow_empty=False)


if __name__ == "__main__":
    main()