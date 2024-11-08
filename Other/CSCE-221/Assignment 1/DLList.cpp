// implementation of the DLList class

#include <stdexcept>
#include "DLList.h"


// extend runtime_error from <stdexcept>
struct EmptyDLList : public std::runtime_error {
  explicit EmptyDLList(char const* msg=nullptr): runtime_error(msg) {}
};

// // copy constructor
DLList::DLList(DLList& dll){    //runtime O(1)
  // Initialize the list
  header.next = &trailer;
  trailer.prev = &header;
  DLListNode* pointer = dll.header.next;
  DLListNode* ender = &(dll.trailer);
  while (pointer != ender){
    insert_last(pointer->obj);
    pointer = pointer->next;
  }
}

//move constructor
DLList::DLList(DLList&& dll){   //runtime O(1)
  header.next = dll.header.next;
  trailer.prev = dll.trailer.prev;
  dll.header.next = &dll.trailer;
  dll.trailer.prev = &dll.header;
}

// copy assignment operator
DLList& DLList::operator=(DLList& dll){   //runtime O(1)
  if (this == &dll) return *this;
  else {
    clear();
    header.next = &trailer;
    trailer.prev = &header;
    DLListNode* pointer = dll.header.next;
    DLListNode* ender = &(dll.trailer);
    while (pointer != ender){
      insert_last(pointer->obj);
      pointer = pointer->next;
    }
    return *this;
  }
}

//move assignment operator
DLList& DLList::operator=(DLList&& dll){    //runtime O(1)
  if (this == &dll) return *this;
  clear();
  header.next = dll.header.next;
  trailer.prev = dll.trailer.prev;
  dll.header.next = &dll.trailer;
  dll.trailer.prev = &dll.header;
  return *this;
}

//destructor
DLList::~DLList(){    //runtime O(n)
  clear();
}

void DLList::clear(){   //runtime O(n)
  DLListNode* head = header.next;
  while (head != &trailer){
    DLListNode* pointer = head;
    head = head->next;
    delete pointer;
  }
  header.next = &trailer;
  trailer.prev = &header;
}

// insert a new object as the first one
void DLList::insert_first(int obj){   //runtime O(1)
  DLListNode* pointer = new DLListNode(obj);
  pointer->next = header.next;
  header.next->prev = pointer;
  pointer->prev = &header;
  header.next = pointer;
}

// insert a new object as the last one
void DLList::insert_last(int obj){    //runtime O(1)
  DLListNode* pointer = new DLListNode(obj);
  pointer->prev = trailer.prev;
  trailer.prev->next = pointer;
  pointer->next = &trailer;
  trailer.prev = pointer;
}

// remove the first node from the list
int DLList::remove_first(){     //runtime O(1)
  int first = header.next->obj;
  DLListNode* remove = header.next;
  header.next->next->prev = &header;
  header.next = header.next->next;
  delete remove;
  return first;
}

// remove the last node from the list
int DLList::remove_last(){    //runtime O(1)
  int last = trailer.prev->obj;
  DLListNode* remove = trailer.prev;
  trailer.prev->prev->next = &trailer;
  trailer.prev = trailer.prev->prev;
  delete remove;
  return last;
}

// return the first object (do not remove)
int DLList::first() const{    //runtime O(1)
  return header.next->obj;
}

// return the last object (do not remove)
int DLList::last() const{   //runtime O(1)
  return trailer.prev->obj;
}

// insert a new node after the node p
void DLList::insert_after(DLListNode &p, int obj){  //runtime O(1)
  if (&p == &trailer){
    cout << "Can't insert after the trailer." << endl;
    return;
  }
  DLListNode* pointer = new DLListNode(obj);
  pointer->next = p.next;
  p.next->prev = pointer;
  pointer->prev = &p;
  p.next = pointer;
}

// insert a new node before the node p
void DLList::insert_before(DLListNode &p, int obj){   //runtime O(1)
  if (&p == &header){
    cout << "Can't insert before the header." << endl;
    return;
  }
  DLListNode* pointer = new DLListNode(obj);
  pointer->prev = p.prev;
  p.prev->next = pointer;
  pointer->next = &p;
  p.prev = pointer;
}

// remove the node after the node p
int DLList::remove_after(DLListNode &p){    //runtime O(1)
  if (&p == &trailer || &p == trailer.prev){
    cout << "Can't remove the trailer or after the trailer." << endl;
    throw EmptyDLList();
  }
  int removed = p.next->obj;
  DLListNode* erase = p.next;
  p.next = p.next->next;
  p.next->prev = &p;
  delete erase;
  return removed;
}

// remove the node before the node p
int DLList::remove_before(DLListNode &p){   //runtime O(1)
  if (&p == &header || &p == header.next){
    cout << "Can't remove the header or before the header." << endl;
    throw EmptyDLList();
  }
  int removed = p.prev->obj;
  DLListNode* erase = p.prev;
  p.prev = p.prev->prev;
  p.prev->next = &p;
  delete erase;
  return removed;
}

// output operator
ostream& operator<<(ostream& out, DLList& dll){   //runtime O(n)
  DLListNode* pointer = dll.getHeader().next;
  DLListNode* ender = dll.getTrailer().prev->next;
  while(pointer != ender){
    out << pointer->obj << ", ";
    pointer = pointer->next;
  }
  return out;
}