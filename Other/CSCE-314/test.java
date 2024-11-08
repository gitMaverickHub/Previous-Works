public class test
{   
    static void printgreeting(Names pos)
    {
        System.out.println(pos.formal() + " " + pos.informal());
    }
    public static void main(String[] args)
    {
        Royalty king = new Royalty();
        Lawyer defender = new Lawyer("Vinny");
        Judge districtjudge = new Judge("Judy");
        king.setName("Arthur");
        printgreeting(king);
        printgreeting(districtjudge);
        printgreeting(defender);
    }
}

interface Names
{
    public String formal();
    public String informal();
    public void setName(String name);
}

class Royalty implements Names
{
    public String formal = "Your Highness";
    public String informal;
    public String formal() {return formal;}
    public String informal() {return informal;}
    public void setName(String name) {informal = name;}
}

class Lawyer implements Names
{
    public Lawyer(String name)
    {
        informal = name;
        formal = "Attorney";
    }
    public String formal;
    public String informal;
    public String formal() {return formal;}
    public String informal() {return informal;}
    public void setName(String name) {informal = name;}
}

class Judge extends Lawyer implements Names
{
    public Judge(String name)
    {
        super(name);
        formal = "Your Honor";
    }
}