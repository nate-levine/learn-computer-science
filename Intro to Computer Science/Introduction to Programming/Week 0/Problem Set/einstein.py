def main():
    mass = int(input("m: "))
    energy = einstein(mass)
    print("E:", energy)

def einstein(mass):
    c = 300000000
    energy = mass * (c ** 2)
    return energy
    
main()