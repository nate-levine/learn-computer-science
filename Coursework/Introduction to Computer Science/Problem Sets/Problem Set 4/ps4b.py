# Problem Set 4B
# Name: Nate Levine
# Collaborators:
# Time Spent: 1:45

import string

### HELPER CODE ###
def load_words(file_name):
    '''
    file_name (string): the name of the file containing 
    the list of words to load    
    
    Returns: a list of valid words. Words are strings of lowercase letters.
    
    Depending on the size of the word list, this function may
    take a while to finish.
    '''
    print("Loading word list from file...")
    # inFile: file
    inFile = open(file_name, 'r')
    # wordlist: list of strings
    wordlist = []
    for line in inFile:
        wordlist.extend([word.lower() for word in line.split(' ')])
    print("  ", len(wordlist), "words loaded.")
    return wordlist

def is_word(word_list, word):
    '''
    Determines if word is a valid word, ignoring
    capitalization and punctuation

    word_list (list): list of words in the dictionary.
    word (string): a possible word.
    
    Returns: True if word is in word_list, False otherwise

    Example:
    >>> is_word(word_list, 'bat') returns
    True
    >>> is_word(word_list, 'asdf') returns
    False
    '''
    word = word.lower()
    word = word.strip(r" !@#$%^&*()-_+={}[]|\:;'<>?,./\"")
    return word in word_list

def get_story_string():
    """
    Returns: a story in encrypted text.
    """
    f = open("story.txt", "r")
    story = str(f.read())
    f.close()
    return story

### END HELPER CODE ###

WORDLIST_FILENAME = 'words.txt'

class Message(object):
    def __init__(self, text):
        '''
        Initializes a Message object
                
        text (string): the message's text

        a Message object has two attributes:
            self.message_text (string, determined by input text)
            self.valid_words (list, determined using helper function load_words)
        '''
        self.message_text = text
        # Load words from "words.txt"
        self.valid_words = load_words("words.txt")

    def get_message_text(self):
        '''
        Used to safely access self.message_text outside of the class
        
        Returns: self.message_text
        '''
        return self.message_text

    def get_valid_words(self):
        '''
        Used to safely access a copy of self.valid_words outside of the class.
        This helps you avoid accidentally mutating class attributes.
        
        Returns: a COPY of self.valid_words
        '''
        return self.valid_words.copy()

    def build_shift_dict(self, shift):
        '''
        Creates a dictionary that can be used to apply a cipher to a letter.
        The dictionary maps every uppercase and lowercase letter to a
        character shifted down the alphabet by the input shift. The dictionary
        should have 52 keys of all the uppercase letters and all the lowercase
        letters only.        
        
        shift (integer): the amount by which to shift every letter of the 
        alphabet. 0 <= shift < 26

        Returns: a dictionary mapping a letter (string) to 
                 another letter (string). 
        '''
        # Create an empty dictionary
        shift_dict = {}
        # Enumerate over every uppercase letter,
        # while keeping track of the index
        for i, letter in enumerate(string.ascii_uppercase):
            # If the shift is out of range of the alphabet length,
            # and loops back to the beginning of the alphabet
            if i + shift >= len(string.ascii_uppercase):
                shifted_letter = string.ascii_uppercase[-26 + i + shift]
            # If the shift is in range of the alphabet length
            else:
                shifted_letter = string.ascii_uppercase[i + shift]
            # Add a new key (letter),
            # and a new value (shifted_letter) to the dict
            shift_dict[letter] = shifted_letter
        # Enumerate over every lowercase letter,
        # while keeping track of the index
        for i, letter in enumerate(string.ascii_lowercase):
            # If the shift is out of range of the alphabet length,
            # and loops back to the beginning of the alphabet
            if i + shift >= len(string.ascii_lowercase):
                shifted_letter = string.ascii_lowercase[-26 + i + shift]
            # If the shift is in range of the alphabet length
            else:
                shifted_letter = string.ascii_lowercase[i + shift]
            # Add a new key (letter),
            # and a new value (shifted_letter) to the dict
            shift_dict[letter] = shifted_letter
        # Return the shift dictionary
        return shift_dict

    def apply_shift(self, shift):
        '''
        Applies the Caesar Cipher to self.message_text with the input shift.
        Creates a new string that is self.message_text shifted down the
        alphabet by some number of characters determined by the input shift        
        
        shift (integer): the shift with which to encrypt the message.
        0 <= shift < 26

        Returns: the message text (string) in which every character is shifted
             down the alphabet by the input shift
        '''
        # Create a shift dictionary
        shift_dict = self.build_shift_dict(shift)
        # Create an empty string
        shifted_message_text = ""
        # For each charcter in self.message_text
        for char in self.message_text:
            # If the character is a letter
            if char in string.ascii_uppercase or char in string.ascii_lowercase:
                # Add the shifted character to the shifted message,
                # based on the shift dictionary
                shifted_message_text += shift_dict[char]
            # If the character is not a letter
            else:
                # Add the character to the shifted message
                shifted_message_text += char
        # Return the shifted message
        return shifted_message_text

