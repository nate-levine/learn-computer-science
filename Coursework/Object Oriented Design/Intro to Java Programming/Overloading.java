import java.util.ArrayList;

public class Overloading {
    public static void main (String[] args) {
        Student joe = new Student("Joe");
        Student bill = new Student("Bill");
        Student tim = new Student("Tim");

        System.out.println(joe.equals(bill));
    }
}
