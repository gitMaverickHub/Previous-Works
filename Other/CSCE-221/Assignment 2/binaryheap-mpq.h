#include <iostream>
#include <vector>
#include <math.h>
using namespace std;

template <typename T>
class binaryheapmpq{
    private:
        vector<T> vec;
    public:
        T remove_min();
        bool is_empty();
        void insert(T data);
        void flip(T &x, T &y);
};

template <typename T>
T binaryheapmpq<T>::remove_min(){
    if (is_empty()) return NULL;
    T removed = vec[0];
    flip(vec[0], vec[vec.size()-1]);
    vec.pop_back();
    int i = 0;
    while (i*2+1 < vec.size() && (vec[i*2+1] < vec[i] || (i*2+2 < vec.size() && vec[i*2+2] < vec[i]))){
        if (vec.size() <= i*2+2 || vec[i*2+1] < vec[i*2+2]){
            flip(vec[i], vec[i*2+1]);
            i = i*2+1;
        }
        else{
            flip(vec[i], vec[i*2+2]);
            i = i*2+2;
        }
    }
    return removed;
}

template <typename T>
bool binaryheapmpq<T>::is_empty(){
    return vec.empty();
}

template <typename T>
void binaryheapmpq<T>::insert(T data){              //vec[floor((i-1)/2)] is the parent
    vec.push_back(data);
    int i = vec.size()-1;
    while(i != 0 && vec[i] < vec[floor((i-1)/2)]){
        flip(vec[i], vec[floor((i-1)/2)]);
        i = floor((i-1)/2);
    }
}

template <typename T>
void binaryheapmpq<T>::flip(T &x, T &y){
    T temp = x;
    x = y;
    y = temp;
}