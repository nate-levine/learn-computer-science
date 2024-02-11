import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.Scanner;
import java.util.Set;
import java.util.TreeMap;

public class HashMaps {
    public static void main (String[] args) {
        // Hash maps are what Python calls dictionaries
        Map m = new HashMap();
        // Insert a key-value pair into the hash map
        m.put("Nate", 21);
        m.put("Matthew", 23);
        m.put("Gompei", "Goat");
        // Hash maps cannot have duplicate keys,
        // so duplicate keys are shadowed
        m.put("Gompei", "Sheep");
        // Access a hash map value based on a key
        System.out.print(m.get("Nate"));
        // Check if a hash map contains a value
        boolean contains_value = m.containsValue("Sheep");
        // Check if a hash map contains a key
        boolean contains_key = m.containsKey("Nate");
        // Clear the map
        m.clear();
        // Check if the map is empty
        m.isEmpty();

        
        // Tree maps must have keys of the same datatype
        // Tree maps are sorted in order by key
        Map n = new TreeMap();
        n.put("Nate", 21);
        n.put("Matthew", 23);
        n.put("Dave", 55);


        // Linked hash maps maintain the order in which elements are added to it
        Map p = new LinkedHashMap();
        p.put("Matthew", 23);
        p.put("Nate", 21);
    }
}
