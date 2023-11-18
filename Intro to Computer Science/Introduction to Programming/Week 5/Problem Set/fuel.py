import sys


def main():
    string = input("Fraction: ")
    percentage = convert(string)
    if percentage == ValueError or percentage == ZeroDivisionError:
        sys.exit()
    else:
        reading = gauge(percentage)
    print(reading)


def convert(fraction):    
    try:
        x, y = fraction.split("/")
        x = int(x)
        y = int(y)
    except ValueError:
        return ValueError
    else:
        try:
            decimal = x / y
        except ZeroDivisionError:
            return ZeroDivisionError
        else:
            if x > y:
                return ValueError
            elif decimal < 0.0 or decimal > 1.0:
                return ValueError
            else:
                return round(decimal * 100)


def gauge(percentage):
    if percentage >= 99:
        return "F"
    elif percentage <= 1:
        return "E"
    else:
        return f"{percentage}%"


if __name__ == "__main__":
    main()