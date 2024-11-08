import java.util.Arrays;

public class HW1_Q2 {   
    public static void main(String[] args){
        int numOfShapes = 0;
        Shape shape[] = new Shape[args.length];
        for (String str : args) {
            String[] inputs = str.split(" ");
            if(inputs[0].equals("t"))
            {
                shape[numOfShapes] = new Triangle(inputs[1], inputs[2], inputs[3], inputs[4], inputs[5], inputs[6]);
                numOfShapes++;
            }
            else if(inputs[0].equals("r"))
            {
                shape[numOfShapes] = new Rectangle(inputs[1], inputs[2], inputs[3], inputs[4]);
                numOfShapes++;
            }
            else if(inputs[0].equals("c"))
            {
                shape[numOfShapes] = new Circle(inputs[1], inputs[2], inputs[3]);
                numOfShapes++;
            }
        
        }
        /* Some initialization from the args ... */ 
        System.out.printf("The total area for the %d objects is %1.2f units squared.\n", shape.length, AreaCalculator.calculate(shape));

        Arrays.sort(shape);
        int count = 0;
        for (Shape s: shape) {
            System.out.println(++count + ") "+s+"\t\t area="+s.area());
        }

    }

}

class Point {

    public double x;

    public double y;

    public Point (double _x, double _y) {
        x = _x;
        y = _y;
    }

    public boolean equals(Object obj)
    {
        if(obj == null) return false;
        if(obj.getClass() != Point.class) return false;
        Point other = (Point)obj;
        return other.x == x && other.y == y;
    }

    public int hashCode()
    {
        return 7*(int)x + 37*(int)y + 109; //random primeness
    }

}

abstract class Shape implements Comparable<Shape> {

    public abstract Point position();
    public abstract double area();
    public abstract boolean equals(Object obj);
    public abstract String toString();
    public int compareTo(Shape s)
    {
        double myArea = area();
        double sArea = s.area();
        if (myArea > sArea)
            return 1;
        else if (myArea == sArea)
            return 0;
        else return -1;
    }

}

class Triangle extends Shape {

    private Point Point1;

    private Point Point2;

    private Point Point3;

    Triangle(String x1, String y1, String x2, String y2, String x3, String y3){
        Point1 = new Point(Double.valueOf(x1), Double.valueOf(y1));
        Point2 = new Point(Double.valueOf(x2), Double.valueOf(y2));
        Point3 = new Point(Double.valueOf(x3), Double.valueOf(y3));
    }

    public Point position() {
        double xc = (Point1.x+Point2.x+Point3.x)/3;
        double yc = (Point1.y+Point2.y+Point3.y)/3;
        Point centroid = new Point(xc, yc);
        return centroid;
    }

    public double area() {
        double Area = ((.5) * (((Point1.x-Point2.x)*(Point1.y-Point3.y)) - ((Point1.x-Point3.x)*(Point1.y-Point2.y))));
        return Area;
    }

    public boolean equals(Object obj)
    {
        if(obj == null) return false;
        if(obj.getClass() != Triangle.class) return false;
        Triangle other = (Triangle)obj;
        if(!Point1.equals(other.Point1)) return false;
        if(!Point2.equals(other.Point2)) return false;
        if(!Point3.equals(other.Point3)) return false;
        return true;
    }

    public String toString()
    {
        String shape = "Triangle (" + Point1.x + ", " + Point1.y + ")-(" + Point2.x + ", " + Point2.y + ")-(" + Point3.x + ", " + Point3.y + ")";
        return shape;
    }

    public int hashCode()
    {
        return 7*Point1.hashCode() + 11*Point2.hashCode() + 13*Point3.hashCode();
    }

}

class Rectangle extends Shape{

    private Point Point1;

    private Point Point2;

    Rectangle(String x1, String y1, String x2, String y2) {
        Point1 = new Point(Double.valueOf(x1), Double.valueOf(y1));
        Point2 = new Point(Double.valueOf(x2), Double.valueOf(y2));
    }

    public Point position() {
        double xc = (Point1.x+Point2.x)/2;
        double yc = (Point1.y+Point2.y)/2;
        Point centroid = new Point(xc, yc);
        return centroid;
    }

    public double area() {
        double Area = (Math.abs(Point1.x-Point2.x)) * (Math.abs(Point1.y-Point2.y));
        return Area;
    }

    public boolean equals(Object obj)
    {
        if(obj == null) return false;
        if(obj.getClass() != Rectangle.class) return false;
        Rectangle other = (Rectangle)obj;
        if(!Point1.equals(other.Point1)) return false;
        if(!Point2.equals(other.Point2)) return false;
        return true;
    }

    public String toString()
    {
        String shape = "Rectangle (" + Point1.x + ", " + Point1.y + ")-(" + Point2.x + ", " + Point2.y + ")";
        return shape;
    }

    public int hashCode()
    {
        return 7*Point1.hashCode() + 11*Point2.hashCode();
    }

}

class Circle extends Shape {

    private Point Point1;

    private double radius;

    Circle(String x1, String y1, String r) {
        Point1 = new Point(Double.valueOf(x1), Double.valueOf(y1));
        radius = Double.valueOf(r);
    }

    public Point position() {
        return Point1;
    }

    public double area() {
        return radius*radius*Math.PI;
    }

    public boolean equals(Object obj)
    {
        if(obj == null) return false;
        if(obj.getClass() != Circle.class) return false;
        Circle other = (Circle)obj;
        if(!Point1.equals(other.Point1)) return false;
        if(radius != (other.radius)) return false;
        return true;
    }

    public String toString()
    {
        String shape = "Circle (" + Point1.x + ", " + Point1.y + "), radius = " + radius;
        return shape;
    }

    public int hashCode()
    {
        return 7*Point1.hashCode() + 11*(int)radius;
    }

}

class AreaCalculator {

    private static double Area;

    public static double calculate(Shape[] shapes) {
        for (int cur = 0; cur < shapes.length; cur++) {
            Area += shapes[cur].area();
        }
        return Area;
    }

}