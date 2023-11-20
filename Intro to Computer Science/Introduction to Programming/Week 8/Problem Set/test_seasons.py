from seasons import get_birth_date


def test_get_birth_date():
    assert get_birth_date("2003-02-07") == {'day': 7, 'month': 2, 'year': 2003}
    assert get_birth_date("2000-05-07") == {'day': 7, 'month': 5, 'year': 2000}
    assert get_birth_date("bird-01-01") == False
    assert get_birth_date("2100-12-cat") == False
    assert get_birth_date("50000-12-10") == False
    assert get_birth_date("5000-1-3") == False