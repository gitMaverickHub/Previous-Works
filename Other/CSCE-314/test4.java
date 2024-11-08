import java.util.concurrent.locks.*;

import java.util.Random;

public class test4
{
    // These can be accessed from other functions as Main.mylock,
    //              Main.cond, Main.trophies
    final public static Lock mylock = new ReentrantLock();
    final public static Condition cond = mylock.newCondition();
    public static int trophies;
    public static int level;
    public static void main(String[] args) 
    {
        // This is a 2-player situation
        Player p1 = new Player();
        Player p2 = new Player();
        // Stuff here to initialize players
        Manager m = new Manager();
        // Stuff here to initialize game manager
        new Thread(
            new Runnable(){

                public void run(){
                    while(true)
                    {
                        mylock.lock();
                        System.out.println("T: " + trophies + " L: " + level);
                        mylock.unlock();
                    }
                }
            }).start();
        PlayerRunnable pr1 = new PlayerRunnable(p1);
        PlayerRunnable pr2 = new PlayerRunnable(p2);
        Thread t1 = new Thread(pr1);
        Thread t2 = new Thread(pr2);
        t1.start();
        t2.start();
        m.start();
    }
}

class Player 
{
    boolean alive = true;
    // Some attributes, constructors, methods, etc. defined here
    Player() { }
    public boolean isAlive()
    {
        //...  This returns true if the player is alive
        return alive;
    }
    public Move getMove() 
    {
        //...  This gets a move from a user
        Move move = new Move();
        return move;
    }
    public int getResult(Move nextmove) 
    {
        //...  This returns the number of trophies the move resulted in
        Random rand = new Random();
        int trophiesEarned = rand.nextInt(10);
        return trophiesEarned;
    }
    public void awardTrophies(int numtrophies) 
    {   
        test4.mylock.lock();
        test4.trophies += numtrophies;
        test4.cond.signalAll();
        test4.mylock.unlock();

        // PROBLEM B code will go here
    }
    public void kill()
    {
        alive = false;
    }
}

class Move 
{
    //... Undefined class move
    int pos;
    Move()
    {
        Random rand = new Random();
        pos = rand.nextInt(6);
    }
}

class Manager extends Thread
{
    //THIS IS FOR THE HEADER LINE FOR THE Manager CLASSS (Question C.i)
    // Some attributes, constructors, methods, etc. defined here
    Manager() { }
    public void awardBonus() 
    {
        // ...  causes there to be some bonus activated in the game
        //test4.mylock.lock();
        test4.trophies += 50;
        //test4.mylock.unlock();
    }

    public void increaseLevel()
    {
        //test4.mylock.lock();
        test4.level += 1;
        //test4.mylock.unlock();

    }

    public void run() 
    {
        // CODE FOR PART C.ii GOES HERE
        test4.mylock.lock();
        int prev1 = 0;
        int prev2 = 0;
        while(true)
        {
            try
            {
                if(test4.trophies >= prev1 + 250)
                {
                    increaseLevel();
                    prev1 = test4.trophies;
                }
                if(test4.trophies >= prev2 + 1000)
                {
                    awardBonus();
                    prev2 = test4.trophies;
                }
                else
                {
                    test4.cond.await();
                }
            }
            catch(Exception e)
            {
                System.out.println("Error");
            }
        }        
    } 
}

class PlayerRunnable extends Thread
{
    Player player;
    PlayerRunnable(Player p)
    {
        player = p;
    }
    public void run()
    {
        while(player.isAlive())
        {
            try
            {
                Thread.sleep(100);
            }
            catch(Exception e)
            {
                System.out.println("Sleep interrupted");
            }
            Move m = player.getMove();
            int trophies = player.getResult(m);
            player.awardTrophies(trophies);
        }
    }
} 