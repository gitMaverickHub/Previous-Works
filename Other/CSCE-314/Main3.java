import java.lang.reflect.*;

class Main3 {

    static void displayMethodInfo(Object obj)
    {
        Method methodsList[] = obj.getClass().getDeclaredMethods();
        for (Method methods : methodsList)
        {
            System.out.print(methods.getName() + "(" + methods.getDeclaringClass().getSimpleName());
            Type[] typesList = methods.getGenericParameterTypes();
            for (Type types : typesList) 
            {
                System.out.print(", " + types);
            }
            System.out.println(") -> " + methods.getGenericReturnType());
        }
    }

    public static void main(String args[])
    {
        A A1 = new A();
        displayMethodInfo(A1);
    }

}

class A {

    void foo(String T1, String T2) { System.out.println(T1 + " " + T2); }
    int bar(int T1,int T2,int T3) { return T1+T2+T3; }
    static double doo() { return 2.0; }

}