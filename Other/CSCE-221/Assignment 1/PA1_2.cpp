#include <iostream>
#include <vector>
#include <string>
#include "TemplatedDLList.h"
using namespace std;





//Record is the node element
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

ostream& operator<<(ostream& out, Record &r){       //runtime O(1)
    out << "\nTitle: " << r.title << "\nAuthor: " << r.author << "\nISBN: " << r.ISBN << "\nYear: " << r.year << "\nEdition: " << r.edition << "\n";
    return out;
}

bool operator<(const Record& r1, const Record& r2){  //runtime O(1)
    if (r1.title < r2.title) return true;
    else if (r1.title == r2.title && r1.edition < r2.edition) return true;
    else return false;
}





//Library Storage Management (LSM) is the vector of the doubly linked lists of the nodes
class LSM{
    private:
        vector< DLList<Record> > vec;
    public:
        bool exists(string &book_title);
        void insert(Record &r);
        vector<Record> find_all(string book_title);
        LSM() {DLList<Record> A;
                DLList<Record> B;
                DLList<Record> C;
                DLList<Record> D;
                DLList<Record> E;
                DLList<Record> F;
                DLList<Record> G;
                DLList<Record> H;
                DLList<Record> I;
                DLList<Record> J;
                DLList<Record> K;
                DLList<Record> L;
                DLList<Record> M;
                DLList<Record> N;
                DLList<Record> O;
                DLList<Record> P;
                DLList<Record> Q;
                DLList<Record> R;
                DLList<Record> S;
                DLList<Record> T;
                DLList<Record> U;
                DLList<Record> V;
                DLList<Record> W;
                DLList<Record> X;
                DLList<Record> Y;
                DLList<Record> Z;
                vec.push_back(A);
                vec.push_back(B);
                vec.push_back(C);
                vec.push_back(D);
                vec.push_back(E);
                vec.push_back(F);
                vec.push_back(G);
                vec.push_back(H);
                vec.push_back(I);
                vec.push_back(J);
                vec.push_back(K);
                vec.push_back(L);
                vec.push_back(M);
                vec.push_back(N);
                vec.push_back(O);
                vec.push_back(P);
                vec.push_back(Q);
                vec.push_back(R);
                vec.push_back(S);
                vec.push_back(T);
                vec.push_back(U);
                vec.push_back(V);
                vec.push_back(W);
                vec.push_back(X);
                vec.push_back(Y);
                vec.push_back(Z);}
};

bool LSM::exists(string &book_title){       //runtime O(n)
    char FirstCharacter = book_title[0];
    int i = (int)(FirstCharacter) - 65; 
    DLListNode<Record>* traversal = vec[i].getHeader().next; 
    DLListNode<Record>* ender = vec[i].getTrailer().prev->next;
    while (traversal != ender){
        if (book_title == traversal->obj.title) {
            return true;
        }
        traversal = traversal->next;
    }
    return false;
}

void LSM::insert(Record &r){        //runtime O(n)
    char FirstCharacter = r.title[0];
    int i = (int)(FirstCharacter) - 65;
    DLListNode<Record>* new_pointer = new DLListNode<Record>(r);
    DLListNode<Record>* traversal = vec[i].getHeader().next->prev;
    while (traversal != vec[i].getTrailer().prev->next){
        if (traversal->next == vec[i].getTrailer().prev->next || r < traversal->next->obj){
            new_pointer->next = traversal->next;
            traversal->next->prev = new_pointer;
            new_pointer->prev = traversal;
            traversal->next = new_pointer;
            return;
        }
        traversal = traversal->next;
    }
}

vector<Record> LSM::find_all(string book_title){        //runtime O(n)
    char FirstCharacter = book_title[0];
    int i = (int)(FirstCharacter) - 65;
    vector<Record> VectorOfBook;
    DLListNode<Record>* traversal = vec[i].getHeader().next;
    while (traversal != vec[i].getTrailer().prev->next){
        if (book_title == traversal->obj.title){
            VectorOfBook.push_back(traversal->obj);
        }
        traversal = traversal->next;
    }
    return VectorOfBook;
}





int main(){
    
    LSM System;

    char tester = 'a';

    while (tester != 'q'){
        cout << "\nEnter the title of the book you are looking for.\n\n";
        string BookTitle;
        getline(cin, BookTitle);
        if (System.exists(BookTitle)){
            vector<Record> AllBooks = System.find_all(BookTitle);
            for (int i = 0; i < AllBooks.size(); i++){
                cout << AllBooks[i] << "\n";
            }
            cout << "Which edition would you like to pick?\n\n";
            string BookEdition;
            getline(cin, BookEdition);
            bool found = false;
            for (int i = 0; i < AllBooks.size(); i++){
                if (BookEdition == AllBooks[i].edition){
                    cout << AllBooks[i];
                    found = true;
                }
            }
            if (!found){
                cout << "This edition could not be found. Please add more information so it can be added to the LSM.\nPlease enter the ISBN.\n\n";
                string BookISBN;
                getline(cin, BookISBN);
                Record Book(BookTitle, AllBooks[0].author, BookISBN, AllBooks[0].year, BookEdition);
                System.insert(Book);
                cout << Book << "\n";
            }
        }
        else {
            cout << "\nThat title could not be found. Please enter information to update the LSM.\nEnter the author's name.\n\n";
            string BookAuthor;
            getline(cin, BookAuthor);
            cout << "\nEnter the ISBN number.\n\n";
            string BookISBN;
            getline(cin, BookISBN);
            cout << "\nEnter the year.\n\n";
            string BookYear;
            getline(cin, BookYear);
            cout << "\nEnter the edition.\n\n";
            string BookEdition;
            getline(cin, BookEdition);
            Record Book(BookTitle, BookAuthor, BookISBN, BookYear, BookEdition);
            System.insert(Book);
            cout << Book << "\n";
        }
        cout << "Press q to quit or any other character to continue.\n";
        cin >> tester;

        cin.ignore();
    }

    return 0;

}