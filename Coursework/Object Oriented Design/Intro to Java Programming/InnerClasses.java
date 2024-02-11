public class InnerClasses {
    
    // Create a class inside InnerClasses
    // This class can only be accessed through the outer class
    // with:
    // InnerClasses.InnerClass in = innerClasses.new InnerClass()
    private class InnerClass {
        public void display () {
            System.out.println("This is an inner class");
        }
    }

    public void inner () {
        InnerClass in = new InnerClass();
        in.display();
    }
}
