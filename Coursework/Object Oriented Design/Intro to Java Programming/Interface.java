// implements keyword tells a class to use one or more interfaces
public class Interface implements Vehicle {
    private int speed;
    
    // The interface methods from Vehicle MUST be implemented
    public void speedUp(int a) {
        this.speed += a;
    }

    public void slowDown(int a) {
        this.speed -= a;
    }

    
    // Method
    public void display () {
        System.out.print("I am a car, going " + this.speed);
        // This method is implemented from the interface
        out();
    }
}
