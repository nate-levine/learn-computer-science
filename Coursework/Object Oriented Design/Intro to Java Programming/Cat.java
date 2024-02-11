// Cat inherits from Dog
// Cat is the sub-class of the super-class Dog
public class Cat extends Dog {
    
    private int food;

    public Cat(String name, int age, int food) {
        // Call super-class constructor
        super(name, age);
        this.food = food;
    }

    // Override constructor with less arguments
    // This gives multiple arguments for the constructor
    public Cat(String name, int age) {
        super(name, age);
        // Default parameter
        this.food = 40;
    }

    public void meow() {
        System.out.println("Meow my name is " + getName() + " and I get fed " + this.food + "g of food");
    }

    // Override method
    public void bark() {
        System.out.println("I am a cat, I cannot bark");
    }
}
