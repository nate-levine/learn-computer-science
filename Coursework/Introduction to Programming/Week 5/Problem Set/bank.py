def main():
    greeting = input("Greeting: ")
    amount_of_money = value(greeting)
    print(amount_of_money)


def value(greeting):
    greeting = greeting.lower()

    if greeting.startswith("hello"):
        return "$0"
    elif greeting.startswith("h"):
        return "$20"
    else:
        return "$100"

  
if __name__ == "__main__":
    main()