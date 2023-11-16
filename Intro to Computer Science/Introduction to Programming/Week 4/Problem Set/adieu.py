import sys

def main():
    names = []
    while True:
        try:
            name = input("Name: ")
        except KeyboardInterrupt:
            print("", end="\n")
            adieu(names)
            sys.exit()
        else:
            names.append(name)

def adieu(names):
    print("Adieu, adieu, to", end="")
    if len(names) == 0:
        print(" no one")
    if len(names) == 1:
        print("", names[0])
    elif len(names) == 2:
        print("", names[0], "and", names[1])
    else:
        for i in range(len(names)):
            if i == (len(names) - 1):
                print(" and", names[i], end="")
            else:
                print(" ", names[i], ",", sep="", end="")

main()