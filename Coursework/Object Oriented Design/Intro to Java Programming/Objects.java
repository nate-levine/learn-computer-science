public class Objects {
    public static void main (String[] args) {
        // Invoke the method Print
        Print("Hello, World!");

        // Print 8 from a return value
        System.out.println(add2(6));

        // Create an object instance from the Dog class
        Dog fido = new Dog("Fido", 4);
        fido.bark();

        Cat leo = new Cat("Leo", 2, 50);
        leo.meow();
    }

    // A new method for Main
    // void means that the class returns nothing
    public static void Print(String str) {
        System.out.println(str);
    }


    public static int add2(int x) {
        // Return an expression
        return x + 2;
    }
}
