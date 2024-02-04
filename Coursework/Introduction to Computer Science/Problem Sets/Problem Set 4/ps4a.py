# Problem Set 4A
# Name: Nate Levine
# Collaborators:
# Time Spent: 1:00

def get_permutations(sequence):
    '''
    Enumerate all permutations of a given string

    sequence (string): an arbitrary string to permute. Assume that it is a
    non-empty string.  

    You MUST use recursion for this part. Non-recursive solutions will not be
    accepted.

    Returns: a list of all permutations of sequence

    Example:
    >>> get_permutations('abc')
    ['abc', 'acb', 'bac', 'bca', 'cab', 'cba']

    Note: depending on your implementation, you may return the permutations in
    a different order than what is listed here.
    '''
    # If the sequence is less than or equal to 1, there is only one permutation
    if len(sequence) <= 1:
        return sequence
    else:
        # Create a list of permutations ffrom the lower recursion level
        sub_permutations = get_permutations(sequence[1:])
        # Get the first letter of the sequence
        first_letter = sequence[0]
        # For each permuation,
        # inset the first letter into every possible location
        # and add it to the permuations for this recursion level
        permutations = []
        for sub_permutation in sub_permutations:
            # For every spot in the permuation
            for i in range(len(sequence)):
                # Insert the first level into the "i"th spot in the permutation
                if i == 0:
                    permutations.append(first_letter + sub_permutation)
                elif i == len(sequence) - 1:
                    permutations.append(sub_permutation + first_letter)
                else:
                    permutations.append(sub_permutation[:i] + first_letter + sub_permutation[i:])
        # Return all the permutaitons for this level
        return permutations



if __name__ == '__main__':
   #EXAMPLE
   example_input = 'abc'
   print('Input:', example_input)
   print('Expected Output:', ['abc', 'acb', 'bac', 'bca', 'cab', 'cba'])
   print('Actual Output:', (get_permutations(example_input)))
    
#    # Put three example test cases here (for your sanity, limit your inputs
#    to be three characters or fewer as you will have n! permutations for a 
#    sequence of length n)
   assert sorted(get_permutations("cat")) == ["act", "atc", "cat", "cta", "tac", "tca"]
   assert sorted(get_permutations("xyz")) == ["xyz", "xzy", "yxz", "yzx", "zxy", "zyx"]
   assert sorted(get_permutations("dog")) == ["dgo", "dog", "gdo", "god", "odg", "ogd"]

