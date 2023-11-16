import random

def main():
    level = get_level()
    score = 0

    for _ in range(0, 10):
        mistakes = 0

        x = generate_integer(level)
        y = generate_integer(level)
        sum = x + y

        while True:
            print(f"{x} + {y} = ", end="")
            if mistakes == 3:
                print(sum)
                break
            try:
                num = int(input(""))
            except ValueError:
                print("EEE")
                mistakes += 1
            else:
                if num == sum:
                    score += 1
                    break
                else:
                    print("EEE")
                    mistakes += 1
    print("Score:", score)


def get_level():
    while True:
        try:
            level = int(input("Level: "))
        except ValueError:
            pass
        else:
            if 1 <= level <= 3:
                return level
            else:
                continue

def generate_integer(level):
    if level == 1:
        return random.randint(0, 9)
    elif level == 2:
        return random.randint(10, 99)
    elif level == 3:
        return random.randint(100, 999)

if __name__ == "__main__":
    main()