# Main program
def main():
    # Get name
    name = input("What's your name? ")
    # Use hello function without an argument
    hello()
    # Use hello function with name as an argument
    hello(name)


# Says hello 'to' someone
def hello(to="world"):
    print("Hello,", to)

# Call the main function
main()