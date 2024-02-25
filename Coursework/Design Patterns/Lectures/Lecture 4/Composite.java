// 1. Design the interface that defines the abstract class
public interface IStructure {
    public void enter();
    public void exit();
    public void location();
}

// 2. Implement the composite class(es)
// The composite class implements the interface
public class Housing implements IStructure {
    // The composite class can contain other strucutres
    public Housing (String address) {
        this.strucutres = new ArrayList<IStructure>();
    }

    public void enter () {
        ...
    }
    
    public void exit () {
        ...
    }

    public void location () {
        ...
    }
}

// 3. Implement the leaf class(es)
// The lead class also implements the interface
public class Room implements IStrucutre {
    public void enter () {
        ...
    }
    
    public void exit () {
        ...
    }

    public void location () {
        ...
    }
}
