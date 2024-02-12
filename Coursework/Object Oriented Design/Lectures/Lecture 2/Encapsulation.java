// An example of encapsulation where a person object has its data and methods collected inside it
// This object's data is protected by an interface of getter and setter methods
public class Person {
    private String name;
    private int age;

    public void Person(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String getName () {
        return this.name;
    }

    public void setName (String name) {
        this.name = name;
    }

    public int getAge () {
        return this.age;
    }

    public void setName (int age) {
        this.age = age;
    }
}
