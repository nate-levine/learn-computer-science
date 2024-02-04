from hello import hello


def test_default():
    hello() == "hello, world"

    
def test_argument():
    hello("David") == "hello, David"