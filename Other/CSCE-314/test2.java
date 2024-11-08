import java.lang.reflect.Modifier;
import java.lang.reflect.Field;

public class test2
{
    static boolean PrivateAttributes(String name)
    {   
        Class c;
        try
        {
            c = Class.forName(name);
        }
        catch(Exception e)
        {
            System.out.println("Class " + name + " not found! Exiting program.");
            return false;
        }
        Field[] fields = c.getDeclaredFields();
        for (Field field : fields)
        {
            if(Modifier.isPrivate(field.getModifiers()))
            {   
                System.out.println("True");
                return true;
            }
        }
        System.out.println("False");
        return false;
    }

    public static void main(String[] args)
    {
        String name = args[0];
        PrivateAttributes(name);
    }
}

class Example
{
    private String ex1;
    private int ex2;
    public char ex3;
}