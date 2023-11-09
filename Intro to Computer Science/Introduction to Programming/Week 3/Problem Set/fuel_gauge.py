def main():
    fraction = get_fraction("Fraction: ")
    if fraction >= .99:
        print("F")
    elif fraction <= .01:
        print("E")
    else:
        print(f"{round(fraction * 100)}%")

def get_fraction(prompt):
    while True:
        input_frac = input(prompt)
        try:
            x, y = input_frac.split("/")
            fraction = int(x) / int(y)
        except ValueError:
            pass
        else:
            if 0.0 <= fraction <= 1.0:
                return fraction
            else:
                pass

main()