import csv


# Write
name = input("What's your name? ")
age = input("What's your age? ")

with open("names.csv", "a") as file:
    writer = csv.DictWriter(file, fieldnames=["name", "age"])
    writer.writerow({"name": name, "age": age})


# Read
people = []

with open("names.csv", "r") as file:
    reader = csv.DictReader(file)
    for row in reader:
        people.append({"name": row["name"], "age": row["home"]})


for person in sorted(people, key=lambda person : person["name"]):
    print(f"{person['name']} is in {person['age']}")