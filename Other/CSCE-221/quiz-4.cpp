// sorting items from the heaviest to lightest
// by selecting the heaviest item at each time  

#include <iostream>
#include <vector>

using namespace std;

int comparisons = 0;

ostream& operator<<(ostream& out, vector<int>& v)
{
  // overload the output operator to display elements of v
  out << "[";
  for (int i = 0; i < v.size(); i++){
    out << v[i];
    if (i != v.size()-1)
      out << ", ";
  }
  out << "]\n";
  return out;
}

void sort_heaviest(vector<int>& v){

  //look up bubble or merge sort if you want to finish this
 
}

int main(){

  cout << "//////Test for vector v1 ///////////////////////////////"<< endl;
  vector<int> v1;
  v1.push_back(10);
  v1.push_back(9);
  v1.push_back(8);
  v1.push_back(7);
  v1.push_back(6);
  v1.push_back(5);
  v1.push_back(4);
  v1.push_back(3);
  v1.push_back(2);
  v1.push_back(1);

  cout << "initial vector v1:\n";
  // use overloaded output operator to display vector's elements
  // use comma to separate the vector's elements
  cout << v1;
  cout << endl;
  // call the sorting function for vector v 
  cout << "# of comparisons to sort v1: " << comparisons << endl << endl;
  cout << "vector v1 after sorting:\n";
  // use overloaded output operator to display elements of sorted vector
  // use comma to separate the vector's elements
  sort_heaviest(v1);
  cout << v1;
  cout << endl;
  
  cout << "//////Test for vector v2 ///////////////////////////////"<< endl;
  vector<int> v2;
  v2.push_back(1);
  v2.push_back(2);
  v2.push_back(3);
  v2.push_back(4);
  v2.push_back(5);
  v2.push_back(6);
  v2.push_back(7);
  v2.push_back(8);
  v2.push_back(9);
  v2.push_back(10);

  cout << "initial vector v2:\n";
  // use overloaded output operator to display vector's elements
  // use comma to separate the vector's elements
  cout << v2;
  cout << endl;
   // call the sorting function for vector v2 
  cout << "# of comparisons to sort v2: " << comparisons << endl << endl;
  cout << "vector v2 after sorting:\n";
  // use overloaded output operator to display elements of sorted vector
  // use comma to separate the vector's elements
  sort_heaviest(v2);
  cout << v2;
  cout << endl;
    
}