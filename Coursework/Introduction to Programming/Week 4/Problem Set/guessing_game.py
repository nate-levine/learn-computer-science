import random

def main():
    while True:
        try:
            num = int(input("Level: "))
        except ValueError:
            pass
        else:
            if num > 0:
                guess(num)
                break
            else:
                continue

def guess(n):
    num = random.randint(1, n)

    while True:
        try:
            guess = int(input("Guess: "))
        except ValueError:
            pass
        else:
            if guess > 0:
                if guess > num:
                    print("Too large!")
                elif guess < num:
                    print("Too small!")
                else:
                    print("Just right!")
                    break
            else:
                continue

main()