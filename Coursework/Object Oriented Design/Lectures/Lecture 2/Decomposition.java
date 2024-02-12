// An example of association in decomposition where Food and Wine do not belong to each other
public calss Wine {
    public void pair (Food food) {
        ...
    }
}

// An example of aggregation in decomposition where Airliner and CrewMemver are in a "set" and "whole" relationship
public class Airliner {
    private ArrayList<CrewMember> crew;

    public Airliner() {
        crew = new ArrayList<CrewMember>();
    }

    public void add (CrewMember crewMember) {
        ...
    }
}

// An example of composition in decomposition where Human and Brain are in a "set" and "whole" relationship,
// And the set is exclusive to the whole, as in the set could not exist without the whole
public class Human {
    private Brain brain;

    public Human () {
        brain = new Brain();
    }
}
