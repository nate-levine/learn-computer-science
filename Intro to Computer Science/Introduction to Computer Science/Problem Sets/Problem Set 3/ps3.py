# 6.0001 Problem Set 3
#
# The 6.0001 Word Game
# Created by: Kevin Luu <luuk> and Jenna Wiens <jwiens>
#
# Name          : Nate Levine
# Collaborators : <your collaborators>
# Time spent    : 2:30

import math
import random
import string

VOWELS = 'aeiou'
CONSONANTS = 'bcdfghjklmnpqrstvwxyz'
HAND_SIZE = 7

SCRABBLE_LETTER_VALUES = {
    'a': 1, 'b': 3, 'c': 3, 'd': 2, 'e': 1, 'f': 4, 'g': 2, 'h': 4, 'i': 1, 'j': 8, 'k': 5, 'l': 1, 'm': 3, 'n': 1, 'o': 1, 'p': 3, 'q': 10, 'r': 1, 's': 1, 't': 1, 'u': 1, 'v': 4, 'w': 4, 'x': 8, 'y': 4, 'z': 10, '*': 0
}

# -----------------------------------
# Helper code
# (you don't need to understand this helper code)

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
    # wordlist: list of strings
    wordlist = []
    for line in inFile:
        wordlist.append(line.strip().lower())
    print("  ", len(wordlist), "words loaded.")
    return wordlist

def get_frequency_dict(sequence):
    """
    Returns a dictionary where the keys are elements of the sequence
    and the values are integer counts, for the number of times that
    an element is repeated in the sequence.

    sequence: string or list
    return: dictionary
    """
    
    # freqs: dictionary (element_type -> int)
    freq = {}
    for x in sequence:
        freq[x] = freq.get(x,0) + 1
    return freq
	

# (end of helper code)
# -----------------------------------

#
# Problem #1: Scoring a word
#
def get_word_score(word, n):
    """
    Returns the score for a word. Assumes the word is a
    valid word.

    You may assume that the input word is always either a string of letters, 
    or the empty string "". You may not assume that the string will only contain 
    lowercase letters, so you will have to handle uppercase and mixed case strings 
    appropriately. 

	The score for a word is the product of two components:

	The first component is the sum of the points for letters in the word.
	The second component is the larger of:
            1, or
            7*wordlen - 3*(n-wordlen), where wordlen is the length of the word
            and n is the hand length when the word was played

	Letters are scored as in Scrabble; A is worth 1, B is
	worth 3, C is worth 3, D is worth 2, E is worth 1, and so on.

    word: string
    n: int >= 0
    returns: int >= 0
    """
    
    # First component: the sum of the points for letters in the word
    first_component = 0
    for letter in word:
        first_component += SCRABBLE_LETTER_VALUES[letter.lower()]
    # Second component: The greater of 1 or [(7 * word_length) - (3*(n - word_length))]
    word_length = len(word)
    second_component = (7 * word_length) - (3 * (n - word_length))
    if second_component < 1:
        second_component = 1
    # Return the product of the first and second component
    return first_component * second_component

#
# Make sure you understand how this function works and what it does!
#
def display_hand(hand):
    """
    Displays the letters currently in the hand.

    For example:
       display_hand({'a':1, 'x':2, 'l':3, 'e':1})
    Should print out something like:
       a x x l l l e
    The order of the letters is unimportant.

    hand: dictionary (string -> int)
    """
    
    print("Current hand: ", end="")
    # For each key (letter) in the dictionary
    for letter in hand.keys():
        # Print that key (letter) the amount of times equivalent to its value
        for j in range(hand[letter]):
             print(letter, end=' ')      # print all on the same line
    print()                              # print an empty line

#
# Make sure you understand how this function works and what it does!
# You will need to modify this for Problem #4.
#
def deal_hand(n):
    """
    Returns a random hand containing n lowercase letters.
    ceil(n/3) letters in the hand should be VOWELS (note,
    ceil(n/3) means the smallest integer not less than n/3).

    Hands are represented as dictionaries. The keys are
    letters and the values are the number of times the
    particular letter is repeated in that hand.

    n: int >= 0
    returns: dictionary (string -> int)
    """
    
    hand={}
    num_vowels = int(math.ceil(n / 3))
    # Deal vowels in hand from (0, num_vowels - 1)
    for i in range(num_vowels - 1):
        x = random.choice(VOWELS)
        # If the key (letter) exists, add one to the value
        # If the key (letter) does not exist yet, add the key (letter) with a value of 1
        hand[x] = hand.get(x, 0) + 1
    # Deal wildcards in hand from (num_vowels - 1, num_vowels)
    for i in range(num_vowels - 1, num_vowels):
        x = "*"
        hand[x] = hand.get(x, 0) + 1
    # Deal consonants in hand from (num_vowels, n)
    for i in range(num_vowels, n):    
        x = random.choice(CONSONANTS)
        hand[x] = hand.get(x, 0) + 1
    
    return hand

