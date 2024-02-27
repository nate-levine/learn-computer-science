// 1. Methods to be implemented by the Channel class
public interface Subject {
    public void registerObserver (Observer observer);
    public void removeObserver (Observer observer);
    public void notifyObservers ();
}

// 2. Channel subject class
public class Channel implements Subject {
    // Keep track of current observers
    private ArrayList<Observer> observers = new ArrayList<Observer>();
    public String channelName;
    public String status;

    public String getStatus () {
        return this.status;
    }
    public void setStatus (String status) {
        this.status = status;
    }
    public void registerObserver (Observer observer) {
        observers.add(observer);
    }
    public void removeObserver (Observer observer) {
        observers.remove(observer);
    }
    public void notifyUsers () {
        for (Observer observer : observers) {
            observer.update();
        }
    }
}

// 3. Observer interface to be implemented by Channel followers
public interface Observer {
	public void update (String status);
}

// 4. Follower class implements the Observer interface
public class Follower implements Observer {
    public String followerName;

    public void update (String status) {
        // Inform the user that the channel is live    
    }
}

