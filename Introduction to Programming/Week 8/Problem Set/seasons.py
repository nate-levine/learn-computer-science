import re
from datetime import date
import inflect


def main():
    birth_date = get_birth_date(input("Date of Birth: "))
    if not birth_date:
        raise ValueError("Invalid date: Date must be in YYYY-MM-DD format.")

    birth = date(birth_date["year"], birth_date["month"], birth_date["day"])
    today = date.today()
    days_passed = today - birth
    minutes_passed = days_passed.days * 24 * 60

    p = inflect.engine()
    words = p.number_to_words(minutes_passed)
    print(f"{words} minutes")

    

def get_birth_date(date):
    if matches := re.search(r"(^\d{4})-(\d{2})-(\d{2}$)", date):
        return {"year": int(matches.group(1)), "month": int(matches.group(2)), "day": int(matches.group(3))}
    else:
        return False
    

if __name__ == "__main__":
    main()