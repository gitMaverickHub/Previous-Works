#include <iostream>
using namespace std;

struct CPU_Job{
    int ID;
    int length;
    int prior;
    CPU_Job(int a = 0, int b = 0, int c = 0) : ID(a), length(b), prior(c) {}
    bool operator<(CPU_Job &Job){
        if (this->prior < Job.prior) return true;  //"this" pointer  is implicit in linkedlist::remove_min() if you want another example how to do this
        else if (this->prior == Job.prior) return this->ID < Job.ID;
        else return false;
    }
};