from bank import value


def test_hello():
    assert value("Hello!") == "$0"
    assert value("hello there") == "$0"


def test_h():
    assert value("How's it going?") == "$20"
    assert value("Howdy!") == "$20"
    assert value("Holy shit what are you doing here?") == "$20"


def test_other():
    assert value("What's up?") == "$100"
    assert value("yo yo yo!") == "$100"
    assert value("") == "$100"