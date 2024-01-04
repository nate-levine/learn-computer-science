import fuel


def test_convert():
    assert fuel.convert("1/2") == 50
    assert fuel.convert("3/3") == 100
    assert fuel.convert("2/1") == ValueError
    assert fuel.convert("0/1") == 0
    assert fuel.convert("1/0") == ZeroDivisionError
    assert fuel.convert("-1/1") == ValueError


def test_gauge():
    assert fuel.gauge(0) == "E"
    assert fuel.gauge(1) == "E"
    assert fuel.gauge(25) == "25%"
    assert fuel.gauge(50) == "50%"
    assert fuel.gauge(75) == "75%"
    assert fuel.gauge(99) == "F"
    assert fuel.gauge(100) == "F"