#
# Problem #2: Update a hand by removing letters
#
def update_hand(hand, word):
    """
    Does NOT assume that hand contains every letter in word at least as
    many times as the letter appears in word. Letters in word that don't
    appear in hand should be ignored. Letters that appear in word more times
    than in hand should never result in a negative count; instead, set the
    count in the returned hand to 0 (or remove the letter from the
    dictionary, depending on how your code is structured). 

    Updates the hand: uses up the letters in the given word
    and returns the new hand, without those letters in it.

    Has no side effects: does not modify hand.

    word: string
    hand: dictionary (string -> int)    
    returns: dictionary (string -> int)
    """
    # Make a new copy of the hand
    new_hand = hand.copy()
    for letter in word:
        # Make the letter lowercase if it isnt already
        letter = letter.lower()
        # If there is only one of the letter left, remove the key (letter) from the hand
        if new_hand.get(letter, 0) == 0:
            new_hand[letter] = 0
        # If there is more than one of the letter left, remove one of the letter
        else:
            new_hand[letter] = new_hand.get(letter, 0) - 1
    # Return the updated hand
    return new_hand

#
# Problem #3: Test word validity
#
def is_valid_word(word, hand, word_list):
    """
    Returns True if word is in the word_list and is entirely
    composed of letters in the hand. Otherwise, returns False.
    Does not mutate hand or word_list.
   
    word: string
    hand: dictionary (string -> int)
    word_list: list of lowercase strings
    returns: boolean
    """
    # Check if the word is in the word list
    in_word_list = False
    # Covert to all lower case
    word = word.lower()
    # Check for wildcard replacing vowels
    if word.replace("*", "a") in word_list:
        in_word_list = True
    elif word.replace("*", "e") in word_list:
        in_word_list = True
    elif word.replace("*", "i") in word_list:
        in_word_list = True
    elif word.replace("*", "o") in word_list:
        in_word_list = True
    elif word.replace("*", "u") in word_list:
        in_word_list = True
        
    # Check if the word is entirely composed of letters in the hand
    word_in_hand = True
    # Count how many letters are in the starting hand
    num_in_starting_hand = 0
    for letter in hand:
        num_in_starting_hand += hand[letter]
    # Update hand by playing the new word
    new_hand = update_hand(hand, word)
    # Count how many letters are in the new hand
    num_in_new_hand = 0
    for letter in new_hand:
        num_in_new_hand += new_hand[letter]
    # If the difference in the number of letters in the hand before and after is less than
    # The length of the word, that means the starting hand didn't have enough letters to
    # play that word. Therefore that word is not valid
    if num_in_starting_hand - num_in_new_hand < len(word):
        word_in_hand = False
    # Return True if both conditions are met
    return in_word_list and word_in_hand
        
#
# Problem #5: Playing a hand
#
def calculate_handlen(hand):
    """ 
    Returns the length (number of letters) in the current hand.
    
    hand: dictionary (string-> int)
    returns: integer
    """
    # Count how many letters are in the hand
    num_in_hand = 0
    for letter in hand:
        num_in_hand += hand[letter]
    return num_in_hand


def play_hand(hand, word_list, replay_flag):

    """
    Allows the user to play the given hand, as follows:

    * The hand is displayed.
    
    * The user may input a word.

    * When any word is entered (valid or invalid), it uses up letters
      from the hand.

    * An invalid word is rejected, and a message is displayed asking
      the user to choose another word.

    * After every valid word: the score for that word is displayed,
      the remaining letters in the hand are displayed, and the user
      is asked to input another word.

    * The sum of the word scores is displayed when the hand finishes.

    * The hand finishes when there are no more unused letters.
      The user can also finish playing the hand by inputing two 
      exclamation points (the string '!!') instead of a word.

      hand: dictionary (string -> int)
      word_list: list of lowercase strings
      returns: the total score for the hand
      
    """
    
    # Keep track of the total score
    total_score = 0
    # Substitution flag
    substitute_flag = False
    # As long as there are still letters left in the hand:
    while calculate_handlen(hand) > 0:
        # Display the hand
        display_hand(hand)
        # Ask if the user would like to substitute a letter (not on replayed hands)
        if not replay_flag and not substitute_flag:
            substitute_letter = input('Enter "yes" if you would like to substitute a letter: ')
            # Substitute a letter
            if substitute_letter.lower() == "yes":
                letter = input("Which letter would you like to replace: ")
                hand = substitute_hand(hand, letter)
                # Display the hand with the replaced letter
                display_hand(hand)
        # Flag that the chance for a substitution has passed
        substitute_flag = True
        # Ask user for input
        word = input('Enter word, or "!!" to indicate that you are finished: ')
        # If the input is two exclamation points:
        if word == "!!":
            # End the game (break out of the loop)
            break
            
        # Otherwise (the input is not two exclamation points):
        else:
            # If the word is valid:
            if is_valid_word(word, hand, word_list):
                # Tell the user how many points the word earned,
                # and the updated total score
                word_score = get_word_score(word, calculate_handlen(hand))
                # Update the total score
                total_score += word_score
                print(f'"{word}" earned {word_score} points. Total score: {total_score} points')
            # Otherwise (the word is not valid):
            else:
                # Reject invalid word (print a message)
                print(f'"{word}" is not a valid word. Please choose another word.')
                
            # update the user's hand by removing the letters of their inputted word
            hand = update_hand(hand, word)
        print() # Blank line

    # Game is over (user entered '!!' or ran out of letters),
    # so tell user tthey ran out of letters
    print(f"Ran out of letters.")
    # so tell user the total score
    print(f"Total score for this hand: {total_score} points")
    print("----------------") # Hand separater
    # Return the total score as result of function
    return total_score


