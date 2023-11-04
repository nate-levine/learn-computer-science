def main():
    text = convert(input())
    print(text)

def convert(text):
    emoji_text = text.replace(":)", "🙂").replace(":(", "🙁")
    return emoji_text

main()