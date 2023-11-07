def main():
    print_rect(9, 5)

def print_rect(width, height):
    # For each row in square
    for i in range(height):
        # For each brick in row
        for j in range(width):
            # Print brick
            print("#", end="")
        # New print line
        print()

main()