def main():
    greeting = input("Greeting: ")
    amount_of_money = starts_with(greeting)
    print(amount_of_money)

def starts_with(greeting):
    greeting = greeting.lower()

    if greeting.startswith("hello"):
        return "$0"
    elif greeting.startswith("h"):
        return "$20"
    else:
        return "$100"
    
main()