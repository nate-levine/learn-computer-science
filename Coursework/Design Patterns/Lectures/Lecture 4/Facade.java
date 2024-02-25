// 1. An interace is created
// The inteface interacts with a subsystem,
// and is not known to any client classes
public interface IAccount {
    public void deposit (...);
    public void withdraw (...);
    ...
}

// 2. One or more classes are implemented using the interface
public class Checking implements IAccount { ... }
public class Sawving implements IAccount { ... }

// 3. Create the Facade class and wrap
//    classes that implement the interface
public class BankService {
    public int createNewAccount (String type) {
        ...
    }
    public void transferMoney(...) {
        ...
    }
    ...
}

// 4. Use the Facade class (BankService)
//    to access the subsystem
public class Customer {
    public static void main(String args[]) {
        // Access the subsystem
        BankService bankService = new BankService();
        // Use the facade to interact with the subsystem
        int savings = bankService.createNewAccount("saving");
        savings.transferMoney(...);
    }
}
