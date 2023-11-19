import re
import sys


def main():
    print(convert(input("Hours: ")))


def convert(time):
    if matches := re.search(r"^(\d\d?):?(\d\d)?( AM| PM)$", time):
        #print(f"{matches.group(1)}, {matches.group(2)}, {matches.group(3)}")
        try:
            hours = int(matches.group(1))
            if matches.group(2):
                minutes = int(matches.group(2))
            meridiem = matches.group(3)
        except ValueError:
            sys.exit()
        else:
            if not (1 <= hours <= 12):
                sys.exit()
            if meridiem == " PM" and hours != 12:
                hours += 12
                hours = str(hours)
            elif meridiem == " AM" and hours < 10:
                hours = f"0{hours}"
            elif meridiem == " AM" and hours == 12:
                hours = "00"

            if matches.group(2):
                if not (0 <= minutes <= 59):
                    sys.exit()
                if minutes == 0:
                    minutes = "00"
                return f"{hours}:{minutes}"
            else:
                return f"{hours}:00"


if __name__ == "__main__":
    main()