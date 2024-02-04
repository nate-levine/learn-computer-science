# Problem Set 4C
# Name: Nate Levine
# Collaborators:
# Time Spent: 0:45

import string
from ps4a import get_permutations

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


### END HELPER CODE ###

WORDLIST_FILENAME = 'words.txt'

# you may find these constants helpful
VOWELS_LOWER = 'aeiou'
VOWELS_UPPER = 'AEIOU'
CONSONANTS_LOWER = 'bcdfghjklmnpqrstvwxyz'
CONSONANTS_UPPER = 'BCDFGHJKLMNPQRSTVWXYZ'

class SubMessage(object):
    def __init__(self, text):
        '''
        Initializes a SubMessage object
                
        text (string): the message's text

        A SubMessage object has two attributes:
            self.message_text (string, determined by input text)
            self.valid_words (list, determined using helper function load_words)
        '''
        self.message_text = text
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
                
    def build_transpose_dict(self, vowels_permutation):
        '''
        vowels_permutation (string): a string containing a permutation of vowels (a, e, i, o, u)
        
        Creates a dictionary that can be used to apply a cipher to a letter.
        The dictionary maps every uppercase and lowercase letter to an
        uppercase and lowercase letter, respectively. Vowels are shuffled 
        according to vowels_permutation. The first letter in vowels_permutation 
        corresponds to a, the second to e, and so on in the order a, e, i, o, u.
        The consonants remain the same. The dictionary should have 52 
        keys of all the uppercase letters and all the lowercase letters.

        Example: When input "eaiuo":
        Mapping is a->e, e->a, i->i, o->u, u->o
        and "Hello World!" maps to "Hallu Wurld!"

        Returns: a dictionary mapping a letter (string) to 
                 another letter (string). 
        '''
        # Create an empty transpose dictionary
        transpose_dict = {}
        # Get alphabet string of both upper- and lower-case letters
        alphabet = string.ascii_uppercase + string.ascii_lowercase
        # Keep track of vowel permutations added to the dictionary
        # The vowel transposes will always be added in the order of:
        # AEIOUaeiou, so the first 5 will be uppercase and the next
        # 5 will be lowercase.
        vowels_added = 0
        # For each letter in the alphabet
        for letter in alphabet:
            # If the letter is a vowel
            if letter.lower() in ["a", "e", "i", "o", "u"]:
                # If the vowel is uppercase
                if vowels_added < 5:
                    # From vowels_added (0, 4), make uppercase
                    transpose_dict[letter] = vowels_permutation[vowels_added].upper()
                # If the vowel is lowercase
                else:
                    # From vowels_added (5, 9), keep lowercase
                    transpose_dict[letter] = vowels_permutation[vowels_added - 5]
                # Update the number of vowels added to the transpose dictionary
                vowels_added += 1
            # If the letter is a consonant
            else:
                # Assign the same letter as the transpose
                transpose_dict[letter] = letter
        return transpose_dict

    
    def apply_transpose(self, transpose_dict):
        '''
        transpose_dict (dict): a transpose dictionary
        
        Returns: an encrypted version of the message text, based 
        on the dictionary
        '''
        # Create an empty transpose of the message
        transposed_message_text = ""
        # For each character in the current message
        for char in self.message_text:
            # If the character is a letter
            if char in string.ascii_uppercase or char in string.ascii_lowercase:
                # Add each transposed letter
                transposed_message_text += transpose_dict[char]
            # If the character is not a letter
            else:
                # Add the character to the transposed message
                transposed_message_text += char
        # Return the transposed message
        return transposed_message_text
            
        
class EncryptedSubMessage(SubMessage):
    def __init__(self, text):
        '''
        Initializes an EncryptedSubMessage object

        text (string): the encrypted message text

        An EncryptedSubMessage object inherits from SubMessage and has two attributes:
            self.message_text (string, determined by input text)
            self.valid_words (list, determined using helper function load_words)
        '''
        SubMessage.__init__(self, text)

    def decrypt_message(self):
        '''
        Attempt to decrypt the encrypted message 
        
        Idea is to go through each permutation of the vowels and test it
        on the encrypted message. For each permutation, check how many
        words in the decrypted text are valid English words, and return
        the decrypted message with the most English words.
        
        If no good permutations are found (i.e. no permutations result in 
        at least 1 valid word), return the original string. If there are
        multiple permutations that yield the maximum number of words, return any
        one of them.

        Returns: the best decrypted message    
        
        Hint: use your function from Part 4A
        '''
        # Get a list of all the permutations of vowels
        permutation_list = get_permutations("aeiou")
        # Keep track of the messages and their permutations
        # The encrypted message is the default message
        message = self.message_text
        # Keep track of the maximum number of valid words so far
        max_valid_words = 0
        # For each permutation of vowels
        for permutation in permutation_list:
            # Get the transpose dictionary for the permutaion
            transpose_dict = self.build_transpose_dict(permutation)
            # Transpose the encrypted message
            transposed_message = self.apply_transpose(transpose_dict)
            # Split the text into a list of words
            words = transposed_message.split(" ")
            # Reset the number of valid words
            valid_words = 0
            for word in words:
                # If the word is valid, or is a letter
                if is_word(self.valid_words, word) or len(word) == 1:
                    # Add 1 to the number of valid words in the messafe
                    valid_words += 1
            # If the record for the number of valid words is surpassed
            if valid_words >= max_valid_words and valid_words > 0:
                # Set the new record of the maximum number of valid words
                max_valid_words = valid_words
                # Set the new most likely messag
                message = transposed_message
        # Return the transpose with the most valid words
        return message

if __name__ == '__main__':

    # Example test case
    message = SubMessage("Hello World!")
    permutation = "eaiuo"
    enc_dict = message.build_transpose_dict(permutation)
    print("Original message:", message.get_message_text(), "Permutation:", permutation)
    print("Expected encryption:", "Hallu Wurld!")
    print("Actual encryption:", message.apply_transpose(enc_dict))
    enc_message = EncryptedSubMessage(message.apply_transpose(enc_dict))
    print("Decrypted message:", enc_message.decrypt_message())
     
    #TODO: WRITE YOUR TEST CASES HERE
    # The quick brown fox jumped over the lazy dog
    message = SubMessage("The quick brown fox jumped over the lazy dog")
    permutation = "oueai"
    enc_dict = message.build_transpose_dict(permutation)
    print("Original message:", message.get_message_text(), "Permutation:", permutation)
    print("Expected encryption:", "The qieck brown fax jimpud avur the lozy dag")
    print("Actual encryption:", message.apply_transpose(enc_dict))
    enc_message = EncryptedSubMessage(message.apply_transpose(enc_dict))
    print("Decrypted message:", enc_message.decrypt_message())
    # I before E, except after C
    message = SubMessage("I before E, except after C")
    permutation = "uoiea"
    enc_dict = message.build_transpose_dict(permutation)
    print("Original message:", message.get_message_text(), "Permutation:", permutation)
    print("Expected encryption:", "I bofero O, oxcopt uftor C")
    print("Actual encryption:", message.apply_transpose(enc_dict))
    enc_message = EncryptedSubMessage(message.apply_transpose(enc_dict))
    print("Decrypted message:", enc_message.decrypt_message())