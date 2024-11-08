#include <iostream>
using namespace std;

template <typename T>
struct LL_CPU_Job{
    T Node;
    LL_CPU_Job<T>* next;
    LL_CPU_Job(T elem) : Node(elem), next(nullptr) {}
};

template <typename T>
class linkedlist{
    private:
        LL_CPU_Job<T>* head;
    public:
        linkedlist() : head(nullptr) {}
        T remove_min();
        bool is_empty();
        void insert(T new_node); 
};

template <typename T>
T linkedlist<T>::remove_min(){
    if (is_empty()) return NULL;
    T removed = head->Node;
    LL_CPU_Job<T>* temp = head;
    head = head->next;
    delete temp;
    return removed;
}

template <typename T>
bool linkedlist<T>::is_empty(){
    return head == nullptr;
}

template <typename T>
void linkedlist<T>::insert(T new_node){
    LL_CPU_Job<T>* thing = new LL_CPU_Job<T>(new_node);
    LL_CPU_Job<T>* temp = head;
    LL_CPU_Job<T>* temp_trail = head;
    if(head == nullptr){
        head = thing;
        return;
    }
    if(new_node.operator<(head->Node)){
        thing->next = head;
        head = thing;
        return;
    }
    while(temp != nullptr && temp->Node < thing->Node){
        temp_trail = temp;
        temp = temp->next;
    }
    temp_trail->next = thing;
    thing->next = temp;
}