#
# Problem #6: Playing a game
# 


#
# procedure you will use to substitute a letter in a hand
#

def substitute_hand(hand, letter):
    """ 
    Allow the user to replace all copies of one letter in the hand (chosen by user)
    with a new letter chosen from the VOWELS and CONSONANTS at random. The new letter
    should be different from user's choice, and should not be any of the letters
    already in the hand.

    If user provide a letter not in the hand, the hand should be the same.

    Has no side effects: does not mutate hand.

    For example:
        substitute_hand({'h':1, 'e':1, 'l':2, 'o':1}, 'l')
    might return:
        {'h':1, 'e':1, 'o':1, 'x':2} -> if the new letter is 'x'
    The new letter should not be 'h', 'e', 'l', or 'o' since those letters were
    already in the hand.
    
    hand: dictionary (string -> int)
    letter: string
    returns: dictionary (string -> int)
    """
    # if the letter is in the user's hand
    if letter in hand:
        # Take the alphabet
        alphabet = CONSONANTS + VOWELS
        # And remove all the letters that are currently in the user's hand
        for key in hand.keys():
            alphabet.replace(key, "")
        # Pick a replacement letter
        replacement = random.choice(alphabet)
        # Create the replacement letter with the same value (amount)
        hand[replacement] = hand[letter]
        # Delete the replaced letter
        del(hand[letter])
        # Return the new hand
        return hand
    # if the letter is not in the user's hand
    else:
        # Return the old hand
        return hand
       
    
def play_game(word_list):
    """
    Allow the user to play a series of hands

    * Asks the user to input a total number of hands

    * Accumulates the score for each hand into a total score for the 
      entire series
 
    * For each hand, before playing, ask the user if they want to substitute
      one letter for another. If the user inputs 'yes', prompt them for their
      desired letter. This can only be done once during the game. Once the
      substitue option is used, the user should not be asked if they want to
      substitute letters in the future.

    * For each hand, ask the user if they would like to replay the hand.
      If the user inputs 'yes', they will replay the hand and keep 
      the better of the two scores for that hand.  This can only be done once 
      during the game. Once the replay option is used, the user should not
      be asked if they want to replay future hands. Replaying the hand does
      not count as one of the total number of hands the user initially
      wanted to play.

            * Note: if you replay a hand, you do not get the option to substitute
                    a letter - you must play whatever hand you just had.
      
    * Returns the total score for the series of hands

    word_list: list of lowercase strings
    """
    total_score = 0
    num_hands = 0
    # Ask the user how many hands they want
    while True:
        # Make sure the number of hands is an integer
        try:
            num_hands = int(input("Enter a total number of hands: "))
        except:
            pass
        else:
            break
    print("----------------") # Hand separater
    # Start the game
    while num_hands > 0:
        # Deal a hand
        hand = deal_hand(HAND_SIZE)
        # Accumulate the score for each hand in a total_score variable
        hand_score_original = play_hand(hand, word_list, False)
        # Ask the user if they would like to replay the hand
        replay_hand = input('Enter "yes" if you would like to replay the hand: ')
        hand_score_replay = 0
        # Replay the hand if "yes" is typed
        if replay_hand.lower() == "yes":
            hand_score_replay = play_hand(hand, word_list, True)
        # Add the larger score to the total score
        total_score += max(hand_score_original, hand_score_replay)
        # Decrease the number of hands by 1
        num_hands -= 1
    # Print final score
    print() # Blank line
    print(f"Total score over all hands: {total_score}")
    print() # Blank line

#
# Build data structures used for entire session and play game
# Do not remove the "if __name__ == '__main__':" line - this code is executed
# when the program is run directly, instead of through an import statement
#
if __name__ == '__main__':
    word_list = load_words()
    play_game(word_list)