class PlaintextMessage(Message):
    def __init__(self, text, shift):
        '''
        Initializes a PlaintextMessage object        
        
        text (string): the message's text
        shift (integer): the shift associated with this message

        A PlaintextMessage object inherits from Message and has five attributes:
            self.message_text (string, determined by input text)
            self.valid_words (list, determined using helper function load_words)
            self.shift (integer, determined by input shift)
            self.encryption_dict (dictionary, built using shift)
            self.message_text_encrypted (string, created using shift)

        '''
        Message.__init__(self, text)
        self.shift = shift
        self.encryption_dict = self.build_shift_dict(shift)
        self.message_text_encrypted = self.apply_shift(shift)


    def get_shift(self):
        '''
        Used to safely access self.shift outside of the class
        
        Returns: self.shift
        '''
        return self.shift

    def get_encryption_dict(self):
        '''
        Used to safely access a copy self.encryption_dict outside of the class
        
        Returns: a COPY of self.encryption_dict
        '''
        return self.encryption_dict.copy()

    def get_message_text_encrypted(self):
        '''
        Used to safely access self.message_text_encrypted outside of the class
        
        Returns: self.message_text_encrypted
        '''
        return self.message_text_encrypted

    def change_shift(self, shift):
        '''
        Changes self.shift of the PlaintextMessage and updates other 
        attributes determined by shift.        
        
        shift (integer): the new shift that should be associated with this message.
        0 <= shift < 26

        Returns: nothing
        '''
        # Apply a shift to the current shift
        self.shift += shift
        # Update other attributes determined by shift
        self.encryption_dict = self.build_shift_dict(self.shift)
        self.message_text_encrypted = self.apply_shift(self.shift)


class CiphertextMessage(Message):
    def __init__(self, text):
        '''
        Initializes a CiphertextMessage object
                
        text (string): the message's text

        a CiphertextMessage object has two attributes:
            self.message_text (string, determined by input text)
            self.valid_words (list, determined using helper function load_words)
        '''
        Message.__init__(self, text)

    def decrypt_message(self):
        '''
        Decrypt self.message_text by trying every possible shift value
        and find the "best" one. We will define "best" as the shift that
        creates the maximum number of real words when we use apply_shift(shift)
        on the message text. If s is the original shift value used to encrypt
        the message, then we would expect 26 - s to be the best shift value 
        for decrypting it.

        Note: if multiple shifts are equally good such that they all create 
        the maximum number of valid words, you may choose any of those shifts 
        (and their corresponding decrypted messages) to return

        Returns: a tuple of the best shift value used to decrypt the message
        and the decrypted message text using that shift value
        '''
        # Keep track of the messages and thier shift
        (shift, message) = (0, "")
        # Keep track of the maximum number of valid words so far
        max_valid_words = 0
        # For each letter in the alphabet
        for i in range(len(string.ascii_lowercase)):
            shifted_message = self.apply_shift(i)
            # Split the text into a list of words
            words = shifted_message.split(" ")
            # Reset the number of valid words
            valid_words = 0
            for word in words:
                # If the word is valid
                if is_word(self.valid_words, word):
                    # Add 1 to the number of valid words in the message
                    valid_words += 1
            # If the record for the number of valid words is surpassed
            if valid_words >= max_valid_words:
                # Set the new record of the maximum number of valid words
                max_valid_words = valid_words
                # Set the new most likely message
                (shift, message) = (i, shifted_message)
        # Return a tuple (shift, message)
        return (shift, message)

if __name__ == '__main__':

#    #Example test case (PlaintextMessage)
#     plaintext = PlaintextMessage('hello', 2)
#     print('Expected Output: jgnnq')
#     print('Actual Output:', plaintext.get_message_text_encrypted())
#
#    #Example test case (CiphertextMessage)
#     ciphertext = CiphertextMessage('jgnnq')
#     print('Expected Output:', (24, 'hello'))
#     print('Actual Output:', ciphertext.decrypt_message())

#     #TODO: WRITE YOUR TEST CASES HERE
    # PlaintextMessage
    plaintext = PlaintextMessage('hello', 2)
    plaintext.change_shift(2)
    print('Expected Output: lipps')
    print('Actual Output:', plaintext.get_message_text_encrypted())
    plaintext.change_shift(-5)
    print('Expected Output: gdkkn')
    print('Actual Output:', plaintext.get_message_text_encrypted())
    plaintext.change_shift(0)
    print('Expected Output: gdkkn')
    print('Actual Output:', plaintext.get_message_text_encrypted())
    # CiphertextMessage
    ciphertext = CiphertextMessage('jgnnq')
    print('Expected Output:', (24, 'hello'))
    print('Actual Output:', ciphertext.decrypt_message())
    ciphertext = CiphertextMessage('gdkkn')
    print('Expected Output:', (1, 'hello'))
    print('Actual Output:', ciphertext.decrypt_message())

    #TODO: best shift value and unencrypted story 
    cipher_story = CiphertextMessage(get_story_string())
    print(cipher_story.decrypt_message())