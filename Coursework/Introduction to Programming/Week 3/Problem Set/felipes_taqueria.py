menu = {
    "Baja Taco": 4.25,
    "Burrito": 7.50,
    "Bowl": 8.50,
    "Nachos": 11.00,
    "Quesadilla": 8.50,
    "Super Burrito": 8.50,
    "Super Quesadilla": 9.50,
    "Taco": 3.00,
    "Tortilla Salad": 8.00
}

def main():
        total = get_total("Item: ")

def get_total(prompt):
    total = 0.00
    while True:
        try:
            menu_item = input(prompt)
        except KeyboardInterrupt:
            break
        else:
            if menu_item.title() in menu:
                price = menu[menu_item.title()]
                total += price
                print(f"Total: ${total:.2f}")
        
main()