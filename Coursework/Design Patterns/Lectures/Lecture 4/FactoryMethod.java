// The super-class is abstract, and therefore cannot be instantiated
public abstract class KnifeStore {
    public Knife orderKnife (String knifeType) {
        // Creating a knife is now a method in the class
        knife = createKnife(knifeType);

        return knife
    }


    // Because the Factory method is abstract,
    // it must be implemented by its subclasses
    abstract Knife createKnife (String knifeType);
}


// KnifeStore sub-class
public BudgetKnifeStore extends KnifeStore {
    // Factory method for the sub-class
    Knife createKnife (String knifeType) {
        // Any budget knife can be created from this subtype,
        // again using concrete instantiation
        if (knifeType.equals("bread")) {
            knife = new BudgetBreadKnife();
        }
        else if (knifeType.equals("butter")) {
            knife = new BudgetButterKnife();
        }
        else if (knifeType.equals("paring")) {
            knife = new BudgetParingKnife();
        }
        else {
            return null;
        }
    }
}
