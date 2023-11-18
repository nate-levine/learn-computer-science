def main():
    plate = input("Plate: ")
    if is_valid(plate):
        print("Valid")
    else:
        print("Invalid")


def is_valid(s):
    # The first or second characters are not numerals
    if s[0].isnumeric() or s[1].isnumeric():
        return False
    
    # Less than 6 characters
    if len(s) > 6:
        return False
    
    # The plate contains only alphanumeric characters
    for char in s:
        if (not char.isalpha()) and (not char.isnumeric()):
            return False
    
    # There are no letters after any numbers in the sequence
    start_nums = False
    for char in s:
        if char.isalpha() and start_nums:
            return False
        if char.isnumeric():
            start_nums = True

    return True


if __name__ == "__main__":
    main()