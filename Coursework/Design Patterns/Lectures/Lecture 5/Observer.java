// 1. Create the subject class
public class Subject {
    // An array list is used to keep track of the current observers
    private ArrayList<Observer> observers = new ArrayList<Observer>();

    public void registerObserver (Observer observer) {
        observers.add(observer);
    }
    public void unregisterOberserver (Observer observer) {
        observers.remove(observer);
    }
    public void notify () {
        for (Oberver observer : observers) {
            observer.update();
        }
    }
}

// 2. Create the Observer interface
public interface Observer () {
    public void update ();
}

// 3. Implement the observer interface in a subscriber class
public class Subscriber implements Observer {
    public void update () {
        // receive the change from the Subject through the Observer interface
    }
}
