// Create a new class
public class Dog {

    // Create a class variable with the keyword static
    // This class variable changes for all instance objects of the class
    protected static int count = 0;
    
    // private attributes (instance variables)
    private String name;
    private int age;
    
    // Constructor
    public Dog(String name, int age) {
        this.name = name;
        this.age = age;
        // Increment class variable every time a new instance of Dog is created
        Dog.count += 1;
    }

    // method
    public void bark() {
        System.out.println("I am " + this.name + " and I am " + this.age + " years old");
    }

    // Getters
    public String getName() {
        return this.name;
    }
    public int getAge() {
        return this.age;
    }

    // Setter
    public void setAge(int age) {
        this.age = age;
    }

    // Private method
    private int add2() {
        return this.age + 2;
    }
    
    // Static method, shared between all instances of the class
    // Therefore an instance object of the class is not needed,
    // and can be called with Dog.display()
    public static void display() {
        System.out.print("I am a dog!");
    }
}
