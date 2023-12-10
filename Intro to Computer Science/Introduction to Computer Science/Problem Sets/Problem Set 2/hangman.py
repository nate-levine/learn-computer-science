# Problem Set 2, hangman.py
# Name: 
# Collaborators:
# Time spent:

# Hangman Game
# -----------------------------------
# Helper code
# You don't need to understand this helper code,
# but you will have to know how to use the functions
# (so be sure to read the docstrings!)
import random
import string

WORDLIST_FILENAME = "words.txt"


def load_words():
    """
    Returns a list of valid words. Words are strings of lowercase letters.
    
    Depending on the size of the word list, this function may
    take a while to finish.
    """
    print("Loading word list from file...")
    # inFile: file
    inFile = open(WORDLIST_FILENAME, 'r')
    # line: string
    line = inFile.readline()
    # wordlist: list of strings
    wordlist = line.split()
    print("  ", len(wordlist), "words loaded.")
    return wordlist



def choose_word(wordlist):
    """
    wordlist (list): list of words (strings)
    
    Returns a word from wordlist at random
    """
    return random.choice(wordlist)

# end of helper code

# -----------------------------------

# Load the list of words into the variable wordlist
# so that it can be accessed from anywhere in the program
wordlist = load_words()


def is_word_guessed(secret_word, letters_guessed):
    '''
    secret_word: string, the word the user is guessing; assumes all letters are
      lowercase
    letters_guessed: list (of letters), which letters have been guessed so far;
      assumes that all letters are lowercase
    returns: boolean, True if all the letters of secret_word are in letters_guessed;
      False otherwise
    '''
    # Remove letters from secret word
    secret_word
    for letter in letters_guessed:
        secret_word = secret_word.replace(letter, "")
    # Return if the length of the secret word is 0 or not
    return len(secret_word) == 0



def get_guessed_word(secret_word, letters_guessed):
    '''
    secret_word: string, the word the user is guessing
    letters_guessed: list (of letters), which letters have been guessed so far
    returns: string, comprised of letters, underscores (_), and spaces that represents
      which letters in secret_word have been guessed so far.
    '''
    secret_guess = ""
    for secret_letter in secret_word:
      guess_flag = False
      # If the letter is in the word, add to the secret guess and flag the guess as "True"
      for letter_guessed in letters_guessed:
        if secret_letter == letter_guessed:
          secret_guess += secret_letter
          guess_flag = True
      # Add a blank if the guess is not in the secret word.
      if not guess_flag:
        secret_guess += "_ "
    # Return the secret guess
    return secret_guess



def get_available_letters(letters_guessed):
    '''
    letters_guessed: list (of letters), which letters have been guessed so far
    returns: string (of letters), comprised of letters that represents which letters have not
      yet been guessed.
    '''
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    available_letters = ""
    for letter in alphabet:
        guess_flag = False
        # If the letter is already guessed, flag the guess as "True"
        if letter in letters_guessed:
            guess_flag = True
        # If the guess is not flagged as "True", add it to the letters left to guess
        if not guess_flag:
          available_letters += letter
    # Return the letters yet to be guessed
    return available_letters
    
    

