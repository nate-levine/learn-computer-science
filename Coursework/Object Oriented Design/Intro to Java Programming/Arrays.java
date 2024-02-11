public class Arrays {
    public static void main (String[] args) {
        // Create a string array with 5 elements
        String[] newArr = new String[5];
        // Bind a value to the 0'th (1st) element of newArr
        newArr[0] = "Apple";
        // and so on...
        newArr[1] = "Banana";
        newArr[2] = "Cantoloupe";
        newArr[3] = "Date";
        newArr[4] = "Eggplant";

        // Index 1'th (2nd) element of newArr
        String x = newArr[1];

        // Initialize an int array with values
        int[] nums = {2, 3, 7, -9, 0};
        int seven = nums[2];
    }
}
