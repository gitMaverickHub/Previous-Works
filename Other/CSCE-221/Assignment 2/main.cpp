#include <iostream>
#include <fstream>
#include "CPU_Job.h"
#include "linkedlist-mpq.h"
#include "vector-mpq.h"
#include "binaryheap-mpq.h"
#include <ctime>
using namespace std;

int main(){

    int ID;
    int Length;
    int Prior;

    //linkedlist<CPU_Job> JobList;
    //vectormpq<CPU_Job> JobList;
    binaryheapmpq<CPU_Job> JobList;

    /*Comment out the 2 JobLists you don't want to test and uncomment the
    one you do want to test to test the different MPQ classes*/

    clock_t t1, t2;
    t1 = clock(); // start
    //...

    ifstream in;
    in.open("SetSize1000.txt");            //Change the number of "SetSize#.txt to test different read-in files
    while(in >> ID >> Length >> Prior){
        CPU_Job Job(ID, Length, Prior);
        JobList.insert(Job);
    }
    in.close();

    CPU_Job temp;
    ofstream out;
    out.open("Output.txt");
    while(!JobList.is_empty()){
        temp = JobList.remove_min();
        for (; temp.length>0; temp.length--){   //Different format, same result as to what you are thinking
            out << "Job " << temp.ID << " with length " << temp.length << " and priority " << temp.prior << endl;
        }
    }
    out << "No more jobs to run";
    
    //...

    t2 = clock(); // stop
    double diff = (double)(t2 - t1)*1000/CLOCKS_PER_SEC;
    cout << "Timing: " << diff << " milisec" << endl; 

}
