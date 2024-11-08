#include <iostream>
#include <vector>
using namespace std;

template <typename T>
class vectormpq{
    private:
        vector<T> vec;
    public:
        T remove_min();
        bool is_empty();
        void insert(T data);
};

template <typename T>
T vectormpq<T>::remove_min(){
    if (is_empty()) return NULL;
    T removed = vec[0];
    vec.erase(vec.begin());
    return removed;
}

template <typename T>
bool vectormpq<T>::is_empty(){
    return vec.empty();
}

template <typename T>
void vectormpq<T>::insert(T data){
    int i = 0;
    if (vec.size() == 0 || vec[vec.size()-1] < data) vec.push_back(data);
    else {
        while (i < vec.size()-1 && vec[i] < data){
            i++;
        }
        vec.insert(vec.begin()+i, data);
    }
}