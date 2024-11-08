// This is the starter code. You are free to add methods and fields
// to this class.

//import java.io.Console;
import java.util.*;
import java.util.concurrent.locks.ReentrantLock;

class PostBox implements Runnable {
    private final int MAX_SIZE;

    class Message {
        String sender;
        String recipient;
        String msg;
        Message(String sender, String recipient, String msg) {
            this.sender = sender;
            this.recipient = recipient;
            this.msg = msg;
        }
    }

    private final LinkedList<Message> messages;
    private LinkedList<Message> myMessages;
    private String myId;
    private volatile boolean stop = false;
    private ReentrantLock messagesLock;
    private ReentrantLock myMessagesLock = new ReentrantLock();

    public PostBox(String myId, int max_size) {
        messages = new LinkedList<Message>();
        messagesLock = new ReentrantLock();
        this.myId = myId;
        this.myMessages = new LinkedList<Message>();
        this.MAX_SIZE = max_size;
        new Thread(this).start();
    }

    public PostBox(String myId, int max_size, PostBox p) {
        this.messagesLock = p.messagesLock;
        this.myId = myId;
        this.messages = p.messages;
        this.MAX_SIZE = max_size;
        this.myMessages = new LinkedList<Message>();
        new Thread(this).start();
    }

    public String getId() { return myId; }

    public void stop() {
        // make it so that this Runnable will stop when it next wakes
        stop = true;
    }

    public void send(String recipient, String msg) {
        // add a message to the shared message queue
        myMessagesLock.lock();
        messages.add(new Message(myId,recipient,msg));
        myMessagesLock.unlock();
        //System.out.println(messages.size());
    }

    public List<String> retrieve() {
        List<String> ret = new LinkedList<String>();
        myMessagesLock.lock();
        for (Message msg : messages) {
            ret.add("From " +msg.sender + " to " + msg.recipient + ": " + msg.msg);
        }
        messages.clear();
        myMessagesLock.unlock();
        return ret;
        // return the contents of myMessages
        // and empty myMessages
    }

    public void run() {
        while(!stop)
        {
            try
            {
                Thread.sleep(1000);
            }
            catch(Exception e)
            {
                System.out.println("My sleep was interrupted because: " + e.getMessage());
            }
            messagesLock.lock();
            //copy messages
            for (Message message : messages) {
                if(message.recipient.equals(this.myId))
                {
                    myMessages.add(message);  
                    System.out.println("copied"); 
                }
            }
            //remove messages tp me

            messages.removeAll(myMessages);
            for(int i = messages.size() -  MAX_SIZE; i > 0; i--)
            {
                messages.removeLast();
            }
    
            for(int i = myMessages.size() -  MAX_SIZE; i > 0; i--)
            {
                myMessages.removeLast();
            }

            messagesLock.unlock();
        }

        // loop while not stopped
        //   1. approximately once every second move all messages
        //      addressed to this post box from the shared message
        //      queue to the private myMessages queue
        //   2. also approximately once every second, if the private or
        //      shared message queue has more than MAX_SIZE messages,
        //      delete oldest messages so that the size of myMessages
        //      and messages is at most MAX_SIZE.
    }
}

public class Main1 {

    static void pause(long n) {
        try { Thread.sleep(n); } catch (InterruptedException e) {}
    }

    public static void main (String[] args) {
        final int MAX_SIZE = 10;
        final String bond    = "Bond";
        final String blofeld = "Blofeld";
        final String osato   = "Mr. Osato";

        final PostBox pBond    = new PostBox(bond, MAX_SIZE);
        final PostBox pBlofeld = new PostBox(blofeld, MAX_SIZE, pBond);
        final PostBox pOsato   = new PostBox(osato, MAX_SIZE, pBond);

        // send out some messages on another thread
        new Thread( new Runnable() {
                public void run() {
                pBond.send(blofeld, "Yes, this is my second life"); pause(1000);
                pBlofeld.send(bond, "You only live twice, Mr. Bond."); pause(500);
                String msg = "I gave Number 11 the strictest orders to eliminate him.";
                pOsato.send(blofeld, msg); pause(2000);
                pOsato.send(bond, msg);
                for (int i=0; i<20; ++i) pOsato.send(bond, "flooding the message queue...");
                }
                }).start();

        PostBox[] boxes = { pBond, pBlofeld, pOsato };
        long startTime = System.currentTimeMillis();
        // poll for messages in a loop for 5 secs
        while (true) {
            for (PostBox box : boxes) {
                for (String m : box.retrieve()) System.out.println(m);
            }
            if (System.currentTimeMillis() - startTime > 5000) break;
        }
        // stop each mailbox
        for (PostBox box : boxes) {
            box.stop();
        }
    } // end of main()

} // end of Main1