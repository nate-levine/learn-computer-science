// 1. Design the subject interface
public interface IOrder {
    public void fulfillOrder(Order order);
}

// 2. Implement the real subject class
public class Warehouse implements IOrder {
    public void fulfillOrder (Order order) {
        ...
    }
    ...
}

// 3. Implement the proxy class
public class OrderFulfillment implements IOrder {
    private List<Warehouse> warehouses;

    public void fulfillOrder(Order order) {
        for (Warehouse warehouse: warehouse) {
            // check if any of the subject warehouses can fulfill the order
        }
    }
}
