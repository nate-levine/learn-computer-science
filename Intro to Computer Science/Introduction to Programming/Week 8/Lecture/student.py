class Student:
    # initializer method
    def __init__(self, name, house, patronus):
        self.name = name
        self.house = house
        self.patronus = patronus

    # string method
    def __str__(self):
        return f"{self.name} from {self.house}"
    
    # Getter
    @property
    def name(self):
        return self._name
    
    # Setter
    @name.setter
    def name(self, name):
        if not name:
            raise ValueError("Missing name")
        self._name = name
    
    # Getter
    @property
    def house(self):
        return self._house
    
    # Setter
    @house.setter
    def house(self, house):
        if house not in ["Gryffindor", "Hufflepuff", "Ravenclaw", "Slytherin"]:
            raise ValueError("Invalid house")
        self._house = house
        
    # Getter
    @property
    def patronus(self):
        return self._patronus
    
    # Setter
    @patronus.setter
    def patronus(self, name):
        self._patronus = name
    
    # Instance method
    def charm(self):
        match self.patronus:
            case "Stag":
                return "🦌"
            case "Otter":
                return "🦦"
            case "Jack Russell Terrier":
                return "🐕"
            case _:
                return "🪄"

    # Class method
    @classmethod     
    def get(cls):
        name = input("Name: ")
        house = input("House: ")
        patronus = input("Patrnous: ")
        return cls(name, house, patronus)


def main():
    student = Student.get()
    print(f"Expecto Patronum! {student.charm()}")


if __name__ == "__main__":
    main()