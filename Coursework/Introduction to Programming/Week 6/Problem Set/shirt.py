import sys
from os.path import splitext
from PIL import Image, ImageOps


def main():
    arguments_are_valid = check_arguments()
    if not arguments_are_valid:
        sys.exit()
    
    shirt = Image.open("shirt.png")
    with Image.open(sys.argv[1]) as image:
        cropped = ImageOps.fit(image, shirt.size)
        cropped.paste(shirt, mask=shirt)
        cropped.save(sys.argv[2])


def check_arguments():
    before_root, before_ext = splitext(sys.argv[1])
    after_root, after_ext = splitext(sys.argv[2])
    before_ext = before_ext.lower()
    after_ext = after_ext.lower()
    # More or less than 3 command-line arguments
    if len(sys.argv) < 3 or len(sys.argv) > 3:
        print("test1")
        return False
    # arguments do not end in .jpg, .jpeg, or .png case-insensitively
    elif before_ext != ".jpg" and before_ext != ".jpeg" and before_ext != ".png":
        return False
    elif after_ext != ".jpg" and after_ext != ".jpeg" and after_ext != ".png":
        return False
    # Input does not have the same extension as the output
    elif before_ext != after_ext:
        return False
    # The input does not exist
    try:
        Image.open(sys.argv[1])
    except FileNotFoundError:
        return False
    # If every condition is met
    return True


if __name__ == "__main__":
    main()