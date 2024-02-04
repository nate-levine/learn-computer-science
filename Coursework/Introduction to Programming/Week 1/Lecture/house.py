# Match Harry Potter house
name = input("What's your name? ")

match name:
    case "Harry" | "Hermione":
        print("Gryffindor")
    case "Draco":
        print("Slytherin")
    case _:
        print("Who?")