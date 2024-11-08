//import jdk.javadoc.internal.tool.Start;

// import org.graalvm.compiler.replacements.nodes.arithmetic.IntegerMulHighNode;
// import org.w3c.dom.css.Counter;

// import java.util.concurrent.locks.Condition;
// import java.util.concurrent.locks.Lock;
// import java.util.concurrent.locks.ReentrantLock;
// import java.util.concurrent.*;

public class Main2 
{
    public static void printer(int time, Counter counter)
    {
        while(true)
        {
            synchronized (counter) 
            {
                try 
                {
                    counter.wait();
                } 
                catch (InterruptedException e) 
                {
                    System.out.println("Error: Interrupted Exception");
                }
                if(counter.count % time == 0) 
                {
                    System.out.println("\n" + time + " second message");
                }
            }
        }
    }

    public static void counterPrint(Counter counter)
    {
        while(true) 
        {
            try 
            {
                synchronized (counter) 
                {
                    counter.count++;
                    counter.notifyAll();
                }
                Thread.sleep(1000);
                System.out.print(counter.count + " ");
            } 
            catch (InterruptedException e) 
            {
                System.out.println("Error: Interrupted Exception");
            }
        }
    }
    public static void main(String[] args) 
    {
        Counter counter = new Counter();
        new Thread(
            new Runnable()
            {
                public void run()
                {
                    printer(7,counter);
                }
            }
        ).start();

        new Thread(
            new Runnable()
            {
                public void run()
                {
                    printer(15,counter);
                }
            }
        ).start();


        new Thread(
            new Runnable()
            {
                public void run()
                {
                    counterPrint(counter);
                }
            }
        ).start();
        
    }
}

class Counter 
{
    int count;
}