// 1. Design the target interface that the CoffeeTouchscreenAdapter will implement
public interface CoffeeMachineInterface {
    public void chooseFirstSelection();
    public void chooseSecondSelection();
}

// 2. Implement the CoffeeMachineInterface with the CoffeeTouchscreenAdapter
public class CoffeeTouchscreenAdapter implements CoffeeMachineInterface {
    OldCoffeeMachine oldCoffeeMachine = new OldCoffeeMachine();
    
    // The adapter wraps the OldCoffeeMachine methods with CoffeeTouchscreenAdapter methods
    // This allows a client to interact with the CoffeeMachineInterface,
    // which the CoffeeTouchscreenAdapter implements
    public void chooseFirstSelection() {
        oldCoffeeMachine.selectA();
    }

    public void chooseSecondSelection() {
        oldCoffeeMachine.selectB();
    }
}

// The OldCoffeeMachine is the separate system that the client does
// does not have direct access to in this practice problem
public class OldCoffeeMachine {
    public void selectA() {
        // Choose first coffee flavor
    }

    public void selectB() {
        // Choose second coffee flavor
    }
}
