class Jar:
    def __init__(self, capacity=12):
        try:
            capacity = int(capacity)
        except ValueError:
            raise ValueError("Capacity must be an integer")
        else:
            if capacity >= 0:
                self.capacity = capacity
            else:
                raise ValueError("Capacity must be non-negative")
        self.size = 0
        
    def __str__(self):
        return "🍪" * self.size

    def deposit(self, n):
        amount = self.size + n
        if amount > self.capacity:
            raise ValueError("Capacity exceeded")
        else:
            self.size = amount

    def withdraw(self, n):
        amount = self.size - n
        if amount < 0:
            raise ValueError("Not enough cookies")
        else:
            self.size = amount

    @property
    def capacity(self):
        return self._capacity
    @capacity.setter
    def capacity(self, n):
        self._capacity = n

    @property
    def size(self):
        return self._size
    @size.setter
    def size(self, n):
        self._size = n