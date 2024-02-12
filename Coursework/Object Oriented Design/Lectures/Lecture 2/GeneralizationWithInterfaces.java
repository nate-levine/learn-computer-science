// The "I" denotes that IAnimal is an interface, not a class
public interface IAnimal {
	// None of these behaviors are defined, as that is the job of the classes that implement this interface
	// Only methods signatures can be defined, as attributes do not describe behaviors
	public void move ();
	public void eat ();
}

// The Cat and Dog method both implement the Animal interface, yet their implementations of speak are different
public class Dog implements IAnimal {
    public void speak () {
        System.out.println("Bark!");
    }
}

public class Cat implements IAnimal {
    public void speak () {
        System.out.println("Meow!");
    }
}    


// Multiple implementations of interfaces for a Person class
public class Person implements IPublicSpeaking, IPrivateConversation {
    public void speak() {
        System.out.println("This is fine");
    }
}