def hangman(secret_word):
    '''
    secret_word: string, the secret word to guess.
    
    Starts up an interactive game of Hangman.
    
    * At the start of the game, let the user know how many 
      letters the secret_word contains and how many guesses s/he starts with.
      
    * The user should start with 6 guesses

    * Before each round, you should display to the user how many guesses
      s/he has left and the letters that the user has not yet guessed.
    
    * Ask the user to supply one guess per round. Remember to make
      sure that the user puts in a letter!
    
    * The user should receive feedback immediately after each guess 
      about whether their guess appears in the computer's word.

    * After each guess, you should display to the user the 
      partially guessed word so far.
    
    Follows the other limitations detailed in the problem write-up.
    '''
    num_guesses = 6
    num_warnings = 0
    unique_letters = 0
    letters_guessed = []

    print("Welcome to the game Hangman!")
    word_length = len(secret_word)
    print(f"I am thinking of a word that is {word_length} letters long.")

    # While the word hasn't been guessed or the player still has guesses left
    while (not is_word_guessed(secret_word, letters_guessed)) and num_guesses > 0:
        print("----------------")
        print(f"You have {num_guesses} guesses left.")
        print(f"Available letters: {get_available_letters(letters_guessed)}")
        # Guess letter
        letter = ""
        # Warnings for invalid guesses
        while True:
          if 0 <num_warnings < 3:
              print(f"You have {num_warnings} warnings. 3 warnings and you will lose a guess.")
              print(f"Available letters: {get_available_letters(letters_guessed)}")
              # Print the guessed word so far
              print(get_guessed_word(secret_word, letters_guessed))
              print("----------------")
          elif num_warnings == 3:
              num_warnings = 0
              num_guesses -= 1
              print(f"You have {num_guesses} guesses left.")
              break
          # Guess input by player
          letter = input("Guess: ").lower()
          # Check if input is 1 letter
          if len(letter) < 1 or len(letter) > 1 or (not letter.isalpha()):
              print(f"{letter} is not a letter!")
              num_warnings += 1
          # Check if letter has been guessed
          elif letter in letters_guessed:
              print(f"{letter} has already been guessed.")
              num_warnings += 1
          # If the guess is valid
          else:
              num_warnings = 0
              letters_guessed.append(letter)
              break
        # Check if the letter is in the secret word
        if letter not in secret_word:
            print(f"{letter} is not in the word.")
            # If the incorrect guess is a vowel, remove 2 guesses
            if letter in ["a", "e", "i", "o", "u"]:
               num_guesses -= 2
            # If the incorrect guess is a consonant, remove 1 guess
            else:
              num_guesses -= 1
            # Print the guessed word so far
            print(get_guessed_word(secret_word, letters_guessed))
        # If it is, print the current guess
        else:
            print(f"{letter} is in {get_guessed_word(secret_word, letters_guessed)}")
            # Count up the number of unique letters
            unique_letters += 1
    
    # Print the correct answer
    if num_guesses > 0:
      print(f"The secret word is '{get_guessed_word(secret_word, letters_guessed)}'!")
      # Calculate the total score
      total_score = num_guesses * unique_letters
      print(f"Your total score for this game is: {total_score}")
    # Print game over if the player runs out of guesses
    else:
       print(f"Game over! You have run out of guesses. The secret word was {secret_word}.")



# When you've completed your hangman function, scroll down to the bottom
# of the file and uncomment the first two lines to test
#(hint: you might want to pick your own
# secret_word while you're doing your own testing)


# -----------------------------------



def match_with_gaps(my_word, other_word):
    '''
    my_word: string with _ characters, current guess of secret word
    other_word: string, regular English word
    returns: boolean, True if all the actual letters of my_word match the 
        corresponding letters of other_word, or the letter is the special symbol
        _ , and my_word and other_word are of the same length;
        False otherwise: 
    '''
    # Count the nunber of blank letters in the word guess
    num_blanks = 0
    # Replace all blanks with single characters
    my_word = my_word.replace(" ", "")
    for letter in my_word:
       if letter == "_":
          num_blanks += 1

    # If the length of the words are the same
    if len(my_word) != len(other_word):
       return False

    # Check if the letters in my_word line up with letters or "_"'s in other_word
    for i in range(len(my_word)):
       if (my_word[i] == other_word[i]) or (my_word[i] == "_"):
          pass
       else:
          return False
          
    for letter in my_word:
        other_word = other_word.replace(letter, "")
    # Return True or False
    return num_blanks == len(other_word)
          



def show_possible_matches(my_word):
    '''
    my_word: string with _ characters, current guess of secret word
    returns: nothing, but should print out every word in wordlist that matches my_word
             Keep in mind that in hangman when a letter is guessed, all the positions
             at which that letter occurs in the secret word are revealed.
             Therefore, the hidden letter(_ ) cannot be one of the letters in the word
             that has already been revealed.

    '''
    match_flag = False
    # For every word in the word list
    for word in wordlist:
       # Print if it matches the current guessed word with gaps
       if match_with_gaps(my_word, word):
          print(word, end=" ")
          # Flag that there is at least one match
          match_flag = True
    # Print no matches if no matches are found
    if not match_flag:
      print("No matches found.", end="")
    # New line
    print("")



