from twttr import shorten

def test_shorten():
    assert shorten("Twitter") == "Twttr"
    assert shorten("Nate Levine") == "Nt Lvn"
    assert shorten("AEIOU") == ""
    assert shorten("123") == "123"