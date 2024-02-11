public class Enums {
    public static void main (String[] args) {
        // Create an instance of the enum Level
        Level lvl = Level.LOW;
        // Convert the enum to a string and bind it to a separate variable
        String en = lvl.toString();

        // Print out all enum values in an array
        System.out.println(Level.values());

        // Get values bound to enums
        System.out.println(Level.valueOf("LOW"));

        if (lvl == Level.LOW) {
            System.out.print(lvl);
        } else if (lvl == Level.MEDIUM) {
            System.out.print(lvl);
        } else {
            System.out.print(lvl);
        }
    }
}
