#include <iostream>
#include <vector>
#include <string>
#include <fstream>
using namespace std;

class Record{
    public:
        string title;
        string author;
        string ISBN;
        string year;
        string edition;
        Record (string name = "BLANK", string writer = "BLANK", string serial = "BLANK", string date = "BLANK", string version = "BLANK") : 
            title(name), author(writer), ISBN(serial), year(date), edition(version) {}
};

istream& operator>>(istream& in, Record &r){    //runtime O(1)
    string unused_line;
    getline(in, r.title);
    getline(in, r.author);
    getline(in, r.ISBN);
    getline(in, r.year);
    getline(in, r.edition);
    getline(in, unused_line);
    return in;
}

ostream& operator<<(ostream& out, Record &r){       //runtime O(1)     
    out << "\n" << r.title << "\n" << r.author << "\n" << r.ISBN << "\n" << r.year << "\n" << r.edition << "\n";
    return out;
}

bool operator<(const Record& r1, const Record& r2){     //runtime O(1)
    if (r1.title == r2.title && r1.author == r2.author && r1.ISBN == r2.ISBN) return true;
    else return false;
}

int main(){

    ifstream Book;
    Book.open("Book.txt");

    vector<Record> VectorOfBooks;
    Record temp;

    int i = 0;
    while(!Book.eof()){
        Book >> temp;
        VectorOfBooks.push_back(temp);
        i++;
    }

    Book.close();

    for(int i = 0; i < VectorOfBooks.size(); i++){
        cout << VectorOfBooks[i];
    }
    
}