def hangman_with_hints(secret_word):
    '''
    secret_word: string, the secret word to guess.
    
    Starts up an interactive game of Hangman.
    
    * At the start of the game, let the user know how many 
      letters the secret_word contains and how many guesses s/he starts with.
      
    * The user should start with 6 guesses
    
    * Before each round, you should display to the user how many guesses
      s/he has left and the letters that the user has not yet guessed.
    
    * Ask the user to supply one guess per round. Make sure to check that the user guesses a letter
      
    * The user should receive feedback immediately after each guess 
      about whether their guess appears in the computer's word.

    * After each guess, you should display to the user the 
      partially guessed word so far.
      
    * If the guess is the symbol *, print out all words in wordlist that
      matches the current guessed word. 
    
    Follows the other limitations detailed in the problem write-up.
    '''
    num_guesses = 6
    num_warnings = 0
    unique_letters = 0
    letters_guessed = []

    print("Welcome to the game Hangman!")
    word_length = len(secret_word)
    print(f"I am thinking of a word that is {word_length} letters long.")

    # While the word hasn't been guessed or the player still has guesses left
    while (not is_word_guessed(secret_word, letters_guessed)) and num_guesses > 0:
        print("----------------")
        print(f"You have {num_guesses} guesses left.")
        print(f"Available letters: {get_available_letters(letters_guessed)}")
        # Guess letter
        letter = ""
        # Warnings for invalid guesses
        while True:
          if 0 <num_warnings < 3:
              print(f"You have {num_warnings} warnings. 3 warnings and you will lose a guess.")
              print(f"Available letters: {get_available_letters(letters_guessed)}")
              # Print the guessed word so far
              print(get_guessed_word(secret_word, letters_guessed))
              print("----------------")
          elif num_warnings == 3:
              num_warnings = 0
              num_guesses -= 1
              print(f"You have {num_guesses} guesses left.")
              break
          # Guess input by player
          letter = input("Guess: ").lower()
          # print out hints
          if letter == "*":
             show_possible_matches(get_guessed_word(secret_word, letters_guessed))
             print("----------------")
             print(f"You have {num_guesses} guesses left.")
             print(f"Available letters: {get_available_letters(letters_guessed)}")
          # Check if input is 1 letter
          elif len(letter) < 1 or len(letter) > 1 or (not letter.isalpha()):
              print(f"{letter} is not a letter!")
              num_warnings += 1
          # Check if letter has been guessed
          elif letter in letters_guessed:
              print(f"{letter} has already been guessed.")
              num_warnings += 1
          # If the guess is valid
          else:
              num_warnings = 0
              letters_guessed.append(letter)
              break
        # Check if the letter is in the secret word
        if letter not in secret_word:
            print(f"{letter} is not in the word.")
            # If the incorrect guess is a vowel, remove 2 guesses
            if letter in ["a", "e", "i", "o", "u"]:
               num_guesses -= 2
            # If the incorrect guess is a consonant, remove 1 guess
            else:
              num_guesses -= 1
            # Print the guessed word so far
            print(get_guessed_word(secret_word, letters_guessed))
        # If it is, print the current guess
        else:
            print(f"{letter} is in {get_guessed_word(secret_word, letters_guessed)}")
            # Count up the number of unique letters
            unique_letters += 1
    
    # Print the correct answer
    if num_guesses > 0:
      print(f"The secret word is '{get_guessed_word(secret_word, letters_guessed)}'!")
      # Calculate the total score
      total_score = num_guesses * unique_letters
      print(f"Your total score for this game is: {total_score}")
    # Print game over if the player runs out of guesses
    else:
       print(f"Game over! You have run out of guesses. The secret word was {secret_word}.")



# When you've completed your hangman_with_hint function, comment the two similar
# lines above that were used to run the hangman function, and then uncomment
# these two lines and run this file to test!
# Hint: You might want to pick your own secret_word while you're testing.


if __name__ == "__main__":
    # pass

    # To test part 2, comment out the pass line above and
    # uncomment the following two lines.
    
    #secret_word = choose_word(wordlist)
    #hangman(secret_word)

###############
    
    # To test part 3 re-comment out the above lines and 
    # uncomment the following two lines. 
    
    secret_word = choose_word(wordlist)
    hangman_with_hints(secret_word)