// A knife Factory which creates different types of knives based on an input string
public class KnifeFactory {
    public Knife createKnife (String knifeType) {
        Knife knife = null;

        // create a product object through concrete instantiation
        if (knifeType.equals("bread")) {
            knife = new BreadKnife();
        }
        else if (knifeType.equals("butter")) {
            knife = new ButterKnife();
        }
        else if (knifeType.equals("paring")) {
            knife = new ParingKnife();
        }
        ...

        return knife;
    }
}
