def main():
    answer = input("What is the Answer to the Great Question of Life, the Universe, and Everything? ")
    response = deep_thought(answer)
    print(response)

def deep_thought(answer):
    match answer.lower():
        case "42" | "forty-two" | "forty two":
            print(answer)
            return "Yes"
        case _:
            print(answer)
            return "No"
        
main()