def main():
    time = input("What time is it? ")
    float_time = convert(time)
    # Decide what meal time it is
    if 7.0 <= float_time <= 8.0:
        print("breakfast time")
    elif 12.0 <= float_time <= 13.0:
        print("lunch time")
    elif 18.0 <= float_time <= 19.0:
        print("dinner time")
    else:
        print("it is not meal time")

def convert(time):
    hr, min = time.split(":")
    float_time = float(hr) + (float(min) / 60)
    return float_time

if __name__ == "__main__":
    main()