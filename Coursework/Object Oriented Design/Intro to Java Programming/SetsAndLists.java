import java.util.Scanner;
import java.util.HashSet;
import java.util.ArrayList;

public class SetsAndLists {
    public static void main (String[] args) {
        // Sets are unordered collections of unique elements
        HashSet<Integer> t = new HashSet<Integer>();
        t.add(5);
        t.add(7);
        // This will not be added, as every element must be unique
        t.add(5);
        // Remove an element from a list
        t.remove(7);
        
        // See if a set contains an element
        t.contains(5);

        // Get set size
        int size = t.size();

        System.out.println(t);


        // Array lists, unlike arrays, are dynamically sized
        ArrayList<Integer> v = new ArrayList<Integer>();
        v.add(1);
        v.add(2);
        v.add(3);
        v.add(4);
        // Get the 0'th element of the array list
        v.get(0);
        // Set the 1'th element of the array to 5
        // This index but exist already
        v.set(1, 5);
        // Get a slice of the list from index 1 to 2
        v.subList(1, 3);
    }
}
