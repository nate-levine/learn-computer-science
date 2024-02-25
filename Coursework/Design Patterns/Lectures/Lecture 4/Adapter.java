// 1. Design the target interface that
//    the Adapter will implement
public interface WebRequester {
    public int request(Object);
}

// 2. Implement the target interface
//    with the Adapter class
public class WebAdapter implements WebRequester {
    private WebService service;

    public void connect (WebService currentService) {
        this.service = currentService;
    }

    public int request (Object request) {
        ...
    }
}

// 3. Send the request from the client to the Adapter
//    using the target interface
public class WebClient {
    private WebRequester webRequester;

    public WebClient (WebRequester webRequester) {
        ...
    }

    public void doWork () {
        Object object = makeObject();
        int status = webRequester.request(object);

        ...
    }
}

// 4. Utilize the Adapter class
public class Program {
    public static void main (String args[]) {
        WebService service = new Webservice("Host: https://...")
        WebAdapter adapter = new WebAdapter();
        adapter.connect(service);
        
        // Notice how the client does not need to directly interact
        // with the adaptee
        // Instead, the client communicates with the adaptee
        // through the Adapter class
        WebClient client = new WebClient(adapter);
        client.doWork();
    }
}
