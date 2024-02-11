public class Conditionals {
    public static void main (String[] args) {
        int x = 6;
        int y = 7;
        int z = 10;

        boolean x_gt_y = x < y;
        boolean z_lt_y = z < y;

        if (x_gt_y && z_lt_y) {
            System.out.println("x is greater than y");
        } else if (!z_lt_y) {
            System.out.println("z is greater than y");
        } else {
            System.out.println("neither conditions are true");
        }

    }
}
