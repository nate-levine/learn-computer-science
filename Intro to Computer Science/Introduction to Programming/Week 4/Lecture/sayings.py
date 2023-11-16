def main():
    hello("world")
    goodbye("world")

def hello(name):
    print(f"Hello, {name}")

def goodbye(name):
    print(f"Goodbye, {name}")

# Aviod calling main when importing the module to another program
if __name__ == "__main__":
# Test functions in the module
    main()