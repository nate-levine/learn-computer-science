# It's ironic how the name of the camel case file is in snake case
# Convert camel case to snake case

def main():
    camelCase = input("camelCase: ")
    snake_case = camel_to_snake_case(camelCase)
    print("snake_case:", snake_case)

def camel_to_snake_case(camelCase):
    snake_case = ""

    for char in camelCase:
        if char.isupper():
            snake_case += "_"
            snake_case += char.lower()
        else:
            snake_case += char
    
    return snake_case

main()