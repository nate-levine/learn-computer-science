// 1. Create the Command super-class
public class Command {
    public abstract void execute ();
    public abstract void unexecute ();
    public abstract boolean isReversible ();
}

// 2. Implement a concrete command which extends Command
public class PasteCommand extends Command {
    private Document document; // The receiver
    private int position;
    private String text;

    public PasteCommand (Document document, int position, String text) {
        this.document = document;
        this.position = position;
        this.text = text;
    }

    public void execute () {
        document.insertText (position, text);
    }

    public void unexecute () {
        document deleteText (position, text.length());
    }

    public boolean isReversible () {
        return true;
    }
}

// 3. The invoker uses the command manager class to invoke a new command
CommandManager commandManager = CommandManager.getInstance()
Command command = new PasteCommand(document, position, text);
commandManager.invokeCommand(command);
