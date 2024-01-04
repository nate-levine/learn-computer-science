import sys
import random
import pyfiglet
# Documentation: https://pypi.org/project/pyfiglet/0.7/

def main():
    # Exit the program if the arguments are invalid
    if len(sys.argv) != 1 and len(sys.argv) != 3:
        sys.exit()

    # Start with a random font
    font = random.choice(pyfiglet.FigletFont.getFonts())
    # Change if font is specified
    if len(sys.argv) == 3:
        if sys.argv[1] == "-f" or sys.argv[1] == "--font":
            font = sys.argv[2]

    # Prompt
    text = input("Input: ")
    # Convert text to figlet
    result = pyfiglet.figlet_format(text, font=font) 
    # Print figlet
    print("Output:\n", result)

main()