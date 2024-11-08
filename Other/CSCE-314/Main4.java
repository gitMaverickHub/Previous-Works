import java.lang.reflect.*;

public class Main4{ 
    public static void main(String[] args){


        Class c;
        try
        {
            c = Class.forName(args[0]);
        }
        catch(Exception e){
            System.out.println("Class " + args[0] + " not found! Exiting program.");
            return;
        }
        Method methodsList[] = c.getDeclaredMethods();
        Object obj;
        try
        {
            obj = c.getDeclaredConstructor().newInstance();
        }
        catch(Exception e)
        {
            System.out.println("Error " + e.getMessage());
            return;
        }
        for (Method methods : methodsList)
        {
            if (Modifier.isPublic(methods.getModifiers()) && Modifier.isStatic(methods.getModifiers()) 
                && methods.getParameterCount() == 0 && methods.getReturnType() == boolean.class
                && methods.getName().startsWith("test"))
            {
                try
                {
                    methods.invoke(obj);
                }
                catch(Exception e)
                {
                    System.out.println("Error " + e.getMessage());
                    return;
                }
                System.out.println("OK: " + methods.getName() + " succeeded");
            }
            else
                System.out.println("OK: " + methods.getName() + " failed");
        }
        

    }
}

class MyClass {
    public static boolean test1(){return true;}
    public static boolean test2(){return false;}
    public static boolean testTAMU(boolean tamu){return tamu;}
    public boolean testCSE(){return false;}
    public static int testAggie(){return 2021;}
    public static boolean fakeTestAggie(){return false;}
}
