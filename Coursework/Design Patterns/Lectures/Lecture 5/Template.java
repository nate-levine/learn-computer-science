// 1. Create abstract super-class for sub-classes to inherit from
public abstract class PastaDish {
    // The "final" keyword makes this method immutable
    public final void makeRecipe () {
        boilWater();
        addPasta();
    }

    // Method that differs in functionality among
    // sub-classes is define but not implemented
    protected abstract void addPasta();

    // Method that has common functionality among
    // all sub-classes is implemented in the super-class
    private void boilWater() {
        // Boil water
    }
}

// 2. Create sub-classes that extend the super-class
public class Spaghetti extends PastaDish {
    protected void addPasta () {
        // Add spaghetti
    }
}
public class Penne extends PastaDish {
    protected void addPasta () {
        // Add penne
    }
}
