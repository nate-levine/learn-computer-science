# Main program
def main():
    # Get x from input
    x = int(input("What's x? "))
    # Print the squared number
    print("x squared is,", square(x))

# Square a number
def square(n):
    # Return the squared number
    return n * n

# Call the main function
main()