import random


class Hat:
    
    houses = ["Gryffindor", "Hufflepuff", "Ravenclaw", "Slytherin"]

    # Class method
    @classmethod
    def sort(cls, name):
        print(name, "is in", random.choice(cls.houses))


Hat.sort("Harry")