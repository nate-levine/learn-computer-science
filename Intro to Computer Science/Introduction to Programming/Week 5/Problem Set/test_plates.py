from plates import is_valid


def test_starts_with_numerals():
    assert is_valid("01TEST") == False
    assert is_valid("50CS") == False
    assert is_valid("CS50") == True


def test_length():
    assert is_valid("ABCD") == True
    assert is_valid("ABCDEFG") == False
    assert is_valid("PU") == True


def test_alphanumerics():
    assert is_valid("ALPHA") == True
    assert is_valid("NUMBER") == True
    assert is_valid("ME&YOU") == False


def test_no_letters_after_numbers():
    assert is_valid("GO2BED") == False
    assert is_valid("LUVU6") == True
    assert is_valid("MET3OR") == False