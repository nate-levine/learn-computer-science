def main():
    sum = 0
    while True:
        amount = int(input("Insert Coin: "))

        if (amount == 5) | (amount == 10) | (amount == 25):
            sum += amount

        if sum >= 50:
            change = get_change(sum)
            print("Change Owed:", change)
            break
        else:
            amount_due = get_amount_due(sum)
            print("Amount Due:", amount_due)
            continue

def get_change(sum):
    return sum - 50

def get_amount_due(sum):
    return 50 - sum

main()