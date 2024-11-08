public class HW1_Q3 { 
    public static void main(String[] args){

    }
}

public final class Node<T extends Shape> {
    public final T v;
    public Node<T> next;
    public Node (T val, Node<T> link) { v = val; next = link; }
}

class NodeIterator<T> {

    public NodeIterator(Node<T> n){
        
    }

}