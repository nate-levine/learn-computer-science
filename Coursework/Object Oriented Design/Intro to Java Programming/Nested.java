import java.util.Scanner;

public class Nested {
    public static void main (String[] args) {
        System.out.print("Input your age: ");
        Scanner sc = new Scanner(System.in);
        String s = sc.nextLine();
        int age = Integer.parseInt(s);

        if (age >= 18) {
            System.out.println("You are an adult");

            System.out.println("What is your favorite food? ");
            String food = sc.nextLine();

            if (food.equals("Pizza")) {
                System.out.println("Mine too");
            } else {
                System.out.println("Good choice");
            }


        } else if (age >= 13) {
            System.out.println("You are a teenager");
        } else {
            System.out.println("You are a child");
        }
    }
}
