public class Singleton {
    // Store the instance of the Singleton as a class variable
    private static Singleton = null;

    private Singleton () {
        ...
    }
    
    // A class method to return the class variable
    // This class method uses lazy creation
    public static Singleton getInstance() {
        // Create an instance of the Singleton if and only if it does not already exist
        if (instance == null){
            instance = new Singleton();
        }
        
        return instance;
    }
}


// Use the Singleton
Singleton.getInstance();
