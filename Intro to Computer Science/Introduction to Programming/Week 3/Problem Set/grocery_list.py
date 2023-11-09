def main():
    grocery_list = dict(sorted(get_items().items()))
    for item in grocery_list:
        count = grocery_list[item]
        print(f"{count} {item}")

def get_items():
    grocery_list = {}
    while True:
        try:
            item = input().lower()
        except KeyboardInterrupt:
            return grocery_list
        else:
            if item in grocery_list:
                grocery_list[item] += 1
            else:
                grocery_list[item] = 1

main()