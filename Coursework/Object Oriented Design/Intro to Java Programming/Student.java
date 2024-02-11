public class Student {
    private String name;

    public Student (String name) {
        this.name = name;
    }

    public boolean equals (Student other) {
        return (this.name == other.name);
    }

    // Built in string method, similar to Python's __string__ method
    public String toString () {
        return this.name;
    }
}
