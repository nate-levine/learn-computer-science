nutritional_information = {
    "apple": "130",
    "banana": "110",
    "grapes": "60",
    ";emon": "15",
    "peach": "60",
}

def main():
    fruit = input("Item: ")
    calories = get_calories(fruit.lower())
    print("Calories: ", calories)

def get_calories(fruit):
    if fruit in nutritional_information:
        return nutritional_information[fruit]
    else:
        return "Unknown"

main()