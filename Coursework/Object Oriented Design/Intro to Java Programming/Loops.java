import java.util.Scanner;

public class Loops {
    public static void main (String[] args) {
        Scanner sc = new Scanner(System.in);

        int x = 0;
        // Add 1 to x 10 times, printing the value of x each time
        for (int i = 0; i < 10; i++) {
            x += 1;
            System.out.println(x);
        }

        int[] arr = {1, 5, 7, 3, 4, 5};
        // Print out all the values in the array
        for (int i = 0; i < arr.length; i++) {
            System.out.println(arr[i]);
        }

        // Iterate through each element in arr
        // Use a counter to keep track of the current index
        int index = 0;
        for (int element:arr) {
            System.out.println(element);
            index++;

            // If the first 3 indices of the loop are not 4, break out of the for loop
            if (index == 2) {
                break;
            }
        }

        // While loop that runs until the user types 10
        int y = sc.nextInt();
        while (y != 10) {
            System.out.println("Type 10");
            y = sc.nextInt();
        }

        // Do while loop that runs until the user types 10
        // The difference is that do runs the loop at least once,
        // as the while condition is checked at the end of the loop,
        // rather than the beginning
        int z = sc.nextInt();
        do {
            System.out.println("Type 10");
            z = sc.nextInt();
        } while (z != 10);
    }
}
