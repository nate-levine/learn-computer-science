// 1. Create an interface that defines methods that states must implement
public interface State {
    public void insertDollar (VendingMachine vendingMachine);
    public void ejectMoney (VendingMachine vendingMachine);
    public void dispense (VendingMachine vendingMachine);
}

// 2. Define different state classes which implement the State interface
public class Stocked implements State {
    public void insertDollar (VendingMachine vendingMachine) {
        ...
    }
    public void ejectMoney (VendingMachine vendingMachine) {
        ...
    }
    public void dispense (VendingMachine vendingMachine) {
        ...
    }
}
public class OutOfStock implements State {
    public void insertDollar (VendingMachine vendingMachine) {
        ...
    }
    public void ejectMoney (VendingMachine vendingMachine) {
        ...
    }
    public void dispense (VendingMachine vendingMachine) {
        ...
    }
}

// 3. Create the context class lass that contains all the states
public class VendingMachine {
    // The different states are stored as private attributes
    private State stocked;
    private State outOfStock;

    private int count;

    public VendingMachine (int count) {
        // The different states are instantiated in the constructor
        stocked = new Stocked();
        outOfStock = new OutOfStock();

        if (count > 0) {
            currentState = stocked;
        }
        else {
            currentState = outOfStock;
        }
    } 

    // The context class is now able to handle all of the methods based
    // on the current state, and does not need to know what specific
    // state it is calling on
    public void insertDollar () {
        currentState.insertDollar(this);
    }
    public void ejectMoney () {
        currentState.ejectMoney(this);
    }
    public void dispense () {
        currentState.dispense(this);
    }
}
