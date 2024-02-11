import java.util.Scanner;

public class InputsAndScanners {
    public static void main (String[] args) {
        // Create new scanner object
        Scanner sc = new Scanner(System.in);
        // Take input string from the user
        // Store that input in scanned
        String scanned = sc.next();
        // Parse scanned into an integer
        // For now, we assume scanned is an integer
        int x = Integer.parseInt(scanned);

        // Alternative:
        // Take input int from user
        // Store that input in scanned_int
        int scanned_int = sc.nextInt();

        // Print the variable scanned
        System.out.println(scanned);
    }
}
