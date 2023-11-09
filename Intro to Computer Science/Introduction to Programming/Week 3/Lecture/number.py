def main():
    x = get_int("What's x? ")
    print(f"x is {x}")

# Custom function like input(), but only returns ints
def get_int(prompt):
    # Catch value and name errors
    while True:
        try:
            x = int(input(prompt))
        except ValueError:
            pass
        else:
            break
    return x

main()