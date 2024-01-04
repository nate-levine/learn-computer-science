from jar import Jar


def test_init():
    jar = Jar()
    assert jar.capacity == 12
    jar = Jar(0)
    assert jar.capacity == 0
    jar = Jar(1000)
    assert jar.capacity == 1000


def test_str():
    jar = Jar()
    assert str(jar) == ""
    jar.deposit(1)
    assert str(jar) == "🍪"
    jar.deposit(11)
    assert str(jar) == "🍪🍪🍪🍪🍪🍪🍪🍪🍪🍪🍪🍪"


def test_deposit():
    jar = Jar()
    assert jar.size == 0
    jar.deposit(1)
    assert jar.size == 1
    jar.deposit(5)
    assert jar.size == 6


def test_withdraw():
    jar = Jar(20)
    jar.deposit(10)
    assert jar.size == 10
    jar.withdraw(1)
    assert jar.size == 9
    jar.withdraw(4)
    assert jar.size == 5