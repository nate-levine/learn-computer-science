public class BasicOperations {
    public static void main (String[] args) {
        int x = 5;
        int y = 7;
        int z = 56;
        int sum = x + y + z;
        int product = x * y * z;
        // x to the power of y (x^y)
        double exp = Math.pow(x, y);
        // order of operations applies in Java
        int order = x + y * z;
        // Type cast a datatype
        double u = (double)x + 7.0;

        System.out.println(sum);
        System.out.println(product);
    }
}
