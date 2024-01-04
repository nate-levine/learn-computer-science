import sys

# [1] refers to the second command line prompt
# The first prompt is the name of the file
if len(sys.argv) < 2:
    sys.exit("Too few arguments")

for arg in sys.argv[1:]:
    print("Hello, my name is", arg)