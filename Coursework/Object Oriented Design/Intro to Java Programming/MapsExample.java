import java.util.Map;
import java.util.HashMap;

public class MapsExample {
    public static void main (String[] args) {
        Map m = new HashMap();
        String str = "Hello World";

        // .toCharArray() converts a string to a char array
        for (char x:str.toCharArray()) {
            if (m.containsKey(x)) {
                int old = (int)m.get(x);
                m.put(x, old + 1);
            } else {
                m.put(x, 1);
            }
        }

        System.out.println(m);
    }
}
