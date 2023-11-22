# mypy type hints and docstrings example
def meow(n: int) -> None:
    """
    Meow n times.
    
    :param n: Number of times to meow
    :type n: int
    :raise TypeError: If n is not an int
    :return: A string of n meows, one per line
    :rtype: None
    """
    for _ in range(n):
        print("meow")

    
number = input("Number: ")
meows: str = meow(number)
print(meows)