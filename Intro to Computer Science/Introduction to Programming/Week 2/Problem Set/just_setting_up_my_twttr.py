def main():
    with_vowels = input("Input: ")
    without_vowels = remove_vowels(with_vowels)
    print(without_vowels)

def remove_vowels(with_vowels):
    without_vowels = ""
    for char in with_vowels:
        is_vowel = False
        for vowel in ["a", "e", "i", "o", "u"]:
            if char.lower() == vowel:
                is_vowel = True
        if not is_vowel:        
            without_vowels += char

    return without_vowels

main()