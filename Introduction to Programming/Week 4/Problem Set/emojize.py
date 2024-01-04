import emoji
# Documentation: https://pypi.org/project/emoji/

def main():
    emoji_code = input("Input: ")
    print("Output:", emoji.emojize(emoji_code))

main()