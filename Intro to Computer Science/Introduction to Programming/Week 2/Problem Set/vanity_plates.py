def main():
    plate = input("Plate: ")
    if is_valid(plate):
        print("Valid")
    else:
        print("Invalid")

def is_valid(s):
    if s[0].isnumeric() or s[1].isnumeric():
        return False
    
    if len(s) > 6:
        return False
    
    for char in s:
        if (not char.isalpha()) and (not char.isnumeric()):
            return False
    
    start_nums = False
    for char in s:
        if char.isalpha() and start_nums:
            return False
        if char.isnumeric():
            start_nums = True

    return True
    
main()