// Create an enum
public enum Level {
    // Three constants stored in the level enum
    // Each constant calls a constructor that binds a value to itself
    HIGH(3),
    MEDIUM(2),
    LOW(1);

    // Assign enum values to different expressions with a constructor
    private int lvlNum;

    private Level (int num) {
        this.lvlNum = num;
    }

    // Getter
    public int getLvl () {
        return this.lvlNum;
    }
    // Setter
    public void setLvl (int num) {
        this.lvlNum = num;
    }
}
