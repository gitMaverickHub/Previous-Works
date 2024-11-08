// header file for the templated DLList

#ifndef TEMPLATEDDLLIST_H
#define TEMPLATEDDLLIST_H

#include <iostream>
#include <stdexcept>

using namespace std;

// doubly linked list node
template <typename T>
struct DLListNode {
  T obj;
  DLListNode<T> *prev, *next;
  // constructor
  DLListNode(T e = T(), DLListNode *p = nullptr, DLListNode *n = nullptr)
    : obj(e), prev(p), next(n) {}
};

// doubly linked list class
template <typename T>
class DLList {
private:
  //DLListNode<T> header, trailer;
  void clear();
public:
  DLListNode<T> header, trailer;
  DLList() : header(T()), trailer(T()) // default constructor
  { header.next = &trailer; trailer.prev = &header; }
  DLList(const DLList<T>& dll); // copy constructor
  DLList(DLList&& dll); // move constructor
  ~DLList(); // destructor
  DLList<T>& operator=(DLList<T>& dll); // copy assignment operator
  DLList& operator=(DLList&& dll); // move assignment operator
  // return the pointer to the first node
  DLListNode<T> *first_node() const { return header.next; } 
  // return the pointer to the trailer
  const DLListNode<T> *after_last_node() const { return &trailer; }
  // return if the list is empty
  bool is_empty() const { return header.next == &trailer; }
  T first() const; // return the first object
  T last() const; // return the last object
  void insert_first(T obj); // insert to the first node
  T remove_first(); // remove the first node
  void insert_last(T obj); // insert to the last node
  T remove_last(); // remove the last node
  void insert_after(DLListNode<T> &p, T obj);
  void insert_before(DLListNode<T> &p, T obj);
  T remove_after(DLListNode<T> &p);
  T remove_before(DLListNode<T> &p);
  DLListNode<T> getHeader() const {return header;}
  DLListNode<T> getTrailer() const {return trailer;}
};

// extend runtime_error from <stdexcept>
struct EmptyDLList : public std::runtime_error {
  explicit EmptyDLList(char const* msg=nullptr): runtime_error(msg) {}
};

// // copy constructor
template <typename T>
DLList<T>::DLList(const DLList<T>& dll) {   //runtime O(1)
  // Initialize the list
  header.next = &trailer;
  trailer.prev = &header;
  DLListNode<T>* pointer = dll.header.next;
  DLListNode<T>* ender = dll.getTrailer().prev->next;
  while (pointer != ender){
    insert_last(pointer->obj);
    pointer = pointer->next;
  }
}

// move constructor
template <typename T>
DLList<T>::DLList(DLList<T>&& dll){   //runtime O(1)
  header.next = dll.header.next;
  trailer.prev = dll.trailer.prev;
  dll.header.next = &dll.trailer;
  dll.trailer.prev = &dll.header;
}

// // copy assignment operator
template <typename T>
DLList<T>& DLList<T>::operator=(DLList<T>& dll){    //runtime O(1)
  if (this == &dll) return *this;
  header.next = &trailer;
  trailer.prev = &header;
  DLListNode<T>* pointer = dll.header.next;
  DLListNode<T>* ender = &(dll.trailer);
  while (pointer != ender){
    insert_last(pointer->obj);
    pointer = pointer->next;
  }
  return *this;
}

// move assignment operator
template <typename T>
DLList<T>& DLList<T>::operator=(DLList<T>&& dll){   //runtime O(1)
  if (this == &dll) return *this;
  clear();
  header.next = dll.header.next;
  trailer.prev = dll.trailer.prev;
  dll.header.next = &dll.trailer;
  dll.trailer.prev = &dll.header;
  return *this;
}

template <typename T>
DLList<T>::~DLList(){   //runtime O(n)
  clear();
}

template <typename T>
void DLList<T>::clear(){    //runtime O(n)
  DLListNode<T>* head = header.next;
  while (head != &trailer){
    DLListNode<T>* pointer = head;
    head = head->next;
    delete pointer;
  }
  header.next = &trailer;
  trailer.prev = &header;
}

// insert a new object as the first one
template <typename T>
void DLList<T>::insert_first(T obj){    //runtime O(1)
  DLListNode<T>* pointer = new DLListNode<T>(obj);
  pointer->next = header.next;
  header.next->prev = pointer;
  pointer->prev = &header;
  header.next = pointer;
}

// insert a new object as the last one
template <typename T>
void DLList<T>::insert_last(T obj){   //runtime O(1)
  DLListNode<T>* pointer = new DLListNode<T>(obj);
  pointer->prev = trailer.prev;
  trailer.prev->next = pointer;
  pointer->next = &trailer;
  trailer.prev = pointer;
}

// remove the first node from the list
template <typename T>
T DLList<T>::remove_first(){    //runtime O(1)
  T first = header.next->obj;
  DLListNode<T>* remove = header.next;
  header.next->next->prev = &header;
  header.next = header.next->next;
  delete remove;
  return first;
}

// remove the last node from the list
template <typename T>
T DLList<T>::remove_last(){   //runtime O(1)
  T last = trailer.prev->obj;
  DLListNode<T>* remove = trailer.prev;
  trailer.prev->prev->next = &trailer;
  trailer.prev = trailer.prev->prev;
  delete remove;
  return last;
}

// return the first object (do not remove)
template <typename T>
T DLList<T>::first() const{   //runtime O(1)
  return header.next->obj;
}

// return the last object (do not remove)
template <typename T>
T DLList<T>::last() const{    //runtime O(1)
  return trailer.prev->obj;
}

// insert a new node after the node p
template <typename T>
void DLList<T>::insert_after(DLListNode<T> &p, T obj){    //runtime O(1)
  if (&p == &trailer){
    cout << "Can't insert after the trailer." << endl;
    return;
  }
  DLListNode<T>* pointer = new DLListNode<T>(obj);
  pointer->next = p.next;
  p.next->prev = pointer;
  pointer->prev = &p;
  p.next = pointer;
}

// insert a new node before the node p
template <typename T>
void DLList<T>::insert_before(DLListNode<T> &p, T obj){   //runtime O(1)
  if (&p == &header){
    cout << "Can't insert before the header." << endl;
    return;
  }
  DLListNode<T>* pointer = new DLListNode<T>(obj);
  pointer->prev = p.prev;
  p.prev->next = pointer;
  pointer->next = &p;
  p.prev = pointer;
}

// remove the node after the node p
template <typename T>
T DLList<T>::remove_after(DLListNode<T> &p){    //runtime O(1)
  if (&p == &trailer || &p == trailer.prev){
    cout << "Can't remove the trailer or after the trailer." << endl;
    throw EmptyDLList();
  }
  T removed = p.next->obj;
  p.next = p.next->next;
  p.next->prev = &p;
  return removed;
}

// remove the node before the node p
template <typename T>
T DLList<T>::remove_before(DLListNode<T> &p){   //runtime O(1)
  if (&p == &header || &p == header.next){
    cout << "Can't remove the header or before the header." << endl;
    throw EmptyDLList();
  }
  T removed = p.prev->obj;
  p.prev = p.prev->prev;
  p.prev->next = &p;
  return removed;
}
  

// output operator
template <typename T>
ostream& operator<<(ostream& out, const DLList<T>& dll){    //runtime O(n)
  DLListNode<T>* pointer = dll.getHeader().next;
  DLListNode<T>* ender = dll.getTrailer().prev->next;
  while(pointer != ender){
    out << pointer->obj << ", ";
    pointer = pointer->next;
  }
  return out;
}

#endif
