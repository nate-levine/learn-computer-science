def main():
    expression = input("Expression: ")
    print(interpret(expression))

def interpret(exp):
    x, y, z  = exp.split()

    x = float(x)
    z = float(z)

    match y:
        case "+":
            return round(x + z, 1)
        case "-":
            return round(x - z, 1)
        case "*":
            return round(x * z, 1)
        case "/":
            if (z == 0):
                return "NaN"
            else:
                return round(x / z, 1)
        case _:
            return "No such operator exists."
        
main()