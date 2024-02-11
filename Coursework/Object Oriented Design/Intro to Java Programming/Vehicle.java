// An interface is abstract, as in no instances of it can be created
// Its purpose is to be inherited by other objects
public interface Vehicle {
    // An "interface variable" that can be used among all interfaces,
    // similar to a class variable
    final int speed = 0;

    // Abstract methods, as only the method signatures is given
    // Any class that implements the interface vehicle MUST implement these methods
    void speedUp(int a);
    void slowDown(int a);

    // This method can be used from any class that implements this interface
    // using the keyword default
    default void out() {
        System.out.println("Default method");
    }
}
