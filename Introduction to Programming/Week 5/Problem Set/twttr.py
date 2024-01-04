def main():
    word = input("Input: ")
    shortened = shorten(word)
    print(shortened)


def shorten(word):
    shortened = ""
    for char in word:
        is_vowel = False
        for vowel in ["a", "e", "i", "o", "u"]:
            if char.lower() == vowel:
                is_vowel = True
        if not is_vowel:        
            shortened += char

    return shortened


if __name__ == "__main__":
    main() 