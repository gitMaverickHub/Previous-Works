// Simple doubly linked list - implementation

#include <iostream>

using namespace std;

// a list node
struct Node {
  int data;       // each node holds an integer data
  Node* previous; // pointer to the previous node
  Node* next;     // pointer to the next node
  // constructor
  Node(int d=0, Node* p=nullptr, Node* n=nullptr) :
    data(d), previous(p), next(n) {}
  Node* get_previous() const { return previous; }
  Node* get_next() const { return next; }
  Node* insert_before(int d);  /* insert d before this node
                                  return a pointer to the inserted node  */
  Node* insert_after(int d);  /* insert d after this node
                                 return a pointer to the inserted node  */
  void delete_before(); // delete the node before this node
  void delete_after();  // delete the node after this node
};

// insert d before this node
// return a pointer to the inserted node
Node* Node::insert_before(int d){   //runtime O(1)

  Node* pointer = new Node(d);
  previous->next = pointer;
  pointer->next = this;
  pointer->previous = previous;
  previous = pointer;
  return pointer;

}

// insert d after this node
// return a pointer to the inserted node
Node* Node::insert_after(int d){    //runtime O(1)

  Node* pointer = new Node(d);
  next->previous = pointer;
  pointer->previous = this;
  pointer->next = next;
  next = pointer;
  return pointer;

}

// delete the node before this node
void Node::delete_before(){   //runtime(1)

  previous->previous->next = this;
  previous = previous->previous;

}

// delete the node after this node
void Node::delete_after(){    //runtime O(1)

  next->next->previous = this;
  next = next->next;
  
}

// Display a doubly linked list
void display_list(Node* header, Node* trailer){   //runtime O(n)
  Node* p = header->get_next();

  while (p != trailer) {
    cout << p->data << ", ";
    p = p->get_next();
  }
  cout << endl;
}

// Test program
int main(){
  // Construct a doubly linked list with a header & trailer
  cout << "Create a new list" << endl;
  Node *header = new Node(-1);
  Node *trailer = new Node(-2);
  trailer->previous = header;
  header->next = trailer;
  cout << "list: ";
  display_list(header, trailer);
  cout << endl;
  
  // Insert 10 nodes with values 10,20,30,..,100
  cout << "Insert 10 nodes with values 10,20,30,..,100" << endl;
  for (int i = 10; i <= 100; i += 10) {
    trailer->insert_before(i);
  }
  cout << "list: ";
  display_list(header,trailer);
  cout << endl;

  // Insert 10 nodes at front with value 100,90,80,..,10
  cout << "Insert 10 nodes at front with value 100,90,80,..,10" << endl;
  for (int i = 10; i <= 100; i += 10) {
    header->insert_after(i);
  }
  cout << "list: ";
  display_list(header, trailer);
  cout << endl;
  
  // Delete the last 5 nodes
  cout << "Delete the last 5 nodes" << endl;
  for (int i = 0; i < 5; i++) {
    trailer->delete_before();
  }
  cout << "list: ";
  display_list(header, trailer);
  cout << endl;
  
  // Delete the first 5 nodes
  cout << "Delete the first 5 nodes" << endl;
  for (int i = 0; i < 5; i++) {
    header->delete_after();
  }
  cout << "list: ";
  display_list(header, trailer);
  
  return 0;
}
