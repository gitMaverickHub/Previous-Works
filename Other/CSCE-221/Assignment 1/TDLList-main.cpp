// testing the templated class DLList

#include <iostream>
#include <string>
#include <cstdio>
#include <sstream>

#include "TemplatedDLList.h"

using namespace std;

int main ()
{
  // Construct a linked list with header & trailer
  cout << "Create a new list" << endl;
  DLList<string> dll;
  cout << "list: " << dll << endl << endl;

  cout << "Insert 10 nodes at back with value 10,20,30,..,100" << endl;
  for (int i=10; i<=100; i+=10) {
    stringstream ss;
    ss << i;
    dll.insert_last(ss.str());
  }
  cout << "list: " << dll << endl << endl;

  cout << "Insert 10 nodes at front with value 10,20,30,..,100" << endl;
  for (int i=10; i<=100; i+=10) {
    stringstream ss;
    ss << i;
    dll.insert_first(ss.str());
  }
  cout << "list: " << dll << endl << endl;
  
  cout << "Copy to a new list" << endl;
  DLList<string> dll2(dll);
  cout << "list2: " << dll2 << endl << endl;
  
  cout << "Assign to another new list" << endl;
  DLList<string> dll3;
  dll3 = dll;
  cout << "list3: " << dll3 << endl << endl;
  
  cout << "Delete the last 10 nodes" << endl;
  for (int i=0; i<10; i++) {
    dll.remove_last();
  }
  cout << "list: " << dll << endl << endl;
  
  cout << "Delete the first 10 nodes" << endl;
  for (int i=0; i<10; i++) {
    dll.remove_first();
  }
  cout << "list: " << dll << endl << endl;
  
  // Check the other two lists
  cout << "Make sure the other two lists are not affected." << endl;
  cout << "list2: " << dll2 << endl;
  cout << "list3: " << dll3 << endl << endl;

  // more testing...
  // add tests for insert_after, insert_before
  // add tests for remove_after, remove_before

  DLListNode<string>* add1 = dll2.getHeader().next;

  dll2.insert_after(*add1, "95");

  cout << "Insert after the first node." << endl;
  cout << "list2: " << dll2 << endl << endl;

  DLListNode<string>* add2 = dll2.getTrailer().prev;

  dll2.insert_before(*add2, "95");

  cout << "Insert before the last node." << endl;
  cout << "list2: " << dll2 << endl << endl;

  DLListNode<string>* subtract1 = dll3.getHeader().next;

  dll3.remove_after(*subtract1);

  cout << "Remove after the first node." << endl;
  cout << "list3: " << dll3 << endl << endl;

  DLListNode<string>* subtract2 = dll3.getTrailer().prev;

  dll3.remove_before(*subtract2);

  cout << "Remove before the last node." << endl;
  cout << "list3: " << dll3 << endl << endl;
  
  return 0;
}
